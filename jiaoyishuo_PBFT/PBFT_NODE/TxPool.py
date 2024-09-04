import os
import json

class TxPool:
    def __init__(self):
        self.transactions = []
        self.temp_folder = "temporary_transactions"
        if not os.path.exists(self.temp_folder):
            os.makedirs(self.temp_folder)

    def add_transaction(self, transaction):
        """添加一个交易到交易池中"""
        self.transactions.append(transaction)
        self.save_transaction_to_disk(transaction)

    def remove_transaction(self, transaction):
        """从交易池中移除一个交易"""
        if transaction in self.transactions:
            self.transactions.remove(transaction)
            self.delete_transaction_from_disk(transaction)

    def get_transactions(self):
        """获取交易池中的所有交易"""
        return self.transactions

    def save_transaction_to_disk(self, transaction):
        """将单个交易保存到磁盘文件中"""
        filename = os.path.join(self.temp_folder, f"tx_{hash(transaction)}.json")
        with open(filename, 'w') as f:
            json.dump(transaction, f)

    def delete_transaction_from_disk(self, transaction):
        """从磁盘中删除单个交易文件"""
        filename = os.path.join(self.temp_folder, f"tx_{hash(transaction)}.json")
        if os.path.exists(filename):
            os.remove(filename)

    def restore_from_disk(self):
        """从磁盘中恢复交易池中的交易"""
        self.transactions = []
        for filename in os.listdir(self.temp_folder):
            if filename.startswith("tx_"):
                filepath = os.path.join(self.temp_folder, filename)
                with open(filepath, 'r') as f:
                    transaction = json.load(f)
                    self.transactions.append(transaction)