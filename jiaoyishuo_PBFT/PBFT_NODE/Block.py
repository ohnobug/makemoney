import hashlib
import time

class Block:
    """
    表示区块链中的一个区块。

    属性: 
    - index: 区块在区块链中的索引。
    - previous_hash: 上一个区块的哈希值。
    - transactions: 包含在该区块中的交易列表。
    - timestamp: 区块创建的时间戳。
    - hash: 该区块的哈希值。
    """
    def __init__(self, index, previous_hash, transactions, timestamp=None):
        self.index = index
        self.previous_hash = previous_hash
        self.transactions = transactions
        self.timestamp = timestamp if timestamp else time.time()
        self.hash = self.calculate_hash()

    def calculate_hash(self):
        """
        计算当前区块的哈希值。

        返回: 
        - 计算得到的哈希值。
        """
        data = str(self.index) + str(self.previous_hash) + str(self.transactions) + str(self.timestamp)
        return hashlib.sha256(data.encode()).hexdigest()

    def to_hex(self):
        """将区块转换为十六进制字符串表示"""
        block_data = str(self.index) + self.previous_hash + str(self.transactions) + str(self.timestamp) + self.hash
        return hex(int.from_bytes(block_data.encode(), byteorder='big'))

    @staticmethod
    def hex_decode(hex_str):
        """
        将十六进制字符串表示的区块解码为 Block 对象。

        参数：
        - hex_str: 十六进制字符串表示的区块。

        返回：
        - 解码后的 Block 对象。
        """
        decimal_value = int(hex_str, 16)
        block_data = decimal_value.to_bytes((decimal_value.bit_length() + 7) // 8, byteorder='big').decode()
        parts = block_data.split('\n')
        index = int(parts[0])
        previous_hash = parts[1]
        transactions = eval(parts[2])
        timestamp = float(parts[3])
        hash = parts[4]
        return Block(index, previous_hash, transactions, timestamp)
