import asyncio
import json
from hashlib import sha256
import websockets
from websockets.asyncio.server import serve, ServerConnection
import Session

# 用户列表
allUserList = {}

# 会话列表
sessionList = {}

# 消费者
async def consumer(queue):
    while True:
        item = await queue.get()
        if item['type'] == "live":
            userData = item['data']
            allUserList[userData['account']] = userData
            print("加入用户成功, 当前用户数量:{}".format(len(allUserList)))
        elif item['type'] == "leave":
            userData = item['data']
            del allUserList[userData['account']]
            print("删除用户成功, 当前用户数量:{}".format(len(allUserList)))
        queue.task_done()

async def echo(websocket: ServerConnection, queue):
    try:
        account = None
        async for message in websocket:
            data = message
            jsonData = json.loads(data)

            # 上线
            if jsonData['type'] == "live":
                # 用户进入(缺: 查询过程, 得到用户信息)
                # 需要考虑内网情况
                # 服务器有义务帮忙寻找其它服务器同步用户的最新信息.

                account = jsonData["data"]["account"]
                await queue.put(jsonData)

                # 答复给用户
                await websocket.send(json.dumps({
                    "code": 1,
                    "message": "success"
                }))

            # 获取消息
            if jsonData['type'] == "get_message":
                # 服务节点需要主动帮忙收集其它节点关于该用户的消息(限制为100个节点, 因为好友可能在其它节点登录)
                # 告知客户, 客户需要提供签名,才能得到对应消息
                pass

            # 发送消息
            if jsonData['type'] == "send_message" and account is not None:
                # 发消息

                # 发过来的消息是有有效期的(一年), 一年内需要消化,若不消化,则清空, 消费后, 记录仍然保留一个月
                # 接收者接收消息后,需要反馈
                # 会冗余到其它节点
                # 客户会对这些节点进行排序(常用节点排第一)

                # 接收者账号
                receiver_account = jsonData["data"]["receiver_account"]

                # 会话ID
                session_id = jsonData["data"]["session_id"]
    
                # TODO: 验证是否互为好友

                chatSession = None
                # 若没有会话,则建立会话
                if session_id not in sessionList:
                    members = [account, receiver_account].sort()
                    message_id = sha256("".join(members))
                    chatSession = Session(message_id, members=members)
                    await queue.put({
                        "type": "create_session",
                        "data": chatSession
                    })
                else:
                    chatSession = Session(message_id, members=members)

                # 消息是加密的, 在加好友的那一刻已经确定对称密码
                message = jsonData["data"]["message"]
                chatSession.send_message(message, account)

                # 接受者在此处消费信息

            # 发朋友圈(增加自己区块)
            if jsonData['type'] == "post_on_moments":
                pass

            # 修改个人资料(修改自己区块)
            if jsonData['type'] == "change_my_information":
                pass

        # print("正常断开")
        if account is not None:
            await queue.put({
                "type": "leave",
                "data": {
                    "account": account
                }
            })
            account = None

    except websockets.exceptions.ConnectionClosed as e:
        # print("报错断开")
        if account is not None:
            await queue.put({
                "type": "leave",
                "data": {
                    "account": account
                }
            })
            account = None

async def main():
    loop = asyncio.get_running_loop()
    # 队列
    queue = asyncio.Queue()
    loop.create_task(consumer(queue))

    async with serve(lambda ServerConnection: echo(ServerConnection, queue), "127.0.0.1", 8000):
        await asyncio.get_running_loop().create_future()  # run forever

asyncio.run(main())
