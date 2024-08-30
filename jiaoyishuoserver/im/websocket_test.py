import asyncio
import uuid
import json
import websockets


async def websocket_connection(account):
    url = "ws://127.0.0.1:8000/ws"
    async with websockets.connect(url) as websocket:
        print(f"[{account}] Opened connection")
        await websocket.send(json.dumps({
            "type": "join",
            "data": {"account": account}
        }))

        # 等待一段时间
        await asyncio.sleep(100000)

        # 关闭连接
        await websocket.close()
        print(f"[{account}] Closed connection")


async def main():
    num_connections = 10000
    tasks = []

    for _ in range(num_connections):
        account = str(uuid.uuid4())
        tasks.append(websocket_connection(account))

    # 等待所有任务完成
    await asyncio.gather(*tasks)


if __name__ == "__main__":
    asyncio.run(main())