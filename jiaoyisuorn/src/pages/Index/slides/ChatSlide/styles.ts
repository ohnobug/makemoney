import { Dimensions, StyleSheet } from "react-native";
import AppStylesConfig from "AppStylesConfig";
import darkTheme from "themes/default/styles";
import lightTheme from "themes/light/styles";
import { px2vw } from "utils/utils";

export function setTheme(name: string) {
  let theme: ITheme;

  if (name === "dark") {
    theme = darkTheme;
  } else {
    theme = lightTheme;
  }

  const window = Dimensions.get("window");
  return StyleSheet.create({
    container: {
      flex: 1,
      display: "flex",
      flexDirection: "column",
      backgroundColor: theme.chatBackgroundColor,
    },
    ljn_main: {
      flex: 1,
      maxHeight:
        window.height -
        px2vw(AppStylesConfig.tabbarHeight) -
        px2vw(AppStylesConfig.headerHeight),
    },
    ljn_footer: {
      flex: 0,
      minHeight: px2vw(AppStylesConfig.tabbarHeight),
    },
    ljn_big_box: {
      height: px2vw(500),
      display: "flex",
      alignItems: "center",
      justifyContent: "center",
    },
    // 聊天项
    ljn_chat_item: {
      backgroundColor: theme.chatBackgroundColor,
      padding: 0,
      height: px2vw(69),
      marginHorizontal: 15,
      display: "flex",
      flexDirection: "row",
    },
    // 头像盒子
    ljn_avatar_box: {
      flexBasis: px2vw(47 + 10),
      display: "flex",
      justifyContent: "center",
    },
    // 头像
    ljn_avatar: {
      width: px2vw(46.5),
      height: px2vw(46.5),
      borderRadius: px2vw(5),
    },
    // 聊天窗口信息
    ljn_chat_message_info: {
      flex: 1,
      borderBottomWidth: px2vw(0.8),
      borderBottomColor: theme.chatBorderColor,
      paddingTop: px2vw(13),
    },
    // 好友信息行
    ljn_chat_friend_info_row: {
      display: "flex",
      flexDirection: "row",
      justifyContent: "space-between",
      marginBottom: px2vw(4),
      // height: px2vw(30),
      // marginBottom: px2vw(4),
      // marginTop: px2vw(1),
    },
    // 好友名字盒子
    ljn_chat_friend_name_box: {
      maxWidth: "70%",
      // backgroundColor: "blue",
    },
    // 好友名字
    ljn_chat_friend_name: {
      fontSize: px2vw(16),
      color: theme.chatFriendNameColor,
      // fontWeight: "500",
    },
    // 聊天日期盒子
    ljn_chat_date_box: {
      width: "30%",
      display: "flex",
      flexDirection: "row",
      justifyContent: "flex-end",
      alignItems: "flex-start",
      // backgroundColor: "red",
    },
    // 聊天日期
    ljn_chat_date: {
      fontSize: px2vw(10),
      color: theme.chatMessageColor,
    },

    // 消息行
    ljn_chat_message_box_row: {
      display: "flex",
      flexDirection: "row",
      justifyContent: "space-between",
    },

    // 最后消息盒子
    ljn_chat_message_box: {
      width: "70%",
    },
    // 最后消息
    ljn_chat_message: {
      color: theme.chatMessageColor,
      fontSize: px2vw(12),
    },
    // 图标
    ljn_chat_message_icon: {
      width: "30%",
      display: "flex",
      justifyContent: "center",
      alignItems: "flex-end",
      // backgroundColor: "red",
    },
  });
}
