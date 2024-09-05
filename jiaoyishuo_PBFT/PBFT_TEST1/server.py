import argparse
import asyncio
import json
import websockets
from websockets.asyncio.server import serve
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





nodes = {}

class ServerNode:
    def __init__(self, websocket):
        self.websocket = websocket
        print(websocket)

    async def handle(self):
        while True:
            message = await self.websocket.recv()
            print("收到")
            await self.websocket.send("回显: " + message)


# 服务端
async def server(host, port):
    async def handler(websocket):
        try:
            # 收到对方的消息
            message = await websocket.recv()

            connect_info = json.loads(message)

            print(f"服务器收到信息: {connect_info}")

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

                nodes[data["id"]] = ServerNode(websocket)

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

    async with serve(handler, host, port):
        await asyncio.get_running_loop().create_future()

# 客户端
async def client(host, port):
    async def client_handler(websocket):
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
            nodes[data["id"]] = ServerNode(websocket)
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

async def main():
    serverTask = asyncio.create_task(server(config["listen"]["host"], config["listen"]["port"]))

    # 作为客户端, 连接其它节点
    tasks = [asyncio.create_task(client(nodeinfo["host"], nodeinfo["port"])) for nodeinfo in config["nodes"]]

    await serverTask
    await asyncio.gather(*tasks)


asyncio.run(main())







