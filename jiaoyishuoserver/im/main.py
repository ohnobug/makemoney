import asyncio
import json
from hashlib import sha256
import websockets
from websockets.asyncio.server import serve, ServerConnection


"""
小群体共识也很重要.
"""


import Session
import User

# 用户列表
allUserList = {}

# 会话列表
sessionList = {}

# 同步关于某人信息
def syncAbout(account, node):
    pass

# 处理消息
def proccessNews(account, news):
    pass

# 消费者
async def consumer(queue):
    while True:
        item = await queue.get()
        if item['type'] == "online":
            # 上线
            userData = item['data']
            allUserList[userData['account']] = userData
            print("加入用户成功, 当前用户数量:{}".format(len(allUserList)))
        elif item['type'] == "offline":
            # 离线
            userData = item['data']
            del allUserList[userData['account']]
            print("删除用户成功, 当前用户数量:{}".format(len(allUserList)))
        elif item['type'] == "post_on_moments":
            # 发朋友圈
            # 1,验证过程
            user = allUserList[userData['account']]

            # 验签
            if user.checkSignature(userData['data']['sinature']):
                # 需要考虑 谁可以看,谁不可以看的问题

                # 设计1: 互加好友后,交换统一弱密码, 几千朋友可以通过统一弱密码来查看朋友圈.
                # 深层密码
                
                user.post_on_moments(userData['data']["message"])

            pass
        elif item['type'] == 'like':
            # 点赞
            
            pass

        queue.task_done()

async def echo(websocket: ServerConnection, queue):
    try:
        account = None
        async for message in websocket:
            data = message
            jsonData = json.loads(data)

            # 注册
            if jsonData['type'] == "register":
                '''
                # 整个过程,可本地进行
                1, 注册提交的信息                
                {
                    "type": "register",
                    "data": {
                        "account": "APP生成",                  # 用户账号
                        "userinformation": {                  # 可加密
                            "nickname":  "用户填写",           # 用户昵称
                            "avatar": "用户填写",              # 用户头像URL
                            "location": "用户填写",            # 用户所在地
                            "gender": "用户填写",              # 用户性别
                            "age": "用户填写",                 # 用户年龄
                            "personal_signature": "用户填写",  # 用户个人签名
                            "birth_date": "用户填写",          # 用户出生日期
                            "email":  "用户填写",              # 用户电子邮箱
                            "phone_number":  "用户填写",       # 用户电话号码
                            "hobbies": "用户填写",             # 用户兴趣爱好列表
                            "education_level": "用户填写",     # 用户教育水平
                            "education_school": "用户填写",    # 用户毕业学校
                            "occupation": "用户填写",          # 用户职业
                        }
                    }
                }

                2, 注册后, 建议用户去授权机构申请人个人认证证书
                3, 保存私钥提醒
                '''

            # 登录
            if jsonData['type'] == "login":
                """
                1, 输入账号\选择目标节点(在选择的过程中,需要明示租赁费用)
                2, 若目标节点无本用户信息, 则同步本地个人区块到远程节点, 远程节点验证区块准确性
                3, 若目标节点有本用户信息, 则远程节点验证区块准确性
                4, 同步最新区块


                
                """
                pass


            # 上线
            if jsonData['type'] == "online":
                # 用户的信息也是加密的
                # 用户进入:
                #   1,查询过程, 得到用户信息, 告知用户基础信息: 朋友圈\余额\个人信息等)
                #   2,自行上传
                # 可能需要考虑内网情况
                # 服务器有义务帮忙寻找其它服务器同步用户的最新信息.
                account = jsonData["data"]["account"]

                # synUserInfo(account)


                await queue.put(jsonData)

                # 答复给用户
                await websocket.send(json.dumps({
                    "code": 1,
                    "message": "success"
                }))

            # 离线
            if jsonData['type'] == "offline":
                # 上线离线都需要广播
                pass

            # 获取消息
            if jsonData['type'] == "get_message":
                # 服务节点需要主动帮忙收集其它节点关于该用户的消息(限制为100个节点, 因为好友可能在其它节点登录)
                # 告知客户, 客户需要提供签名,才能得到对应消息

                nodes = []
                news = []
                for node in nodes:
                    news.append(syncAbout(account, node))

                # 处理同步过来的消息,例如消息是否符合规定等
                proccessNews(account, news)

                pass

            # 发送消息
            if jsonData['type'] == "send_message" and account is not None:
                # 发消息

                """
                    1, 假设用户A的由节点A服务, 用户B的由节点B服务. (用户需按天租赁节点服务, 免费节点广告多.)
                    2, 节点A首先会寻找节点B, 需要配对成功. (节点A\节点B等多个节点 1000个超级代表需要共同维护用户A\用户B的区块信息)
                    3, 当用户A发送消息给用户B, 节点A会同步该消息到节点B并且缓存该消息.
                    {
                        消息ID: e10adc3949ba59abbe56e057f20f883e
                        类型: 消息
                        数据: {
                            发起人: 用户A账号,
                            接收人: 用户B账号,
                            扩展: <AES加密>{
                                消息: "今天天气不错吧",
                                时间: "2024年9月2日 08:48:39"
                            }
                        },
                        签名: 用户A签名
                    }
                    4, 当用户B接收到消息后, 需要响应给用户A (已读通知, 需要成为一个交易纳入当天区块)
                    {
                        消息ID: e10adc3949ba59abbe56e057f20f883e
                        类型: 响应消息
                        数据: {
                            发起人: 用户B账号,
                            接收人: 用户A账号,
                            扩展: <AES加密>{
                                READ_e10adc3949ba59abbe56e057f20f883e
                            }
                        },
                        签名: 用户B签名
                    }
                """

                # 发过来的消息是有有效期的(一年), 一年内需要消化,若不消化,则清空, 消费后, 记录可能仍然保留一个月
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
                await queue.put(jsonData)
                pass

            # 修改个人资料(修改自己区块)
            if jsonData['type'] == "change_my_information":
                pass

            # 添加好友
            if jsonData["type"] == "add_friend":
                # 好友账号
                friend_acount = ""

                """
                1, 假设用户A的由节点A服务, 用户B的由节点B服务.
                2, 用户A扫码添加用户B的时候, APP会出示用户B在信任机构认证的证书(认证证书集成在用户B的账户内, 扫码后APP将会出现认证结果).
                3, 用户A有加用户B的意向的时候, 首先用户A会在自己的好友列表中,添加一项关于用户B的数据.
                4, 由节点A广播加好友信号(如下)(节点需考虑用户B目前离线,海量好友等情况, 用户B可以设置意向: 短期二维码添加\长期有效二维码添加).
                    {
                        类型: 申请加好友
                        数据: {
                            发起人: 用户A账号,
                            接收人: 用户B账号,
                            扩展: {
                                AES密钥: 用用户B公钥加密的AES密钥 (方便后续发送消息, 刷朋友圈等. (该密钥将一周更新一次))
                            }
                        },
                        签名: 用户A签名
                    }
                5, 当用户B收到申请消息, 同样APP会出示用户A在信任机构认证的证书, 进行同意操作后, 用户B会将用户A加入到好友列表中, 并且要求节点广播信息:
                    {
                        类型: 同意加好友
                        数据: {
                            发起人: 用户B账号,
                            接收人: 用户A账号,
                            扩展: {
                                AES密钥: 用用户A公钥加密的AES密钥 (方便后续发送消息, 刷朋友圈等. (该密钥将一周更新一次))
                            }
                        },
                        签名: 用户B签名
                    }
                6, 添加好友过程完成
                7, 当用户A需要给用户B发送消息的时候, 将会使用同一AES密钥进行加密解密.
                """

                # 对该好友专属私钥保存在我的好友列表, 并且提供公钥给对方
                # 待对方答应成为你的好友的时候,反馈回一个加密的对称密钥给你.(你可以用该好友专属私钥来取得)
                # 后续,无论是对话\还是发朋友圈点赞,都是通过该对称密码来进行加密, 中间人无法盗取
                pass

            # 删除好友
            if jsonData["type"] == "remove_friend":
                # 在自己的好友列表中,直接删除对方即可.
                # 服务器会检测对方最新的好友列表,看看是否包含你,如果不包含,则不往对方发送消息.
                pass

            # 点赞
            if jsonData["type"] == "like":
                await queue.put(jsonData)

                # 答复给用户
                await websocket.send(json.dumps({
                    "code": 1,
                    "message": "success"
                }))

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
