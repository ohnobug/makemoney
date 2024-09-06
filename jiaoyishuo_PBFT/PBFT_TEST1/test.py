import asyncio
import websockets

async def websocket_handler(websocket, path):
    print("来了")
    try:
        # 接收客户端消息
        async for message in websocket:
            print(f"Received message: {message}")
            # 发送响应消息给客户端
            await websocket.send(f"Server received: {message}")
    except websockets.exceptions.ConnectionClosedError:
        print("Client disconnected.")

async def start_server(host, port):
    async with websockets.serve(websocket_handler, host, port):
        print(f"WebSocket server started on {host}:{port}")
        await asyncio.get_running_loop().create_future()

if __name__ == "__main__":
    host = "localhost"
    port = 8765
    asyncio.run(start_server(host, port))