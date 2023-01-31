import { StyleSheet } from "react-native";
import darkTheme from "../../themes/default/styles";
import lightTheme from "../../themes/light/styles";
import { px2vw } from "../../utils/utils";

export function setTheme(name: string) {
  let theme: ITheme;
  if (name === "dark") {
    theme = darkTheme;
  } else {
    theme = lightTheme;
  }

  return StyleSheet.create({
    // 小
    ljn_small_button: {
      flex: 0,
      paddingLeft: px2vw(20),
      paddingRight: px2vw(20),
      minHeight: px2vw(30),
      backgroundColor: theme.primaryColor,
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      borderRadius: px2vw(5),
    },
    ljn_small_button_text: {
      color: "white",
      fontSize: px2vw(12),
    },

    // 中
    ljn_middle_button: {
      flex: 0,
      paddingLeft: px2vw(25),
      paddingRight: px2vw(25),
      minHeight: px2vw(40),
      backgroundColor: theme.primaryColor,
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      borderRadius: px2vw(5),
    },
    ljn_middle_button_text: {
      color: "white",
      fontSize: px2vw(14),
    },

    // 常规
    ljn_normal_button: {
      flex: 0,
      paddingLeft: px2vw(25),
      paddingRight: px2vw(25),
      minHeight: px2vw(47),
      backgroundColor: theme.primaryColor,
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      borderRadius: px2vw(5),
    },
    ljn_normal_button_text: {
      color: "white",
      fontSize: px2vw(16),
    },

    // 大
    ljn_big_button: {
      flex: 0,
      paddingLeft: px2vw(25),
      paddingRight: px2vw(25),
      minHeight: px2vw(52),
      backgroundColor: theme.primaryColor,
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      borderRadius: px2vw(5),
    },
    ljn_big_button_text: {
      color: "white",
      fontSize: px2vw(18),
    },
  });
}
