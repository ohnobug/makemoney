from Crypto.Random import get_random_bytes
from Crypto.Protocol.SecretSharing import Shamir

# shamir分割
def Shamir_split(k, n, secret):
    # 将秘密分割成多个份额
    shares = Shamir.split(k, n, secret)
    return shares

# shamir还原
def Shamir_combine(shares):
    return Shamir.combine(shares)

# 示例程序
if __name__ == "__main__":
    # 生成密钥
    key = get_random_bytes(16)
    shares = Shamir_split(5, 100, key)

    from random import Random
    import pandas as pd

    test_shares =  [shares[Random().randrange(1, 100)] for i in range(5)]

    # 故意重复
    test_shares.extend(test_shares.copy())

    # 删除重复列
    uniqueList = pd.DataFrame(test_shares) # .drop_duplicates(subset=[1])
    uniqueList = uniqueList.drop_duplicates(subset=[0])

    # 还原密钥
    result = Shamir_combine(uniqueList.values.tolist())
    print(f"原文：{key.hex()}    结果：{result.hex()}")
