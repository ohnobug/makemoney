import { StyleSheet, Dimensions } from "react-native";
import { px2vw } from "../../utils/utils";
import darkTheme from "../../themes/default/styles";
import lightTheme from "../../themes/light/styles";

export function setTheme(name: string) {
  let theme: ITheme;
  if (name === "dark") {
    theme = darkTheme;
  } else {
    theme = lightTheme;
  }

  return StyleSheet.create({
    ljn_line_title: {
      width: "100%",
      // backgroundColor: "yellow",
      display: "flex",
      alignItems: "center",
      justifyContent: "center",
      position: "relative",
    },
    ljn_title: {
      color: theme.titleTextColor,
      zIndex: 1,
      backgroundColor: theme.backgroundColor,
      paddingLeft: px2vw(30),
      paddingRight: px2vw(30),
    },
    ljn_line: {
      height: px2vw(1),
      backgroundColor: theme.borderColor,
      position: "absolute",
      top: px2vw(10),
      width: "100%",
      zIndex: 0,
    },
  });
}
