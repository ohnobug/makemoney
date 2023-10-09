import { StyleSheet } from "react-native";
import AppStylesConfig from "../../AppStylesConfig";
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
    ljn_header: {
      height: AppStylesConfig.headerHeight,
      flexBasis: AppStylesConfig.headerHeight,
      flex: 0,
      backgroundColor: theme.headerBackgroundColor,
      display: "flex",
      flexDirection: "row",
      borderBottomColor: theme.headerBorderBottomColor,
      borderBottomWidth: px2vw(0.5),
    },
    ljn_header_left: {
      flex: 1,
      display: "flex",
      justifyContent: "center",
      alignItems: "flex-start",
      // backgroundColor: "red",
    },
    ljn_header_left_icon: {
      paddingLeft: px2vw(17),
      paddingRight: px2vw(17),
      height: px2vw(40),
      display: "flex",
      justifyContent: "center",
    },
    ljn_header_middle: {
      flex: 1,
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
    },
    ljn_header_middle_title: {
      fontSize: px2vw(16),
      color: theme.titleTextColor,
      fontWeight: "600",
    },
    ljn_header_right: {
      flex: 1,
      display: "flex",
      justifyContent: "center",
      alignItems: "flex-end",
    },
    ljn_header_right_icon: {
      paddingLeft: px2vw(17),
      paddingRight: px2vw(17),
      height: px2vw(40),
      display: "flex",
      justifyContent: "center",
      marginTop: px2vw(4),
      // backgroundColor: "red",
    },
  });
}
