import { Dimensions, StyleSheet } from "react-native";
import { px2vw } from "../../utils/utils";
import darkTheme from "../../themes/default/styles";
import lightTheme from "../../themes/light/styles";

const window = Dimensions.get("window");
export function setTheme(name: string) {
  let theme: any;
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
    },
    ljn_main: {
      flex: 1,
      maxHeight: window.height - px2vw(60),
    },

    // 用户信息
    ljn_header_area: {
      height: px2vw(350),
      backgroundColor: theme.areaBackgroundColor,
      borderBottomLeftRadius: px2vw(10),
      borderBottomRightRadius: px2vw(10),
      marginBottom: px2vw(12),
      padding: px2vw(10),
    },
    // 顶部功能
    ljn_header_function: {
      height: px2vw(30),
      display: "flex",
      flexDirection: "row",
      justifyContent: "flex-end",
      alignItems: "center",
      // marginBottom: px2vw(10),
    },
    // 顶部功能按钮
    ljn_header_function_btn: {
      flex: 0,
      width: px2vw(20),
      height: px2vw(20),
      minWidth: px2vw(20),
      minHeight: px2vw(20),
      marginLeft: px2vw(27),
    },

    // 用户名称信息
    ljn_userinfo_area: {
      height: px2vw(77),
      // backgroundColor: "yellow",
      display: "flex",
      flexDirection: "row",
      marginBottom: px2vw(9),
    },
    ljn_userinfo_avatar_area: {
      flexBasis: px2vw(92),
    },
    ljn_userinfo_avatar_area_img: {
      height: px2vw(65),
      width: px2vw(65),
      borderRadius: px2vw(65),
    },
    ljn_userinfo: {
      flex: 1,
      display: "flex",
      flexDirection: "column",
    },
    ljn_userinfo_username: {
      marginBottom: px2vw(7),
      height: px2vw(25),
    },
    ljn_userinfo_username_text: {
      fontSize: px2vw(20),
      color: theme.textColor,
      fontWeight: "600",
    },

    ljn_userinfo_uid: {
      display: "flex",
      alignItems: "flex-start",
      marginBottom: px2vw(7),
      height: px2vw(16),
    },
    ljn_userinfo_uid_text: {
      borderRadius: px2vw(8),
      backgroundColor: "#0e131f",
      color: theme.textColor,
      height: px2vw(16),
      fontSize: px2vw(12),
      display: "flex",
      alignContent: "center",
      justifyContent: "center",
      paddingLeft: px2vw(8),
      paddingRight: px2vw(8),
    },
    ljn_userinfo_about: {
      display: "flex",
      flexDirection: "row",
    },
    ljn_userinfo_about_inner: {
      marginRight: px2vw(15),
      display: "flex",
      flexDirection: "row",
    },

    ljn_userinfo_about_inner_val: {
      color: theme.textColor,
      fontSize: px2vw(12),
      marginRight: px2vw(5),
    },
    ljn_userinfo_about_inner_title: {
      fontSize: px2vw(12),
      color: theme.titleTextColor,
    },

    ljn_userinfo_auth: {
      flexBasis: px2vw(68),
    },
    ljn_userinfo_auth_btn1: {
      height: px2vw(22),
      borderColor: theme.borderColor,
      borderWidth: px2vw(1),
      borderTopStartRadius: px2vw(22),
      borderBottomStartRadius: px2vw(22),
      paddingLeft: px2vw(10),
      paddingRight: px2vw(10),
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      marginBottom: px2vw(4),
      marginTop: px2vw(15),
      position: "relative",
      right: px2vw(-9),
    },
    ljn_userinfo_auth_btn1_text: {
      fontSize: px2vw(12),
      color: theme.titleTextColor,
    },
    ljn_userinfo_auth_btn2: {
      height: px2vw(22),
      borderColor: theme.borderColor,
      borderWidth: px2vw(1),
      borderTopStartRadius: px2vw(22),
      borderBottomStartRadius: px2vw(22),
      paddingLeft: px2vw(10),
      paddingRight: px2vw(10),
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      position: "relative",
      right: px2vw(-9),
    },
    ljn_userinfo_auth_btn2_text: {
      fontSize: px2vw(12),
      color: theme.titleTextColor,
    },

    // 用户等级
    ljn_userinfo_level_area: {
      // height: px2vw(64),
      backgroundColor: "#2a2f3b",
      borderRadius: px2vw(10),
      borderWidth: px2vw(2),
      borderColor: theme.borderColor,
      paddingLeft: px2vw(8),
      paddingRight: px2vw(8),
      paddingTop: px2vw(3),
      paddingBottom: px2vw(3),
      marginBottom: px2vw(5),
    },
    ljn_userinfo_level_row1: {
      height: px2vw(30),
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

    // 功能区1
    ljn_userinfo_detail_func1: {
      borderBottomColor: theme.borderColor,
      borderBottomWidth: px2vw(1),
      // height: px2vw(38),
      // paddingBottom: px2vw(5),
    },

    ljn_list_area: {
      backgroundColor: theme.areaBackgroundColor,
      display: "flex",
      flexDirection: "row",
      flexWrap: "wrap",
    },
    ljn_list_item: {
      flexGrow: 1,
      flexBasis: px2vw(68.2),
      height: px2vw(65),
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      flexDirection: "column",
      marginTop: px2vw(5),
    },
    ljn_list_item_icon: {
      width: px2vw(30),
      height: px2vw(30),
      marginBottom: px2vw(2),
      // backgroundColor: "blue",
    },
    ljn_list_item_icon_img: {
      width: px2vw(30),
      height: px2vw(30),
    },
    ljn_list_item_title: {},
    ljn_list_item_title_inner: {
      color: theme.titleTextColor,
      textAlign: "center",
      fontSize: px2vw(11),
    },

    // 功能区2
    ljn_userinfo_detail_func2: {},

    // 活动中心区域
    ljn_activation_area: {
      display: "flex",
      flexWrap: "wrap",
      flexDirection: "row",
      justifyContent: "space-between",
    },
    ljn_activation_box: {
      // flexBasis: px2vw(177.5),
      width: px2vw(182.5),
      height: px2vw(177),
      backgroundColor: theme.areaBackgroundColor,
      marginBottom: px2vw(10),
      borderRadius: px2vw(10),
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
    },
    ljn_activation_box_text: {
      fontSize: px2vw(30),
      color: "white",
    },

    ljn_footer: {
      flex: 0,
      minHeight: px2vw(60),
    },
  });
}
