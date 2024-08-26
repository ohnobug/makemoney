from Crypto.Cipher import AES
from Crypto.Random import get_random_bytes


# AES_EAX加密
def AES_EAX_encode(key, header, nonce, data):
    cipher = AES.new(key, AES.MODE_EAX, nonce=nonce)
    cipher.update(header)
    ciphertext, tag = cipher.encrypt_and_digest(data)
    return (ciphertext, tag)

# AES_EAX解密
def AES_EAX_decode(key, header, nonce, ciphertext, tag):
    cipher = AES.new(key, AES.MODE_EAX, nonce=nonce)
    cipher.update(header)
    plaintext = cipher.decrypt_and_verify(ciphertext, tag)
    return plaintext

# AES_CBC加密
def AES_CBC_encode(key, raw):
    # 得到二进制
    raw_bytes = raw.encode("utf-8")
    padded_rawhex = raw_bytes + ('\0' * (AES.block_size - len(raw_bytes) % AES.block_size)).encode('utf-8')
    cipher = AES.new(key, AES.MODE_CBC)
    iv_hex = cipher.iv
    encrypted_data = cipher.encrypt(padded_rawhex)
    return iv_hex + encrypted_data

# AES_CBC解密
def AES_CBC_decode(key, ciphertext):
    iv = ciphertext[:16]
    cipher = AES.new(key, AES.MODE_CBC, iv)
    plaintext = cipher.decrypt(ciphertext[16:])
    return plaintext.decode('utf-8')

# 示例程序
if __name__ == "__main__":
    # nonce = get_random_bytes(16)
    # key = get_random_bytes(16)
    # header = get_random_bytes(16)

    # # 加密
    # ciphertext, tag = AES_EAX_encode(key, header, nonce, b"5201314ABC")

    # # 解密
    # result = AES_EAX_decode(key, header, nonce, ciphertext, tag)
    # print(result)

    key = get_random_bytes(16)
    ct_bytes, iv = AES_CBC_encode(key, b"5201314")
    result = AES_CBC_decode(key, iv, ct_bytes)
    print(result)