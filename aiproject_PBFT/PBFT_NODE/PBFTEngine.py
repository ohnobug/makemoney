import os
import PBFTMessageGenerator
import BlockVerifier

class PBFTEngine:
    def __init__(self):
        pass
        # self.block_verifier = BlockVerifier()

    def receive_and_process_message(self, message):
        """
        接收并处理 PBFT 共识消息。

        参数: 
        - message: 从外部接收的消息字典。
        """
        packet_type = message.get("packetType")
        if packet_type == "PrepareReqPacket":
            block = message.get("block")
            # 验证区块及交易
            is_valid, error_message = self.block_verifier.verify_block(block)
            if is_valid:
                # 达成共识后上链
                block_id = block.get("id")
                self.save_block_to_file(block_id, block)
                # 从交易池中删除已上链的交易
                self.remove_transactions_from_pool(block.get("transactions"))
        elif packet_type in ["SignReqPacket", "CommitReqPacket", "ViewChangeReqPacket"]:
            # 处理其他消息类型的逻辑（如果需要）
            pass

    def save_block_to_file(self, block_id, block):
        """
        将区块保存到本地文件。

        参数: 
        - block_id: 区块的唯一标识。
        - block: 要保存的区块数据。
        """
        file_path = f"block_{block_id}.txt"
        with open(file_path, "w") as f:
            f.write(str(block))

    def remove_transactions_from_pool(self, transactions):
        """
        从交易池中删除已上链的交易。

        参数: 
        - transactions: 已上链的交易列表。
        """
        # 假设交易池是一个全局变量或者有相应的方法来访问和修改
        # for transaction in transactions:
        #     remove_from_transaction_pool(transaction)
        pass
