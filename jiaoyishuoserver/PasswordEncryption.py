from random import Random
import time
from Crypto.Random import get_random_bytes
from entryption.AES import AES_CBC_decode, AES_CBC_encode, AES_EAX_encode
from entryption.Shamir import Shamir_combine, Shamir_split

# 加密
def passwordEncode(password):
    secret = get_random_bytes(16)

    # shamir得到加密份额
    shares = Shamir_split(5, 100, secret)

    # 将秘密加密
    ct_bytes = AES_CBC_encode(secret, password)

    # 后续将使用shamir的5个份额来还原key，得到密钥
    return {"secrets": ct_bytes, "shares": shares}

# 解密
def passwordDecode(secrets, shares):
    # 解密密钥
    secret = Shamir_combine(shares)

    # 得到三部分信息：随机数、标签、密钥
    plaintext = AES_CBC_decode(secret, secrets)
    return plaintext


if __name__ == "__main__":
    beginTime = time.time()
    for i in range(100):
        beginTime1 = time.perf_counter()

        # 加密
        p = passwordEncode("5201314")
        secrets = p['secrets']
        shares = p['shares']

        # 解密
        randomShares = Random().sample(shares, 5)
        # print("解密后的结果：{}".format(passwordDecode(secrets, randomShares)))
        print("{:>5}次：{}".format(i + 1, time.perf_counter() - beginTime1))

    print(time.time() - beginTime)