import socket

def start_server(host='127.0.0.1', port=8888):
    # 创建一个TCP/IP socket
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        # 绑定地址和端口
        s.bind((host, port))
        # 开始监听传入的连接
        s.listen()
        print(f"Server listening on {host}:{port}")

        while True:
            # 等待客户端连接
            conn, addr = s.accept()
            with conn:
                print(f"Connected by {addr}")
                while True:
                    # 接收数据
                    data = conn.recv(1024)
                    if not data:
                        break
                    # 将收到的数据回显给客户端
                    conn.sendall(data)

if __name__ == "__main__":
    start_server()
