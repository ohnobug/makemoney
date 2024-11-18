class PBFTMessageGenerator:
    """
    PBFT 消息生成器类，用于生成不同类型的 PBFT 共识消息。
    """
    def __init__(self, idx, height, block_hash, view, sig):
        """
        初始化消息生成器。

        参数: 
        - idx: 当前节点索引。
        - height: 当前正在处理的区块高度。
        - block_hash: 当前正在处理的区块哈希。
        - view: 当前节点所处的视图。
        - sig: 当前节点对 block_hash 的签名。
        """
        self.idx = idx
        self.height = height
        self.block_hash = block_hash
        self.view = view
        self.sig = sig

    # 包含区块的请求包，由leader产生并向所有Replica节点广播，Replica节点收到Prepare包后，验证PrepareReq签名、执行区块并缓存区块执行结果，达到防止拜占庭节点作恶、保证区块执行结果的最终确定性的目的；
    def prepare_req_packet(self, block):
        """
        生成 PrepareReqPacket 类型的消息。

        参数: 
        - block: 所有共识节点正在共识的区块数据。

        返回: 
        - 包含 PrepareReqPacket 类型消息内容的字典。
        """
        return {
            "idx": self.idx,
            "packetType": "PrepareReqPacket",
            "height": self.height,
            "blockHash": self.block_hash,
            "view": self.view,
            "sig": self.sig,
            "block": block
        }

    # 带有区块执行结果的签名请求，由收到Prepare包并执行完区块的共识节点产生，SignReq请求带有执行后区块的hash以及该hash的签名，分别记为SignReq.block_hash和SignReq.sig，节点将SignReq广播到所有其他共识节点后，其他节点对SignReq(即区块执行结果)进行共识；
    def sign_req_packet(self):
        """
        生成 SignReqPacket 类型的消息。

        返回: 
        - 包含 SignReqPacket 类型消息内容的字典。
        """
        return {
            "idx": self.idx,
            "packetType": "SignReqPacket",
            "height": self.height,
            "blockHash": self.block_hash,
            "view": self.view,
            "sig": self.sig
        }

    # 用于确认区块执行结果的提交请求，由收集满(2*f+1)个block_hash相同且来自不同节点SignReq请求的节点产生，CommitReq被广播给所有其他共识节点，其他节点收集满(2*f+1)个block_hash相同、来自不同节点的CommitReq后，将本地节点缓存的最新区块上链；
    def commit_req_packet(self):
        """
        生成 CommitReqPacket 类型的消息。

        返回: 
        - 包含 CommitReqPacket 类型消息内容的字典。
        """
        return {
            "idx": self.idx,
            "packetType": "CommitReqPacket",
            "height": self.height,
            "blockHash": self.block_hash,
            "view": self.view,
            "sig": self.sig
        }

    # 视图切换请求，当leader无法提供正常服务(如网络连接不正常、服务器宕机等)时, 其他共识节点会主动触发视图切换，ViewChangeReq中带有该节点即将切换到的视图(记为toView，为当前视图加一)，某节点收集满(2*f+1)个视图等于toView、来自不同节点的ViewChangeReq后，会将当前视图切换为toView。
    def view_change_req_packet(self, toView):
        """
        生成 ViewChangeReqPacket 类型的消息。

        参数: 
        - toView: 节点即将切换到的视图（当前视图加一）。

        返回: 
        - 包含 ViewChangeReqPacket 类型消息内容的字典。
        """
        return {
            "idx": self.idx,
            "packetType": "ViewChangeReqPacket",
            "height": self.height,
            "blockHash": self.block_hash,
            "view": self.view,
            "sig": self.sig,
            "toView": toView
        }
