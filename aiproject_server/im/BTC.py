import time
import random

def generate_merkle_root(transactions):
    # 这里只是一个简单的模拟，实际的默克尔树计算要复杂得多
    return "merkle_root_" + str(hash(str(transactions)))

# 模拟的比特币区块数据结构
block_data = {
    "blockHeader": {
        # 版本号，代表区块的格式版本
        "version": "1.2",
        # 前一个区块的哈希值，用于链接区块形成区块链
        "previousBlockHash": "0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef",
        # 区块创建的时间戳，通常是自 Unix 纪元（1970 年 1 月 1 日）以来的秒数
        "timestamp": int(time.time()),
        # 难度目标值，用于挖矿难度调整
        "bits": "0000ffff",
        # 随机数，用于挖矿过程中找到满足条件的哈希值
        "nonce": random.randint(0, 1000000)
    },
    "transactions": [{
        # 交易的唯一标识符
        "transactionId": "txid_12345",
        "inputs": [{
            # 引用的前一笔交易的唯一标识符
            "previousTransactionId": "prev_txid_98765",
            # 在引用的前一笔交易中的输出索引
            "outputIndex": 2,
            # 解锁脚本，提供签名和证明所有权的信息
            "scriptSig": "signature_data_here"
        }],
        "outputs": [{
            # 交易金额
            "value": 0.5,
            # 锁定脚本，指定接收方地址和解锁条件
            "scriptPubKey": "address_data_here"
        }],
        # 交易锁定时间，指定在什么区块高度或时间之前该交易不能被包含在区块链中
        "lockTime": int(time.time()) + 3600
    }]
}

# 计算并设置默克尔树根哈希值
block_data["blockHeader"]["merkleRoot"] = generate_merkle_root(block_data["transactions"])

print(block_data)