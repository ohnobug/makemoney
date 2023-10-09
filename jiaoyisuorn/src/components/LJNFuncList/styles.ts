import { StyleSheet } from "react-native";
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

  return StyleSheet.create({
    ljn_func_list: {
      marginBottom: px2vw(9),
    },
    // 聊天项
    ljn_list_item: {
      backgroundColor: theme.chatBackgroundColor,
      height: px2vw(53),
      paddingLeft: px2vw(15),
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      // marginBottom: px2vw(10),
    },

    // 头像盒子
    ljn_list_avatar_box: {
      flexBasis: px2vw(22 + 17),
      display: "flex",
      justifyContent: "center",
    },
    // 头像
    ljn_list_avatar: {
      width: px2vw(22),
      height: px2vw(22),
      borderRadius: px2vw(3),
    },
    // 聊天窗口信息
    ljn_list_message_info: {
      height: px2vw(53),
      flex: 1,
      paddingRight: px2vw(15),
      display: "flex",
      flexDirection: "row",
      justifyContent: "space-between",
      borderBottomWidth: px2vw(0.5),
      borderBottomColor: theme.headerBorderBottomColor,
    },
    // 聊天窗口信息
    ljn_list_message_info_no_underline: {
      height: px2vw(53),
      flex: 1,
      paddingRight: px2vw(15),
      display: "flex",
      flexDirection: "row",
      justifyContent: "space-between",
      borderBottomWidth: px2vw(0.5),
      borderBottomColor: theme.chatBackgroundColor,
    },
    // 好友名字盒子
    ljn_list_friend_name_box: {
      maxWidth: "70%",
      // backgroundColor: "red",
      display: "flex",
      justifyContent: "center",
    },
    // 好友名字
    ljn_list_friend_name: {
      fontSize: px2vw(15),
      color: theme.chatFriendNameColor,
      // fontWeight: "500",
    },
    // 图标盒子
    ljn_list_date_box: {
      width: "30%",
      display: "flex",
      flexDirection: "row",
      justifyContent: "flex-end",
      alignItems: "center",
      // backgroundColor: "red",
    },
  });
}
