class Session:
    def __init__(self, session_id, members):
        self.session_id = session_id     # 会话ID
        self.members = members           # 会话成员列表
        self.last_message_time           # 最后消息时间
        self.messages = []               # 消息历史

    def send_message(self, sender, message):
        self.messages.append((sender, message))
