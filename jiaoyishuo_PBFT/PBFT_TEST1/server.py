import argparse
import asyncio
from http import HTTPStatus
import json
import websockets
from websockets.http11 import Request, Response
from websockets.asyncio.server import serve, ServerConnection
from websockets.asyncio.client import connect
import yaml
import logging

# 解析参数
def arg_parse():
    # 解析命令行参数
    parser = argparse.ArgumentParser(description='PBFT Node')

    # 节点配置文件
    parser.add_argument('-c', '--config', default='pbft.yaml', type=argparse.FileType('r'), help='use configuration [%(default)s]')

    # 节点配置文件
    parser.add_argument('-l', '--log', default='node.log', type=str, help='use logger [%(default)s]')

    # 解析参数
    args = parser.parse_args()
    return args

# 配置解析器
def conf_parse(conf_file) -> dict:
    return yaml.load(conf_file, Loader=yaml.SafeLoader)

args = arg_parse()
logger = logging.getLogger('logger')
handler = logging.FileHandler(filename=args.log, mode="a", encoding="utf-8")
logger.addHandler(handler)
logger.setLevel(logging.INFO)

config = conf_parse(args.config)


class Node:
    def __init__(self, websocket: ServerConnection):
        self.websocket = websocket
        self.id = None
        self.information = None

    # 握手
    async def handshake(self):
        # 先自报家门
        await self.websocket.send(json.dumps({
            "code": 200,
            "message": "自报家门",
            "data": {
                "id": config["listen"]["id"],
                "type": "node_info",
                "information": config["listen"]["information"]
            }
        }))
        message = await self.websocket.recv()

        # 收到消息
        connect_info = json.loads(message)

        # 解析json包
        data = connect_info.get("data", None)

        if data is not None and data.get("type") == "node_info":
            if data.get("id") is None:
                raise ValueError("握手信息不正确, 对方未提供ID信息")

            if data.get("id") in nodeList.active_connected_nodes:
                raise ValueError("该ID此前曾连接")
            else:
                # 未曾连接过
                self.id = data.get("id")
                self.information = data.get("information")
                nodeList.add_node(self)
                logger.info(f"与{self.id}握手成功")
        else:
            raise ValueError("对方提供的握手类型不正确, 握手失败")

    # 处理消息
    async def handle(self):
        try:
            # 握手
            await self.handshake()

            # 开启定期同步新节点任务
            asyncio.create_task(self.give_me_more_other_node_info())

            while True:
                message = await self.websocket.recv()
                data = json.loads(message)

                if data["type"] == "other_nodes":                    
                    # 先过滤一波, 再考虑链接
                    logger.info(f"收到来自{self.id}的更多节点结果")
                    nodes = data["data"]
                    for nodeinfo in nodes:
                        # 如果ID等于本服务器 则直接跳过
                        if nodeinfo["id"] == config["listen"]["id"]:
                            continue
                        # 如果已曾连接 则跳过
                        if nodeinfo["id"] in nodeList.active_connected_nodes:
                            continue
                        # 未曾连接 则尝试连接
                        asyncio.create_task(client(nodeinfo["host"], nodeinfo["port"]))
                elif data["type"] == "give_me_more_other_node_info":
                    await self.websocket.send(json.dumps({
                        "type": "other_nodes",
                        "data": nodeList.get_all_nodes()
                    }))

        except ConnectionRefusedError:
            logger.info(f"无法连接服务器")
        except websockets.ConnectionClosedOK:
            await self.close()
            logger.info("断开连接 - 正常退出")
        except websockets.ConnectionClosedError:
            await self.close()
            logger.info("断开连接 - 错误断开")
        except json.decoder.JSONDecodeError:
            await self.close()
            logger.info(f"json解析错误")
        except Exception as e:
            await self.close()
            logger.info(f"报错: {e}")

    # 定期向对方获取更多关于其它节点的信息
    async def give_me_more_other_node_info(self):
        while True:
            await asyncio.sleep(5)
            await self.websocket.send(json.dumps({
                "type": "give_me_more_other_node_info"
            }))

    # 关闭连接
    async def close(self):
        await nodeList.close(self)

    # 得到该节点消息
    def info(self):
        return {
            "id": self.id,
            "information": self.information,
            "host": self.websocket.remote_address[0],
            "port": self.websocket.remote_address[1],
        }


# 节点池
class NodePool:
    # 以节点id为维度的节点, 且正在连接的节点
    active_connected_nodes: dict[str, Node] = {}

    # 以websocket_id为维度的节点, 且正在连接的节点
    websocket_list: dict[str, Node] = {}

    # 添加节点
    def add_node(self, node: Node):
        self.active_connected_nodes[node.id] = node
        self.websocket_list[node.websocket.id] = node

    # 删除
    async def close(self, node: Node):
        await node.websocket.close()
        self.active_connected_nodes.pop(node.id, None)
        self.active_connected_nodes.pop(node.websocket.id, None)

    # 得到所有节点
    def get_all_nodes(self):
        output = []
        for node in self.active_connected_nodes.values():
            output.append({
                "id": node.id,
                "host": node.websocket.remote_address[0],
                "port": node.websocket.remote_address[1],
                "information": node.information,
            })
        return output

    # 获取长度
    def __len__(self):
        return len(self.active_connected_nodes)

nodeList = NodePool()


# 服务端
async def server(host, port):
    def process_request(connection: ServerConnection, request: Request):
        if request.path == '/health':
            response = json.dumps({
                "code": 200,
                "message": f"当前连接节点: {len(nodeList.active_connected_nodes)}",
                "data": nodeList.get_all_nodes()
            }, ensure_ascii=False)

            return connection.respond(HTTPStatus.OK, text=response)

    def process_response(connection: ServerConnection, request: Request, response: Response):
        response.headers["Content-Type"] = "application/json"

    async def handler(websocket):
        logger.info(f"客户进入: {websocket.local_address[0]}:{websocket.local_address[1]:<6} => {websocket.remote_address[0]}:{websocket.remote_address[1]:<6}...")
        await Node(websocket).handle()

    async with serve(handler, host, port, process_request=process_request, process_response=process_response):
        await asyncio.get_running_loop().create_future()

# 客户端
async def client(host, port):
    for _ in range(5):
        try:
            async with connect(f"ws://{host}:{port}") as websocket:
                logger.info(f"建立连接: {websocket.local_address[0]}:{websocket.local_address[1]:<6} => {websocket.remote_address[0]}:{websocket.remote_address[1]:<6}...")
                await Node(websocket).handle()
        except ConnectionRefusedError:
            logger.info("无法连接服务器!!! 1秒后自动重连" + f"ws://{host}:{port}")

async def main():
    # 启动服务器
    serverTask = asyncio.create_task(server(config["listen"]["host"], config["listen"]["port"]))

    # 作为客户端, 连接其它节点
    reconnect_nodes = config["nodes"]
    if reconnect_nodes:
        tasks = [asyncio.create_task(client(nodeinfo["host"], nodeinfo["port"])) for nodeinfo in reconnect_nodes]

    await serverTask

asyncio.run(main())
