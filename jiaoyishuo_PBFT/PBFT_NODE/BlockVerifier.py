class BlockVerifier:
    def __init__(self):
        pass

    def verify_block(self, block):
        """
        验证给定的区块是否符合条件。

        参数:
        - block:要验证的区块对象。

        返回:
        - 一个元组, 包含验证结果(True或False)和错误消息(如果验证失败)。
        """
        if not block.index:
            return False, "Block index is missing."
        if not block.previous_hash:
            return False, "Previous hash is missing."
        if not block.transactions:
            return False, "Transactions are missing."
        if not block.timestamp:
            return False, "Timestamp is missing."
        if not block.hash:
            return False, "Hash is missing."

        # 验证交易
        for transaction in block.transactions:
            if not self.verify_transaction(transaction):
                return False, "Invalid transaction in block."

        return True, None

    def verify_transaction(self, transaction):
        """
        验证单个交易是否有效。

        参数:
        - transaction: 要验证的交易对象。

        返回:
        - True 如果交易有效, False 否则。
        """
        # 这里可以根据具体的交易规则进行验证
        # 例如检查交易的签名、交易的金额是否合法等
        return True