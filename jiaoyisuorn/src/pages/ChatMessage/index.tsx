import LJNHeader from "components/LJNHeader";
import LJNIcon from "components/LJNIcon";
import LJNScrollView from "components/LJNScrollView";
import { useStyles } from "hooks";
import React, { useRef, useEffect } from "react";
import { Image, ScrollView, Text, View } from "react-native";
import { setTheme } from "./styles";

type ItemProps = {
  id: string;
  friendName: string;
  message: string;
  belongToMe: boolean;
  avatar: any;
};
const DATA: ItemProps[] = [
  {
    id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
    friendName: "花重月数",
    message: "今天天气真好，阳光明媚，让人心情愉悦。",
    belongToMe: false,
    avatar: require("assets/chat/avatar/chat_1.jpg"),
  },
  {
    id: "4462b35d-e742-5011-9ed6-f10666ef8e9f",
    friendName: "旧梦如风°",
    message: "你吃过了吗？吃的什么？有没有想我？",
    belongToMe: false,
    avatar: require("assets/chat/avatar/chat_2.jpg"),
  },
  {
    id: "c7e7c26e-aa86-5e7b-9bbd-018f46b27e7a",
    friendName: "夏日柠檬女神",
    message: "我很高兴见到你。",
    belongToMe: false,
    avatar: require("assets/chat/avatar/chat_3.jpg"),
  },
  {
    id: "c7e7c26e-aa86-5e7b-9bbd-018f46b27e7a",
    friendName: "帅哥",
    message: "我很高兴见到你。",
    belongToMe: true,
    avatar: require("assets/chat/avatar/chat_5.jpg"),
  },
  {
    id: "c7e7c26e-aa86-5e7b-9bbd-018f46b27e7a",
    friendName: "帅哥",
    message: "我很高兴见到你。",
    belongToMe: true,
    avatar: require("assets/chat/avatar/chat_5.jpg"),
  },
  {
    id: "c7e7c26e-aa86-5e7b-9bbd-018f46b27e7a",
    friendName: "帅哥",
    message: "我很高兴见到你。",
    belongToMe: true,
    avatar: require("assets/chat/avatar/chat_5.jpg"),
  },
  {
    id: "c7e7c26e-aa86-5e7b-9bbd-018f46b27e7a",
    friendName: "帅哥",
    message: "我很高兴见到你。",
    belongToMe: true,
    avatar: require("assets/chat/avatar/chat_5.jpg"),
  },
  {
    id: "c7e7c26e-aa86-5e7b-9bbd-018f46b27e7a",
    friendName: "帅哥",
    message: "我很高兴见到你。",
    belongToMe: true,
    avatar: require("assets/chat/avatar/chat_5.jpg"),
  },
  {
    id: "c7e7c26e-aa86-5e7b-9bbd-018f46b27e7a",
    friendName: "帅哥",
    message: "我很高兴见到你。",
    belongToMe: true,
    avatar: require("assets/chat/avatar/chat_5.jpg"),
  },
  {
    id: "c7e7c26e-aa86-5e7b-9bbd-018f46b27e7a",
    friendName: "帅哥",
    message: "我很高兴见到你。",
    belongToMe: true,
    avatar: require("assets/chat/avatar/chat_5.jpg"),
  },
  {
    id: "c7e7c26e-aa86-5e7b-9bbd-018f46b27e7a",
    friendName: "帅哥",
    message: "我很高兴见到你。",
    belongToMe: true,
    avatar: require("assets/chat/avatar/chat_5.jpg"),
  },
  {
    id: "c7e7c26e-aa86-5e7b-9bbd-018f46b27e7a",
    friendName: "帅哥",
    message: "我很高兴见到你。",
    belongToMe: true,
    avatar: require("assets/chat/avatar/chat_5.jpg"),
  },
  {
    id: "c7e7c26e-aa86-5e7b-9bbd-018f46b27e7a",
    friendName: "帅哥",
    message: "我很高兴见到你。",
    belongToMe: true,
    avatar: require("assets/chat/avatar/chat_5.jpg"),
  },
  {
    id: "c7e7c26e-aa86-5e7b-9bbd-018f46b27e7a",
    friendName: "帅哥",
    message: "我很高兴见到你。",
    belongToMe: true,
    avatar: require("assets/chat/avatar/chat_5.jpg"),
  },
  {
    id: "c7e7c26e-aa86-5e7b-9bbd-018f46b27e7a",
    friendName: "帅哥",
    message: "我很高兴见到你。",
    belongToMe: true,
    avatar: require("assets/chat/avatar/chat_5.jpg"),
  },
  {
    id: "c7e7c26e-aa86-5e7b-9bbd-018f46b27e7a",
    friendName: "帅哥",
    message: "我很高兴见到你。",
    belongToMe: true,
    avatar: require("assets/chat/avatar/chat_5.jpg"),
  },
  {
    id: "c7e7c26e-aa86-5e7b-9bbd-018f46b27e7a",
    friendName: "帅哥",
    message: "我很高兴见到你。",
    belongToMe: true,
    avatar: require("assets/chat/avatar/chat_5.jpg"),
  },
  {
    id: "c7e7c26e-aa86-5e7b-9bbd-018f46b27e7a",
    friendName: "帅哥",
    message: "我很高兴见到你。",
    belongToMe: true,
    avatar: require("assets/chat/avatar/chat_5.jpg"),
  },
];

type Props = any;
export default function ChatMessage({ route, navigation }: Props) {
  const styles = useStyles(setTheme);
  let bigScrollView = useRef<ScrollView>(null);

  const { friendInfo } = route.params;
  useEffect(() => {
    // console.log(friendInfo)

    bigScrollView.current.scrollToEnd()
  }, [])

  
  return (
    <View style={styles.container}>
      <LJNHeader
        onBack={() => {
          navigation.navigate("chat");
        }}
        onMore={() => {}}
        title={friendInfo.friendName}
      ></LJNHeader>

      
      <LJNScrollView
        style={styles.ljn_main}
        horizontal={false}
        ref={bigScrollView}
        children={
          <>
            {DATA.map((item, index) => {
              return (
                <View key={index}>
                  {index == 2 ? (
                    <View style={styles.ljn_message_time_box}>
                      <Text style={styles.ljn_message_time}>00:26</Text>
                    </View>
                  ) : null}

                  {item.belongToMe ? (
                    <View style={styles.ljn_message_item_belong_to_me}>
                      {/* 消息 */}
                      <View style={styles.ljn_message_info_belong_to_me}>
                        <Text style={styles.ljn_message_belong_to_me}>
                          {item.message}
                        </Text>
                      </View>

                      {/* 头像 */}
                      <View style={styles.ljn_avatar_box_belong_to_me}>
                        <Image
                          style={styles.ljn_avatar_belong_to_me}
                          source={item.avatar}
                        />

                        <View style={styles.ljn_triangle_belong_to_me}>
                          <LJNIcon title={"zuo"} size={18} color="#95eb6c" />
                        </View>
                      </View>
                    </View>
                  ) : (
                    <View style={styles.ljn_message_item}>
                      {/* 头像 */}
                      <View style={styles.ljn_avatar_box}>
                        <Image style={styles.ljn_avatar} source={item.avatar} />

                        <View style={styles.ljn_triangle}>
                          <LJNIcon title={"you"} size={18} color="#fff" />
                        </View>
                      </View>

                      {/* 消息 */}
                      <View style={styles.ljn_message_info}>
                        <View style={styles.ljn_message_name_box}>
                          <Text style={styles.ljn_message_name}>
                            {item.friendName}
                          </Text>
                        </View>
                        <View style={styles.ljn_message_box}>
                          <Text style={styles.ljn_message}>{item.message}</Text>
                        </View>
                      </View>
                    </View>
                  )}
                </View>
              );
            })}
          </>
        }
      />
      {/* 输入框 */}
      <View style={styles.ljn_footer_message_input}>
        {/* 语音 */}
        <View style={styles.ljn_footer_voice}>
          <LJNIcon title={"yuyin1"} size={30} color="#000" />
        </View>
        {/* 输入框 */}
        <View style={styles.ljn_footer_input}>
          <View style={styles.ljn_footer_input_inner}></View>
        </View>
        {/* 表情包 */}
        <View style={styles.ljn_footer_emoticons}>
          <LJNIcon title={"biaoqingbao"} size={26.5} color="#000" />
        </View>
        {/* 更多 */}
        <View style={styles.ljn_footer_more}>
          <LJNIcon title={"jiahao1"} size={26} color="#000" />
        </View>
      </View>
    </View>
  );
}
