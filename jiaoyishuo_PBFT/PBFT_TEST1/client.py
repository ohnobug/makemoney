import asyncio
import signal
import platform
from websockets.asyncio.client import connect

async def handle_close(websocket):
    await websocket.close()

async def client_connect():
    async with connect(f"ws://localhost:8765") as websocket:
        await websocket.send("hahaha")

        loop = asyncio.get_running_loop()
        if platform.system()!= 'Windows':
            loop.add_signal_handler(signal.SIGTERM, lambda: asyncio.create_task(handle_close(websocket)))
        async for message in websocket:
            print(message)

async def main():
    task = asyncio.create_task(client_connect())

    await task


asyncio.run(main())
