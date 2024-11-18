import Block

class Blockchain:
    """
    表示一个区块链。

    属性: 
    - chain: 存储区块链中所有区块的列表。
    - delegates: 代表列表（在 DPOS 机制中）。
    - pending_transactions: 等待被打包进区块的交易列表。
    """
    def __init__(self):
        self.chain = [self.create_genesis_block()]
        self.delegates = []
        self.pending_transactions = []

    def create_genesis_block(self):
        """
        创建创世区块。

        返回: 
        - 创世区块对象。
        """
        return Block(0, "0", "Genesis Block")

    def get_latest_block(self):
        """
        获取区块链中的最后一个区块。

        返回: 
        - 最后一个区块对象。
        """
        return self.chain[-1]

    def add_block(self, new_block):
        """
        将一个新的区块添加到区块链中。

        参数: 
        - new_block: 要添加的新区块对象。
        """
        new_block.previous_hash = self.get_latest_block().hash
        self.chain.append(new_block)

    def is_chain_valid(self):
        """
        检查区块链的有效性。

        返回: 
        - 如果区块链有效则返回 True，否则返回 False。
        """
        for i in range(1, len(self.chain)):
            current_block = self.chain[i]
            previous_block = self.chain[i - 1]
            if current_block.hash!= current_block.calculate_hash():
                return False
            if current_block.previous_hash!= previous_block.hash:
                return False
        return True

    def add_transaction(self, transaction):
        """
        将一个交易添加到待处理交易列表中。

        参数: 
        - transaction: 要添加的交易。
        """
        self.pending_transactions.append(transaction)

    def set_delegates(self, delegates_list):
        """
        设置代表列表。

        参数: 
        - delegates_list: 代表列表。
        """
        self.delegates = delegates_list

    def process_pending_transactions(self):
        """
        处理待处理交易列表，由代表创建新的区块并添加到区块链中。

        如果没有设置代表，则会抛出 ValueError 异常。
        """
        if not self.delegates:
            raise ValueError("No delegates set.")
        delegate = self.delegates[0]  # For simplicity, assume the first delegate creates the block.
        block = Block(len(self.chain), self.get_latest_block().hash, self.pending_transactions)
        self.add_block(block)
        self.pending_transactions = []
