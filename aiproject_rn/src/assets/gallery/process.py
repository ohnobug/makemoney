import re

# 打开文件
f = open("./run.sh", "r")
content = f.read()
f.close()
list = re.finditer(r"curl.*?--compressed ;", content.replace("\n","🧨"))

# 找出符合条件的
wait = []
for match in list:
    if match.group().find("https://scontent-nrt1-2.cdninstagram.com") > 0:
        wait.append(match.group())

# 去重
wait = set(wait)

# 替换
i = 1
output = []
for l in wait:
    temp = l.replace("curl ", f"curl -o '{i}.jpg' ")
    temp = temp.replace("🧨", "\n")
    output.append(temp)
    i = i + 1

f = open("./run.sh", "w")
f.write("\n".join(output))
f.close()
print("恭喜，已经完成替换！！");