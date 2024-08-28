class User:
    def __init__(
        self, 
        account,                                       # 用户账号
        nickname,                                      # 用户昵称
        gender,                                        # 用户性别
        age,                                           # 用户年龄
        avatar,                                        # 用户头像URL
        personal_signature,                            # 用户个人签名
        location,                                      # 用户所在地
        birth_date,                                    # 用户出生日期
        email,                                         # 用户电子邮箱
        phone_number,                                  # 用户电话号码
        hobbies,                                       # 用户兴趣爱好列表
        education_level,                               # 用户教育水平
        education_school,                              # 用户毕业学校
        occupation,                                    # 用户职业
        friend_list,                                   # 好友列表
        moments                                        # 用户朋友圈列表(所有历史发的朋友圈都在这里了, 点赞和评论的问题)
    ):
        self.account = account
        self.nickname = nickname
        self.gender = gender
        self.age = age
        self.avatar = avatar
        self.personal_signature = personal_signature
        self.location = location
        self.birth_date = birth_date
        self.email = email
        self.phone_number = phone_number
        self.hobbies = hobbies
        self.education_level = education_level
        self.education_school = education_school
        self.occupation = occupation
        self.friend_list = friend_list
        self.moments = moments

    def update_attribute(self, attribute_name, new_value):
        if hasattr(self, attribute_name):
            setattr(self, attribute_name, new_value)
            return True
        else:
            return False


if __name__ == "__main__":
    # 定义虚拟数据
    user1_data = {
        "account": "user123",
        "nickname": "Alice",
        "gender": "Female",
        "age": 28,
        "avatar": "alice_avatar.png",
        "personal_signature": "Live, laugh, love.",
        "location": "New York, USA",
        "birth_date": "1996-01-15",
        "email": "alice@example.com",
        "phone_number": "555-1234",
        "hobbies": ["reading", "traveling", "photography"],
        "education_level": "Bachelor's Degree",
        "education_school": "NYU",
        "occupation": "Software Engineer"
    }

    user2_data = {
        "account": "user456",
        "nickname": "Bob",
        "gender": "Male",
        "age": 35,
        "avatar": "bob_avatar.png",
        "personal_signature": "Keep it simple.",
        "location": "San Francisco, USA",
        "birth_date": "1989-07-22",
        "email": "bob@example.com",
        "phone_number": "555-5678",
        "hobbies": ["hiking", "gaming", "cooking"],
        "education_level": "Master's Degree",
        "education_school": "Stanford",
        "occupation": "Product Manager"
    }

    # 实例化两个对象
    user1 = User(**user1_data)
    user2 = User(**user2_data)

    # 打印两个对象的属性作为验证
    print("User 1:", vars(user1))
    print("User 2:", vars(user2))
