class Group:
    def __init__(self, group_id, name, avatar_url, creator, description=""):
        self.group_id = group_id        # 群号
        self.name = name                # 群名称
        self.avatar_url = avatar_url    # 群头像URL
        self.members = []               # 群成员列表
        self.creator = creator          # 群主
        self.description = description  # 群描述
        self.announcements = []         # 群公告列表
        self.messages = []              # 群消息历史

    def add_member(self, member):
        """添加群成员"""
        if member not in self.members:
            self.members.append(member)

    def remove_member(self, member):
        """移除群成员"""
        if member in self.members:
            self.members.remove(member)

    def post_announcement(self, announcement):
        """发布群公告"""
        self.announcements.append(announcement)

    def send_message(self, message, sender):
        """发送消息到群组"""
        self.messages.append((sender, message))

    def get_member_count(self):
        """获取群成员数量"""
        return len(self.members)

    def __str__(self):
        return f"Group({self.name}, Members: {self.get_member_count()})"

# 示例使用
group = Group(group_id=1, name="Python Developers", avatar_url="http://example.com/avatar.jpg", creator="JohnDoe")
group.add_member("Alice")
group.add_member("Bob")
group.post_announcement("Welcome to the Python Developers group!")
group.send_message("Hello everyone!", sender="JohnDoe")

print(group)
print(f"Members: {group.members}")
print(f"Announcements: {group.announcements}")
print(f"Messages: {group.messages}")
