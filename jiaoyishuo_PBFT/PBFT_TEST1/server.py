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
    def __init__(self, websocket: ServerConnection, id):
        self.websocket = websocket
        self.id = id

    async def handle(self):
        while True:
            message = await self.websocket.recv()
            client_ip, client_port =self.websocket.remote_address

            print(f"我是{config['listen']['id']}, 我收到{self.id}的消息: \"{message}\"")
            # await self.websocket.send("回显: " + message)


# 已经连接的节点数量
active_connected_nodes: dict[str, ServerNode] = {}
nodes: dict[str, ServerNode] = {}
websocket_list: dict[str, ServerNode] = {}

# 建立连接
async def connection(websocket: ServerConnection):
    try:
        # 连接后自报家门
        message = json.dumps({
            "code": 200,
            "message": "自报家门",
            "data": {
                "id": config["listen"]["id"],
                "type": "node",
                "information": config["listen"]["information"]
            }
        })
        await websocket.send(message)

        # 收到消息
        message = await websocket.recv()
        connect_info = json.loads(message)

        data = connect_info.get("data", None)
        if data is None:
            return

        if data.get("id") in active_connected_nodes:
            # 此前连接过, 现在该ID又连, 所以拒绝
            await websocket.send(json.dumps({
                "code": 200,
                "message": f"该id此前已连接: {data['id']}"
            }))
            await websocket.close()
        elif data.get("id") in nodes:
            # 曾经连接过,但是后来断开了, 现在又来了
            nodes[data["id"]].websocket = websocket
            websocket_list[websocket.id] = nodes[data["id"]]

            active_connected_nodes[data["id"]] = nodes[data["id"]]
            await active_connected_nodes[data["id"]].handle()
        elif (data.get("type") == "node") and (data.get("id") is not None and data.get("id") not in nodes):
            # 将未曾连接过的节点,都保存起来
            nodes[data["id"]] = ServerNode(websocket, data["id"])

            # 以websocket_id为维度存储引用
            websocket_list[websocket.id] = nodes[data["id"]]

            # 以当前正在链接的节点为维度存储引用
            active_connected_nodes[data["id"]] = nodes[data["id"]]

            await active_connected_nodes[data["id"]].handle()
    except ConnectionRefusedError:
        print(f"无法连接服务器")
    except websockets.ConnectionClosedOK:
        # 移除节点列表的已经断开连接的节点
        del active_connected_nodes[websocket_list[websocket.id].id]
        # 移除socket列表
        del websocket_list[websocket.id]
        print("断开连接 - 正常退出")
    except websockets.ConnectionClosedError:
        # 移除节点列表的已经断开连接的节点
        del active_connected_nodes[websocket_list[websocket.id].id]
        # 移除socket列表
        del websocket_list[websocket.id]
        print("断开连接 - 错误断开")
    except json.decoder.JSONDecodeError:
        print("json解析错误")
    except Exception as e:
        print(f"报错: {e}")

# 服务端
async def server(host, port):
    def process_request(connection: ServerConnection, request: Request):
        if request.path == '/health':
            response = json.dumps({
                "code": 200,
                "message": f"当前连接节点: {len(active_connected_nodes)}"
            }, ensure_ascii=False)

            return connection.respond(HTTPStatus.OK, text=response)

    def process_response(connection, request, response):
        response.headers["Content-Type"] = "application/json"

    async with serve(connection, host, port, process_request=process_request, process_response=process_response):
        await asyncio.get_running_loop().create_future()

# 客户端
async def client(host, port):
    while True:
        async with connect(f"ws://{host}:{port}") as websocket:
            await connection(websocket)


async def sayHello():
    while True:
        await asyncio.sleep(3)
        # print(len(nodes.values()))
        # await nodes[0].websocket.send(f"hello: {time.time()}")
        for node in active_connected_nodes.values():
            print(f"正在发送给{node.id}当前时间")
            await node.websocket.send(f"当前时间: {time.time()}")
            # await asyncio.sleep(1)

async def main():
    serverTask = asyncio.create_task(server(config["listen"]["host"], config["listen"]["port"]))

    # 作为客户端, 连接其它节点
    tasks = [asyncio.create_task(client(nodeinfo["host"], nodeinfo["port"])) for nodeinfo in config["nodes"]]
    sayTask = asyncio.create_task(sayHello())

    await serverTask
    await asyncio.gather(*tasks)
    await sayTask

asyncio.run(main())







