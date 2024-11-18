import { Dimensions, StyleSheet } from "react-native";
import { px2vw } from "utils/utils";
import darkTheme from "themes/default/styles";
import lightTheme from "themes/light/styles";

const window = Dimensions.get("window");
export function setTheme(name: string) {
  let theme: ITheme;
  if (name === "dark") {
    theme = darkTheme;
  } else {
    theme = lightTheme;
  }

  return StyleSheet.create({
    container: {
      flex: 1,
      display: "flex",
      flexDirection: "column",
      backgroundColor: theme.backgroundColor,
    },
    ljn_main: {
      flex: 1,
      maxHeight: window.height - px2vw(60),
    },
    // 用户信息
    ljn_header_area: {
      height: px2vw(185),
      backgroundColor: theme.areaBackgroundColor,
      borderBottomLeftRadius: px2vw(10),
      borderBottomRightRadius: px2vw(10),
      marginBottom: px2vw(12),
      // padding: px2vw(10),
    },
    // 顶部功能
    ljn_header_function: {
      height: px2vw(30),
      display: "flex",
      flexDirection: "row",
      justifyContent: "flex-end",
      alignItems: "center",
      // marginBottom: px2vw(10),
      position: "absolute",
      top: px2vw(30),
      right: px2vw(13)
    },
    // 顶部功能按钮
    ljn_header_function_btn: {
      flex: 0,
      flexBasis: px2vw(25),
      marginLeft: px2vw(25),
      height: px2vw(30),
      width: px2vw(30),
      display: "flex",
      flexDirection: "row",
      justifyContent: "center",
      alignItems: "center",
    },

    // 用户名称信息
    ljn_userinfo_area: {
      marginTop: px2vw(64),
      // height: px2vw(77),
      // backgroundColor: "yellow",
      display: "flex",
      flexDirection: "row",
      marginBottom: px2vw(9),
    },
    ljn_userinfo_avatar_area: {
      marginLeft: px2vw(23),
      marginRight: px2vw(16),
      // flexBasis: px2vw(92),
      // backgroundColor: "blue",
    },
    ljn_userinfo_avatar_area_img: {
      height: px2vw(60),
      width: px2vw(60),
      borderRadius: px2vw(5),
    },
    ljn_userinfo: {
      flex: 1,
      display: "flex",
      flexDirection: "column",
      // backgroundColor: "yellow",
    },
    ljn_userinfo_username: {
      marginTop: px2vw(5),
      marginBottom: px2vw(12),
      height: px2vw(22),
    },
    ljn_userinfo_username_text: {
      fontSize: px2vw(18),
      color: "#000",
      fontWeight: "600",
    },
    ljn_userinfo_uid: {
      display: "flex",
      alignItems: "flex-start",
      marginBottom: px2vw(15),
      height: px2vw(16),
    },
    // 微信号
    ljn_userinfo_uid_area: {
      // backgroundColor: "blue",
      display: "flex",
      flexDirection: "row",
      alignContent: "center",
      justifyContent: "center",
      // paddingLeft: px2vw(8),
      // paddingRight: px2vw(8),
      height: px2vw(18),
      borderRadius: px2vw(8),
    },
    ljn_userinfo_uid_text: {
      // flexBasis: px2vw(200),
      flex: 1,
      color: theme.textColor,
      fontSize: px2vw(14),
    },
    ljn_userinfo_uid_copy_icon: {
      flexBasis: px2vw(35),
      marginLeft: px2vw(5),
      display: "flex",
      alignContent: "center",
      justifyContent: "center",
    },
    ljn_userinfo_uid_copy_icon2: {
      flexBasis: px2vw(20),
      display: "flex",
      alignContent: "center",
      justifyContent: "center",
      paddingRight: px2vw(30),
      // backgroundColor: "blue"
    },




    // 用户等级
    ljn_userinfo_level_area: {
      backgroundColor: theme.areaBackgroundColor,
      borderRadius: px2vw(10),
      borderWidth: px2vw(1),
      borderColor: theme.borderColor,
      paddingTop: px2vw(3),
      paddingRight: px2vw(8),
      paddingBottom: px2vw(3),
      paddingLeft: px2vw(8),
      marginBottom: px2vw(5),
    },
    ljn_userinfo_level_row1: {
      height: px2vw(40),
      borderBottomColor: theme.borderColor,
      borderBottomWidth: px2vw(1),
      display: "flex",
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
    },
    ljn_userinfo_level_row1_left: {},
    ljn_userinfo_level_row1_left_text1: {
      color: theme.textColor,
      fontWeight: "600",
      fontSize: px2vw(18),
      fontStyle: "italic",
    },
    ljn_userinfo_level_row1_right: {
      display: "flex",
      flexDirection: "row",
    },
    ljn_userinfo_level_row1_right_text1: {
      color: theme.textColor,
      marginRight: px2vw(5),
    },
    ljn_userinfo_level_row1_right_text2: {
      color: "#009bff",
      fontSize: px2vw(14),
    },
    ljn_userinfo_level_row2: {
      height: px2vw(30),
      display: "flex",
      flexDirection: "row",
      justifyContent: "flex-end",
      alignItems: "center",
    },
    ljn_userinfo_level_row2_text: {
      color: theme.titleTextColor,
      textAlign: "right",
      fontSize: px2vw(12),
    },

  });
}
