'use client';

import { useCallback, useEffect, useReducer, useRef, useState } from "react";

interface AddMessageAction {
  type: 'ADD_MESSAGE';
  message: string;
}

interface DeleteMessageAction {
  type: 'DELETE_MESSAGE';
  index: number;
}

type MessageAction = AddMessageAction | DeleteMessageAction;

const messageReducer = (state: string[], action: MessageAction): string[] => {
  switch (action.type) {
    case 'ADD_MESSAGE':
      return [...state, action.message];
    case 'DELETE_MESSAGE':
      return state.filter((_, index) => index !== action.index);
    default:
      return state;
  }
};

export default function App() {
  const [textValue, setTextValue] = useState('');


  const [messages, setMessage] = useReducer(messageReducer, [
    '也能干，但在这人类文明的危难时刻，您这样一位科学家居然抽手旁',
    '懂的中国成语——叫班门弄斧。” “你不相信他们的话？” “当',
    '人说话了。 “不过这也正好证明了面壁计划的必要性。”丁仪说。',
    '围，他的话在说给丁仪时也是在对四光年外的三体人说，一时间，他',
    '原子核更容易一些。” 这时他们已经走到了车门前，丁仪无力地靠',
    '” “也就是说，智子现在已经能够同时干扰上百台加速器。” “',
    '能代替加速器研究。对宇宙高能粒子的检测方式与在加速器终端的很',
    '三体文明对宏原子的理解不知比人类高了多少层次，在他们面前使用',
    '松自己，尽可能做到最好就行了。” 希恩斯转过身来，但在竹林的',
    '眼睛无处不在，现在肯定就飘浮在周围，他的话在说给丁仪时也是在',
  ]);


  const [socket, connect, disconnect] = useWebSocket('ws://localhost:8000/ws');

  useEffect(() => {
    connect();
    return () => {
      disconnect()
    }
  }, [])

  useEffect(() => {
    if (socket) {
      socket.onmessage = (event) => {
        let serverData = JSON.parse(event.data);
        setMessage({ "type": "ADD_MESSAGE", "message": serverData.payload.content })
      };
    }
  }, [socket])

  const scrollContainerRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (scrollContainerRef.current) {
      scrollContainerRef.current.scrollTop = scrollContainerRef.current.scrollHeight;
    }
  }, [messages]);
  
  return (
    <main style={{
      width: '375px',
      height: "600px",
      position: "absolute",
      left: "50%",
      top: "50%",
      transform: "translate(-50%, -50%)",
      // background: "red",
      display: "flex",
      flexDirection: "column",
      padding: "5px",
      border: "1px solid #333",
      borderRadius: "5px",
    }}>
      <div ref={scrollContainerRef} style={{
        overflowY: "auto",
        flex: 1
      }}>

        {
          messages.map((item, index) => {
            return <div key={index} style={{
              lineHeight: '20px',
              fontSize: '12px',
              overflow: 'wrap',
              border: "1px solid #333",
              borderRadius: '5px',
              marginBottom: "8px",
              padding: "5px"
            }}>{item}</div>
          })
        }
      </div>

      <div style={{
        display: "flex"
      }}>
        <textarea style={{
          borderInline: "none",
          border: "1px solid #333",
          outline: "none",
          flex: 1
        }} value={textValue} onChange={v => setTextValue(v.target.value)}></textarea>
        <button style={{
          flexBasis: '100px'
        }} onClick={() => {
          setMessage({ "type": "ADD_MESSAGE", "message": textValue })
          socket?.send(textValue)
          setTextValue("")
        }}>发送</button></div>

    </main>
  );
}




const useWebSocket = (url: string): [WebSocket | undefined, () => void, () => void] => {
  const [socket, setSocket] = useState<WebSocket>();
  // const [isConnection, setIsConnection] = useState<boolean>(false);

  const connect = useCallback(() => {
    const newSocket = new WebSocket(url);
    setSocket(newSocket);


    let reconnect = () => {
      newSocket.close()
      setTimeout(() => {
        if (newSocket.readyState == newSocket.CLOSED) {
          console.log("正在重新连接......")
          connect();
        }
      }, 200)
    }

    newSocket.onopen = () => {
      console.log('WebSocket connected');
    };

    newSocket.onmessage = (event) => {
      console.log('Message from server:', event.data);
    };

    newSocket.onclose = () => {
      reconnect()
      console.log('WebSocket disconnected');
    };

    newSocket.onerror = (error) => {
      console.error('WebSocket error:', error);
    };
  }, [url]);

  const disconnect = useCallback(() => {
    if (socket) {
      socket.close();
    }
  }, [socket]);

  return [socket, connect, disconnect];
};