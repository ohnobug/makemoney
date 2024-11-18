import { StyleSheet } from "react-native";
import { px2vw } from "utils/utils";
import cssConfig from "../cssConfig";
import darkTheme from "themes/default/styles";
import lightTheme from "themes/light/styles";

export function setTheme(name: string) {
  let theme: ITheme;
  if (name === "dark") {
    theme = darkTheme;
  } else {
    theme = lightTheme;
  }

  return StyleSheet.create({
    ljn_modal_container: {
      flex: 1,
      backgroundColor: "#ffffff94",
      zIndex: 99999999999,
      position: "absolute",
      top: 0,
      left: 0,
      width: px2vw(375),
      height: "100%",
    },
    ljn_modal_box: {
      width: px2vw(320),
      height: px2vw(370),
      backgroundColor: theme.areaBackgroundColor,
      position: "absolute",
      zIndex: 99999,
      left: px2vw(375 / 2 - 320 / 2),
      top: px2vw(375 / 2 - 320 / 2),
      display: "flex",
      flexDirection: "column",
      justifyContent: "center",
      alignItems: "center",
      borderRadius: px2vw(5),
    },

    // 图片盒子
    ljn_modal_photo_box: {
      flex: 1,
      // backgroundColor: "blue",
      display: "flex",
      justifyContent: "center",
      alignContent: "center",
    },
    ljn_modal_photo_box_photo: {
      width: px2vw(300),
      height: px2vw(300),
    },

    // 弹窗标题盒子
    ljn_modal_title_box: {
      width: px2vw(300),
      flexBasis: px2vw(40),
      marginBottom: px2vw(10),
      // backgroundColor: "green",
      display: "flex",
      flexDirection: "row",
      justifyContent: "center",
      alignItems: "center",
    },

    ljn_modal_title_box_like_btn_box: {
      flex: 1,
      display: "flex",
      alignItems: "center",
    },

    // 点赞按钮
    ljn_modal_title_box_like_btn: {
      display: "flex",
      justifyContent: "center",
      width: px2vw(25),
      height: px2vw(25),
      marginRight: px2vw(5),
    },
  });
}
