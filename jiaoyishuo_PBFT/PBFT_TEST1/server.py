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

# 已经连接的节点数量
nodes = {}

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

# 服务端
async def server(host, port):
    async def handler(websocket: ServerConnection):
        try:
            # 收到对方的消息
            message = await websocket.recv()
            connect_info = json.loads(message)
            data = connect_info.get("data", None)
            if data is None:
                return

            if data.get("id") in nodes:
                await websocket.send(json.dumps({
                    "code": 200,
                    "message": "此前已连接过, 直接退出",
                }))
                await websocket.close()

            if data and (data.get("type") == "node") and (data.get("id") is not None and data.get("id") not in nodes):
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
                print(f"服务端发送: {message}")
                await websocket.send(message)

                print("加入到节点列表中")

                nodes[data["id"]] = ServerNode(websocket, data["id"])

                print(f"现在有: {len(nodes)} 个节点与你相连")

                await nodes[data["id"]].handle()

            print(f"此前已经成功连接, 随退出本次连接现在有: {len(nodes)} 个节点与你相连")
            await websocket.close()
        except websockets.ConnectionClosedOK:
            print("断开连接 - 正常退出")
        except websockets.ConnectionClosedError:
            print("断开连接 - 错误")
        except json.decoder.JSONDecodeError:
            print("json解析错误")
        except Exception as e:
            print(f"报错: {e}")

    def process_request(connection: ServerConnection, request: Request):
        if request.path == '/health':
            response = json.dumps({
                "code": 200,
                "message": f"当前连接节点: {len(nodes)}"
            }, ensure_ascii=False)

            return connection.respond(HTTPStatus.OK, text=response)

    def process_response(connection, request, response):
        response.headers["Content-Type"] = "application/json"

    async with serve(handler, host, port, process_request=process_request, process_response=process_response):
        await asyncio.get_running_loop().create_future()

# 客户端
async def client(host, port):
    async def client_handler(websocket: ServerConnection):
        # 收到对方的消息
        message = await websocket.recv()        
        print(f"客户端收到: {message}")
        connect_info = json.loads(message)

        data = connect_info.get("data", None)
        if data is None:
            return

        if data.get("id") in nodes:
            await websocket.send(json.dumps({
                "code": 200,
                "message": "此前已连接过, 直接退出",
            }))
            await websocket.close()

        if data is not None and (data.get("type") == "node") and (data.get("id") is not None and data.get("id") not in nodes):
            nodes[data["id"]] = ServerNode(websocket, data["id"])
            await nodes[data["id"]].handle()

    try:
        async with connect(f"ws://{host}:{port}") as websocket:
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
            print(f"客户端发送: {message}")
            await websocket.send(message)
            await client_handler(websocket)
            # await asyncio.get_running_loop().create_future()
    except ConnectionRefusedError:
        print(f"无法连接服务器: {host}:{port}")
    except websockets.ConnectionClosedOK:
        print("断开连接 - 正常退出")
    except websockets.ConnectionClosedError:
        print("断开连接 - 错误")
    except json.decoder.JSONDecodeError:
        print("json解析错误")
    except Exception as e:
        print(f"报错: {e}")


async def sayHello():
    while True:
        await asyncio.sleep(3)
        # print(len(nodes.values()))
        # await nodes[0].websocket.send(f"hello: {time.time()}")
        for node in nodes.values():
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







