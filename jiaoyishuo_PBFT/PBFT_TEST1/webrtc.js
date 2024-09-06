const localVideo = document.getElementById('localVideo');
const remoteVideo = document.getElementById('remoteVideo');
const startCallButton = document.getElementById('startCall');
const hangupCallButton = document.getElementById('hangupCall');

let localStream;
let peerConnection;

// STUN server 用于帮助找到内网的地址
const configuration = {
    iceServers: [{ urls: 'stun:stun.l.google.com:19302' }]
};

// 获取本地媒体流
async function getLocalStream() {
    localStream = await navigator.mediaDevices.getUserMedia({ video: true, audio: true });
    localVideo.srcObject = localStream;
}

// 开始 WebRTC 连接
async function startCall() {
    peerConnection = new RTCPeerConnection(configuration);

    // 添加本地流到连接中
    localStream.getTracks().forEach(track => {
        peerConnection.addTrack(track, localStream);
    });

    // 处理远程流
    peerConnection.ontrack = event => {
        const [remoteStream] = event.streams;
        remoteVideo.srcObject = remoteStream;
    };

    // 处理 ICE 候选者
    peerConnection.onicecandidate = event => {
        if (event.candidate) {
            sendMessage('ice', event.candidate); // 通过信令服务器发送 ICE 候选者
        }
    };

    // 创建和发送 SDP offer
    const offer = await peerConnection.createOffer();
    await peerConnection.setLocalDescription(offer);
    sendMessage('offer', offer);
}

// 挂断通话
function hangupCall() {
    peerConnection.close();
    peerConnection = null;
    sendMessage('hangup');
}

// 处理信令消息
function handleSignalingMessage(message) {
    const data = JSON.parse(message.data);

    if (data.type === 'offer') {
        handleOffer(data);
    } else if (data.type === 'answer') {
        handleAnswer(data);
    } else if (data.type === 'ice') {
        handleICECandidate(data.candidate);
    } else if (data.type === 'hangup') {
        handleHangup();
    }
}

// 处理收到的 SDP offer
async function handleOffer(offer) {
    peerConnection = new RTCPeerConnection(configuration);

    localStream.getTracks().forEach(track => {
        peerConnection.addTrack(track, localStream);
    });

    peerConnection.ontrack = event => {
        const [remoteStream] = event.streams;
        remoteVideo.srcObject = remoteStream;
    };

    peerConnection.onicecandidate = event => {
        if (event.candidate) {
            sendMessage('ice', event.candidate);
        }
    };

    await peerConnection.setRemoteDescription(new RTCSessionDescription(offer));
    const answer = await peerConnection.createAnswer();
    await peerConnection.setLocalDescription(answer);
    sendMessage('answer', answer);
}

// 处理 SDP answer
async function handleAnswer(answer) {
    await peerConnection.setRemoteDescription(new RTCSessionDescription(answer));
}

// 处理 ICE 候选者
async function handleICECandidate(candidate) {
    try {
        await peerConnection.addIceCandidate(candidate);
    } catch (e) {
        console.error('Error adding received ICE candidate', e);
    }
}

// 处理挂断
function handleHangup() {
    if (peerConnection) {
        peerConnection.close();
        peerConnection = null;
    }
}

// 假设你有一个简单的 WebSocket 信令服务器，处理消息传递
function sendMessage(type, data) {
    // 实现消息发送逻辑，通常通过 WebSocket 或 HTTP
    signalingServer.send(JSON.stringify({ type, data }));
}

// 设置本地流和按钮事件监听
getLocalStream();
startCallButton.addEventListener('click', startCall);
hangupCallButton.addEventListener('click', hangupCall);
