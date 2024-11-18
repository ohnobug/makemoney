import uuid
import datetime

class Message:
    def __init__(self, sender, receiver):
        self.sender = sender
        self.receiver = receiver
        self.messages = []

    # 生成消息体
    def generate_message(self, message_type, payload):
        message_id = str(uuid.uuid4())
        timestamp = datetime.datetime.now().isoformat()

        payload = self.payloadParser(payload)

        if self.receiver.type == "user":
            # 发个人
            message = {
                "messageId": message_id,
                "sender": self.getSenderUserinfo(),
                "receiver": self.getReceiverUserinfo(),
                "messageType": message_type,
                "timestamp": timestamp,
                "payload": payload
            }
        elif self.receiver.type == "group":
            # 发群\发公众号 合二为一
            message = {
                "messageId": message_id,
                "sender": self.getSenderUserinfo(),
                "receiver": self.getReceiverUserinfo(),
                "messageType": message_type,
                "timestamp": timestamp,
                "payload": payload
            }

        return message

    # 接受消息
    def receive_message(self, receiver_name):
        received_messages = []
        for message in self.messages:
            for receiver in message["receivers"]:
                if receiver["name"] == receiver_name:
                    received_messages.append(message)
        return received_messages

    # 得到发送者信息
    def getSenderUserinfo(self):
        return {
            "account": self.sender.account,
            "nickname": self.sender.nickname,
            "gender": self.sender.gender,
            "age": self.sender.age,
            "avatar": self.sender.avatar,
            "personal_signature": self.sender.personal_signature,
            "location": self.sender.location,
            "birth_date": self.sender.birth_date,
            "email": self.sender.email,
            "phone_number": self.sender.phone_number,
            "hobbies": self.sender.hobbies,
            "education_level": self.sender.education_level,
            "education_school": self.sender.education_school,
            "occupation": self.sender.occupation,
        }

    # 得到接收者信息
    def getReceiverUserinfo(self):
        return {
            "account": self.receiver.account,
            "nickname": self.receiver.nickname,
            "gender": self.receiver.gender,
            "age": self.receiver.age,
            "avatar": self.receiver.avatar,
            "personal_signature": self.receiver.personal_signature,
            "location": self.receiver.location,
            "birth_date": self.receiver.birth_date,
            "email": self.receiver.email,
            "phone_number": self.receiver.phone_number,
            "hobbies": self.receiver.hobbies,
            "education_level": self.receiver.education_level,
            "education_school": self.receiver.education_school,
            "occupation": self.receiver.occupation,
        }

    # 载体处理器
    def payloadParser(payload):
        emojilist = {
            "[微笑]": "😊",
            "[撇嘴]": "😒",
            "[色]": "😍",
            "[发呆]": "😳",
            "[得意]": "😏",
            "[流泪]": "😭",
            "[害羞]": "😳",
            "[闭嘴]": "🤐",
            "[睡]": "😴",
            "[大哭]": "😭",
            "[尴尬]": "😅",
            "[发怒]": "😡",
            "[调皮]": "😜",
            "[呲牙]": "😁",
            "[惊讶]": "😲",
            "[难过]": "😞",
            "[囧]": "😓",
            "[抓狂]": "😖",
            "[吐]": "🤮",
            "[偷笑]": "🤭",
            "[愉快]": "😊",
            "[白眼]": "🙄",
            "[傲慢]": "😤",
            "[困]": "😪",
            "[惊恐]": "😱",
            "[流汗]": "😓",
            "[憨笑]": "😄",
            "[悠闲]": "😌",
            "[奋斗]": "💪",
            "[咒骂]": "🤬",
            "[疑问]": "❓",
            "[嘘]": "🤫",
            "[晕]": "😵",
            "[衰]": "😩",
            "[骷髅]": "💀",
            "[敲打]": "👊",
            "[再见]": "👋",
            "[擦汗]": "😅",
            "[抠鼻]": "👃",
            "[鼓掌]": "👏",
            "[坏笑]": "😈",
            "[左哼哼]": "😤",
            "[右哼哼]": "😤",
            "[哈欠]": "😪",
            "[鄙视]": "😒",
            "[委屈]": "😔",
            "[快哭了]": "😢",
            "[阴险]": "😏",
            "[亲亲]": "😘",
            "[可怜]": "🥺",
            "[笑脸]": "😀",
            "[生病]": "🤒",
            "[破涕为笑]": "😂",
            "[吐舌]": "😝",
            "[脸红]": "😊",
            "[恐惧]": "😨",
            "[失望]": "😞",
            "[无语]": "😑",
            "[嘿哈]": "😆",
            "[捂脸]": "🤦",
            "[奸笑]": "😏",
            "[机智]": "🤓",
            "[皱眉]": "😟",
            "[耶]": "✌️",
            "[吃瓜]": "🍉",
            "[加油]": "💪",
            "[汗]": "😓",
            "[天啊]": "😱",
            "[Emm]": "🤔",
            "[社会社会]": "🕺",
            "[旺柴]": "🐶",
            "[好的]": "👌",
            "[打脸]": "🤦‍♂️",
            "[加油加油]": "👍",
            "[哇]": "😮",
            "[翻白眼]": "🙄",
            "[666]": "👍",
            "[让我看看]": "👀",
            "[叹气]": "😔",
            "[苦涩]": "😣",
            "[裂开]": "😖",
            "[嘴唇]": "👄",
            "[爱心]": "❤️",
            "[心碎]": "💔",
            "[拥抱]": "🤗",
            "[强]": "💪",
            "[弱]": "👎",
            "[握手]": "🤝",
            "[胜利]": "✌️",
            "[抱拳]": "🙏",
            "[勾引]": "😉",
            "[拳头]": "👊",
            "[ok]": "👌",
            "[合十]": "🙏",
            "[强壮]": "💪",
            "[西瓜]": "🍉",
            "[啤酒]": "🍺",
            "[咖啡]": "☕",
            "[蛋糕]": "🍰",
            "[玫瑰]": "🌹",
            "[凋谢]": "🥀",
            "[菜刀]": "🔪",
            "[炸弹]": "💣",
            "[便便]": "💩",
            "[月亮]": "🌙",
            "[太阳]": "☀️",
            "[庆祝]": "🎉",
            "[礼物]": "🎁",
            "[红包]": "🧧",
            "[發]": "🀄",
            "[福]": "🈴",
            "[猪头]": "🐷",
            "[鬼魂]": "👻",
            "[跳跳]": "🕺",
            "[发抖]": "😨",
            "[怄火]": "😡",
            "[转圈]": "🔄",
        }

        # 例如: payload = "你好[色]"
        # 替换成 payload = "你好😍"
        # 替换表情符号
        for key, value in emojilist.items():
            payload = payload.replace(key, value)

        return payload