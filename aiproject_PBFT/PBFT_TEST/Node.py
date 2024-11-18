import argparse
import asyncio
import logging
import time
from fastapi import FastAPI, WebSocket, websockets
from enum import Enum
import pandas as pd
import uvicorn
import yaml

# 消息
class Message:
    @staticmethod
    def information(id):
        return {
            "id": id,
            "message": f"this is {id}"
        }

# 节点信息
class Node:
    def __init__(self, idx = None, id = None, host = None, port = None, role = None, information = None, last_sync_time = None ,websocket = None):
        self.idx = idx                  # 当前节点索引
        self.id = id                    # 节点ID : 共识节点签名公钥和共识节点唯一标识, 一般是64字节二进制串
        self.host = host
        self.port = port
        self.role = role
        self.information = information
        self.websocket = websocket
        self.last_sync_time = last_sync_time

    def __str__(self) -> str:
        return f"你好, id: {self.id}  idx: {self.idx}, host_port: {self.host}_{self.port} information: {self.information}"

class NodeRole(Enum):
    PRIMARY = "Primary"
    REPLICA = "Replica"
    OBSERVER = "Observer"

# 其它节点
otherNodes = {}

# 最大人数限制
MaximumNumberLimit = 10

# 第几轮
Round = 0

logger = logging.getLogger("uvicorn.error")
# logger.handlers = []




# 开始的时候, 首先找到自己认识的节点, 并且同步通讯录
async def syncOtherNode(node: Node):
    try:
        # 如果节点一直尚未进行连接, 则进行连接
        if node.websocket is None:
            logger.info(f"ws://{node.host}:{node.port}/ws连接成功...")
            async with websockets.connect(f"ws://{node.host}:{node.port}/ws") as websocket:
                logger.info(f"ws://{node.host}:{node.port}/ws连接成功...")
                node.websocket = websocket

                # 发送消息
                await websocket.send(Message.giveMeNodes())

                # 记录最后连接的时间
                node.last_connect_time = time.time()

                # 接收消息
                response = await websocket.recv()

                # 收到其它新节点的列表信息, 将其加入到otherNodes列表中
                if response['type'] == "response_giveMeNodes":
                    return response["data"]["nodes"]
    except websockets.exceptions.ConnectionClosedError:
        # 断开的话, websocket = None
        node.websocket = None
        print("Connection closed. Attempting to reconnect...")

# 批量同步节点
async def batchSyncOtherNodes(nodes):
    global otherNodes

    # 初始化
    for i in nodes:
        # 如果节点信息不存在otherNodes 则加入到列表中
        otherNodes[i["id"]] = Node(
            id=i["id"],
            # idx=i["idx"],
            host=i["host"],
            port=i["port"],
            # role=i["role"]
        )

    while True:
        # 同步节点, 使当前节点保持连接
        tasks = [syncOtherNode(otherNodes[key]) for key in otherNodes]
        everyNodeResult = await asyncio.gather(*tasks)

        # 扁平化
        df = pd.DataFrame(everyNodeResult)
        flat_list = df.stack().tolist()

        for nodeInfo in flat_list:
            # 如果节点信息不存在otherNodes 则加入到列表中
            if nodeInfo["id"] not in otherNodes:
                otherNodes[nodeInfo["id"]] = Node(
                    id=nodeInfo["id"],
                    idx=nodeInfo["idx"],
                    host=nodeInfo["host"],
                    port=nodeInfo["port"],
                    role=nodeInfo["role"],
                    last_sync_time=time.time()
                )
            else:
                if time.time() - otherNodes[nodeInfo["id"]]['last_sync_time'] > 1:
                    pnote = otherNodes[nodeInfo["id"]]
                    pnote.id = nodeInfo["id"]
                    pnote.idx = nodeInfo["idx"]
                    pnote.host = nodeInfo["host"]
                    pnote.port = nodeInfo["port"]
                    pnote.role = nodeInfo["role"]
                    pnote.last_sync_time = time.time()

        # 每隔3秒 同步一次通信录
        await asyncio.sleep(1)
        logger.info("倒计时...1")
        await asyncio.sleep(1)
        logger.info("倒计时...2")
        await asyncio.sleep(1)
        logger.info("倒计时...3")





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
conf = conf_parse(args.config)

app = FastAPI()

@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    while True:
        data = await websocket.receive_text()
        await websocket.send_text(conf["listen"]["information"])

@app.get("/")
async def root():
    return {"nodes": otherNodes}

async def main():
    # 定时同步其它节点任务
    task1 = asyncio.create_task(batchSyncOtherNodes(conf["nodes"]))

    config = uvicorn.Config(app, host=conf["listen"]["host"], port=conf["listen"]["port"])
    server = uvicorn.Server(config)

    await server.serve()
    # await task1

asyncio.run(main())
