import { useEffect, useReducer, useState } from 'react'
import './App.less'

interface Node {
  id: string;
  host: string;
  port: string;
  information: string;
  is_primary: boolean
}

const reducer = (nodes: Node[], action: { type: string; node?: Node; id?: string }): Node[] => {
  switch (action.type) {
    case 'ADD_NODE':
      return [...nodes, action.node!];
    case 'REMOVE_NODE':
      return nodes.filter(node => node.id !== action.id!);
    default:
      return nodes;
  }
};


const generateRandomId = (): string => Math.random().toString(36).substring(2, 10);
const generateRandomHost = (): string => `host${Math.floor(Math.random() * 100)}`;
const generateRandomPort = (): string => `${Math.floor(Math.random() * 65536)}`;
const generateRandomInformation = (): string => `info${Math.random().toString(36).substring(2, 10)}`;

const initialNodes: Node[] = Array.from({ length: 1000 }, (index) => {
  console.log(index)
  return {
    id: generateRandomId(),
    host: generateRandomHost(),
    port: generateRandomPort(),
    information: generateRandomInformation(),
    is_primary: false
  }
}
);



function App() {
  const [nodes, setNodes] = useReducer(reducer, initialNodes)
  const [primary, setPrimary] = useState(0)


  const loss_colors = [
    "node_loss_100",
    "node_loss_75",
    "node_loss_50",
    "node_loss_25",
    "node_loss_0"
  ]

  useEffect(() => {
    setTimeout(() => {
      let newPrimary = primary + 1
      if (newPrimary >= 1000) {
        newPrimary = 1
      }
      setPrimary(newPrimary)
    }, 1000);
  }, [primary])

  return (
    <div className='page'>
      <div className='menu'>
        <dl>
          <dt>控制面板</dt>
          <dd>内容管理</dd>
          <dd>评论管理</dd>
          <dd>话题管理</dd>
          <dd>粉丝管理</dd>
          <dd>素材管理</dd>
        </dl>
      </div>
      <div className='main'>
        <div className="container">
          <div className='title_container'>
            <div className='title_left'>
              <div className='title'>节点:</div>
            </div>
            <div className='title_right'>
              <div className='node_loss_indicate'>
                <div className='node_loss_100'></div>
                <div className='node_loss_75'></div>
                <div className='node_loss_50'></div>
                <div className='node_loss_25'></div>
                <div className='node_loss_0'></div>
              </div>
            </div>
          </div>
          <div className='nodes'>
            {
              nodes.map((item, index) => {
                const randomIndex = Math.floor(Math.random() * loss_colors.length);
                return index == primary ? <div className={['node node_red', loss_colors[randomIndex]].join(' ')} key={index}></div> : <div className={['node', loss_colors[randomIndex]].join(' ')} key={index}></div>
              })
            }
          </div>


        </div>
      </div>
    </div>
  )
}

export default App
