import argparse
import asyncio
from http import HTTPStatus
import json
import time
import websockets
from websockets.http11 import Request, Response
from websockets.asyncio.server import serve, ServerConnection
from websockets.asyncio.client import connect
import yaml

# 解析参数
def arg_parse():
    # 解析命令行参数
    parser = argparse.ArgumentParser(description='PBFT Node')

    # 节点配置文件
    parser.add_argument('-c', '--config', default='pbft.yaml', type=argparse.FileType('r'), help='use configuration [%(default)s]')

    # 解析参数
    args = parser.parse_args()
    return args

# 配置解析器
def conf_parse(conf_file) -> dict:
    return yaml.load(conf_file, Loader=yaml.SafeLoader)

args = arg_parse()
config = conf_parse(args.config)

class ServerNode:
    def __init__(self, websocket: ServerConnection):
        self.websocket = websocket
        self.id = None

    # 收到对方消息
    async def receive_peer_info(self, data):
        if data.get("id") is None:
            return

        self.id = data.get("id")
        if self.id in active_connected_nodes:
            print("该ID此前曾连接, 主动断开.", end="\n")
            # 不能调用self.close() 会清理掉正在连接的socket
            await self.websocket.close()
        else:
            # 未曾连接过
            active_connected_nodes[self.id] = self
            websocket_list[str(self.websocket.id)] = self
            print(f"握手成功")

    async def handle(self):
        try:
            # 连接后自报家门
            message = json.dumps({
                "code": 200,
                "message": "自报家门",
                "data": {
                    "id": config["listen"]["id"],
                    "type": "node_info",
                    "information": config["listen"]["information"]
                }
            })
            await self.websocket.send(message)
            message = await self.websocket.recv()

            # 收到消息
            connect_info = json.loads(message)

            # 解析json包
            data = connect_info.get("data", None)

            if data is not None and data.get("type") == "node_info":
                await self.receive_peer_info(data)
            else:
                print("打招呼失败, 收到非同类数据")
                self.websocket.close()

            while True:
                message = await self.websocket.recv()
                print(f"收到来自{self.id}的消息: {message}")

        except ConnectionRefusedError:
            print(f"无法连接服务器")
        except websockets.ConnectionClosedOK:
            print("断开连接 - 正常退出")
        except websockets.ConnectionClosedError:
            await self.close()
            print("断开连接 - 错误断开")
        except json.decoder.JSONDecodeError:
            print(f"json解析错误")
        except Exception as e:
            print(f"报错: {e}")

    async def close(self):
        active_connected_nodes.pop(self.id, None)
        websocket_list.pop(str(self.websocket.id), None)
        await self.websocket.close()


# 以节点id为维度的节点, 且正在连接的节点
active_connected_nodes: dict[str, ServerNode] = {}

# 以websocket_id为维度的节点, 且正在连接的节点
websocket_list: dict[str, ServerNode] = {}

# 服务端
async def server(host, port):
    def process_request(connection: ServerConnection, request: Request):
        if request.path == '/health':
            response = json.dumps({
                "code": 200,
                "message": f"当前连接节点: {len(active_connected_nodes)}"
            }, ensure_ascii=False)

            return connection.respond(HTTPStatus.OK, text=response)

    def process_response(connection: ServerConnection, request: Request, response: Response):
        response.headers["Content-Type"] = "application/json"

    async def handler(websocket):
        print(f"客户进入:{websocket.remote_address[0]}:{websocket.remote_address[1]}...", end="")
        await ServerNode(websocket).handle()

    async with serve(handler, host, port, process_request=process_request, process_response=process_response):
        await asyncio.get_running_loop().create_future()

# 客户端
async def client(host, port):
    while len(websocket_list) == 0:
        try:
            async with connect(f"ws://{host}:{port}") as websocket:
                print(f"建立连接:{websocket.remote_address[0]}:{websocket.remote_address[1]}...", end="")
                await ServerNode(websocket).handle()
        except ConnectionRefusedError:
            print("无法连接服务器!!! 1秒后自动重连" + f"ws://{host}:{port}")
            await asyncio.sleep(1)

async def sayHello():
    while True:
        await asyncio.sleep(1)
        for node in active_connected_nodes.values():
            print(f"给{node.id} 正在发送当前时间")
            await node.websocket.send(json.dumps({
                    "code": 200,
                    "data": f"我是{config['listen']['id']}, 当前时间: {time.time()}"
                }))

async def main():
    reconnect_nodes = config["nodes"]

    serverTask = asyncio.create_task(server(config["listen"]["host"], config["listen"]["port"]))

    # 作为客户端, 连接其它节点
    tasks = [asyncio.create_task(client(nodeinfo["host"], nodeinfo["port"])) for nodeinfo in reconnect_nodes]
    sayTask = asyncio.create_task(sayHello())

    await serverTask
    await asyncio.gather(*tasks)
    await sayTask

asyncio.run(main())
