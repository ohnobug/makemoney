import asyncio
import itertools
import time
from fastapi import WebSocket, websockets
import datetime
from enum import Enum

import pandas as pd

# 消息
class Message:
    @staticmethod
    def information(id):
        return {
            "id": id,
            "message": f"this is {id}"
        }

    @staticmethod
    def giveMeNodes():
        return {
            "type": "giveMeNodes"
        }

# 节点信息
class Node:
    def __init__(self, idx = None, id = None, ip = None, port = None, role = None, websocket = None):
        self.idx = idx  # 当前节点索引
        self.id = id    # 节点ID : 共识节点签名公钥和共识节点唯一标识, 一般是64字节二进制串
        self.ip = ip
        self.port = port
        self.role = role
        self.websocket = None

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

# 开始的时候, 首先找到自己认识的节点, 同步通讯录
async def synNode(node: Node):
    try:
        # 如果节点一直尚未进行连接, 则进行连接
        if node.websocket is None:
            async with websockets.connect(f"ws://{node.ip}:{node.port}/") as websocket:
                node.websocket = websocket

        # 发送消息
        await websocket.send(Message.giveMeNodes())

        # 接收消息
        response = await websocket.recv()

        # 收到其它新节点的列表信息, 将其加入到otherNodes列表中
        if response['type'] == "response_giveMeNodes":
            return response["data"]["nodes"]
    except websockets.exceptions.ConnectionClosedError:
        # 断开的话, websocket = None
        node.websocket = None
        print("Connection closed. Attempting to reconnect...")


async def main():
    # 同步节点, 使当前节点保持连接
    tasks = [synNode(otherNodes[key]) for key in otherNodes]
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
                id=nodeInfo["ip"],
                port=nodeInfo["port"],
                role=nodeInfo["role"]
            )

asyncio.run(main())
