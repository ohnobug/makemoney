import threading
from fastapi import FastAPI, WebSocket, WebSocketDisconnect
import json
import queue

# 队列
queue = queue.Queue()

# 用户列表
allUserList = {}

# 消费者
def worker():
    while True:
        item = queue.get()
        if item['type'] == "join":
            userData = item['data']
            allUserList[userData['account']] = userData
            print("加入用户成功, 当前用户数量:{}".format(len(allUserList)))
        elif item['type'] == "leave":
            userData = item['data']
            del allUserList[userData['account']]
            print("删除用户成功, 当前用户数量:{}".format(len(allUserList)))
        queue.task_done()

# 启动消费者线程
thread = threading.Thread(target=worker, daemon=True)
thread.start()


app = FastAPI()
@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    account = ""
    try:
        while True:
            data = await websocket.receive_text()
            jsonData = json.loads(data)

            if jsonData['type'] == "join":
                # 用户进入(缺: 查询过程, 得到用户信息)
                account = jsonData["data"]["account"]
                queue.put(jsonData)
                await websocket.send_json({
                    "code": 1,
                    "message": "success"
                })
    except WebSocketDisconnect:
        queue.put({
            "type": "leave",
            "data": {
                "account": account
            }
        })
