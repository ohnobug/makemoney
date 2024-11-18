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
      backgroundColor: theme.chatMessageBackgroundColor,
    },
    ljn_main: {
      flex: 1,
      maxHeight:
        window.height -
        AppStylesConfig.tabbarHeight -
        AppStylesConfig.headerHeight,
      paddingTop: px2vw(12),
    },

    // 时间盒子
    ljn_message_time_box: {
      height: px2vw(55),
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
    },
    // 时间显示
    ljn_message_time: {
      fontSize: px2vw(11),
      color: theme.chatTimeColor,
    },
    // 聊天信息
    ljn_message_item: {
      display: "flex",
      flexDirection: "row",
      marginBottom: px2vw(12),
    },
    // 头像盒子
    ljn_avatar_box: {
      flexBasis: px2vw(60),
      display: "flex",
      alignItems: "center",
      // backgroundColor: "blue",
    },
    // 头像
    ljn_avatar: {
      width: px2vw(39),
      height: px2vw(39),
      borderRadius: px2vw(4),
    },
    // 信息：名字 + 信息
    ljn_message_info: {
      display: "flex",
      flexDirection: "column",
    },
    // 名字盒子
    ljn_message_name_box: {
      height: px2vw(19),
      display: "flex",
      justifyContent: "center",
      // backgroundColor: "red",
    },
    // 名字
    ljn_message_name: {
      color: theme.chatBriefMessageColor,
      fontSize: px2vw(11),
    },
    // 消息盒子
    ljn_message_box: {
      flex: 0,
      maxWidth: px2vw(260),
      // minHeight: px2vw(40),
      backgroundColor: "white",
      paddingHorizontal: px2vw(12),
      paddingVertical: px2vw(10),
      display: "flex",
      borderRadius: px2vw(5),
    },
    // 消息
    ljn_message: {
      fontSize: px2vw(16),
      color: theme.chatMessageColor,
    },
    // 三角形图标
    ljn_triangle: {
      position: "absolute",
      top: px2vw(29),
      right: px2vw(-8.5),
    },

    // 我的消息盒子
    ljn_message_item_belong_to_me: {
      display: "flex",
      flexDirection: "row",
      justifyContent: "flex-end",
      marginBottom: px2vw(12),
    },
    // 我的头像
    ljn_avatar_box_belong_to_me: {
      flexBasis: px2vw(60),
      display: "flex",
      alignItems: "center",
      // backgroundColor: "blue",
    },
    // 我的头像
    ljn_avatar_belong_to_me: {
      width: px2vw(39),
      height: px2vw(39),
      borderRadius: px2vw(4),
    },
    // 我的消息
    ljn_message_info_belong_to_me: {
      display: "flex",
      flexDirection: "column",
      flex: 0,
      maxWidth: px2vw(260),
      minHeight: px2vw(40),
      backgroundColor: "#95ec69",
      paddingHorizontal: px2vw(12),
      paddingVertical: px2vw(10),
      borderRadius: px2vw(5),
    },
    // 我的消息
    ljn_message_belong_to_me: {
      fontSize: px2vw(16),
      color: theme.chatMessageColor,
    },
    // 三角形图标
    ljn_triangle_belong_to_me: {
      position: "absolute",
      top: px2vw(11),
      left: px2vw(-8.5),
    },
    // 底部输入框
    ljn_footer_message_input: {
      height: px2vw(53.5),
      backgroundColor: theme.tabbarBackgroundColor,
      display: "flex",
      flexDirection: "row",
      borderTopColor: theme.headerBorderBottomColor,
      borderTopWidth: px2vw(0.5),
    },
    ljn_footer_voice: {
      flexBasis: px2vw(45),
      // backgroundColor: "red",
      display: "flex",
      alignItems: "center",
      justifyContent: "center"
    },
    // 输入框
    ljn_footer_input: {
      flex: 1,
      // backgroundColor: "red",
      display: "flex",
      justifyContent: "center"
    },
    // 输入框内部
    ljn_footer_input_inner: {
      backgroundColor: "white",
      height: px2vw(38)
    },
    ljn_footer_emoticons: {
      flexBasis: px2vw(40),
      display: "flex",
      alignItems: "flex-end",
      justifyContent: "center",
      // backgroundColor: "red"
    },
    ljn_footer_more: {
      flexBasis: px2vw(45),
      display: "flex",
      alignItems: "center",
      justifyContent: "center"
    },
  });
}
