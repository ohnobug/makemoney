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
    ljn_header: {
      flexBasis: px2vw(40),
      flex: 0,
      height: px2vw(40),
      // backgroundColor: "red",
      display: "flex",
      flexDirection: "row",
    },
    ljn_header_left: {
      flex: 1,
      display: "flex",
      justifyContent: "center",
      alignItems: "flex-start",
    },
    ljn_header_left_icon: {
      marginLeft: px2vw(17),
    },
    ljn_header_middle: {
      flex: 1,
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
    },
    ljn_header_middle_title: {
      fontSize: px2vw(18),
      color: theme.titleTextColor,
      fontWeight: "600",
    },
    ljn_header_right: {
      flex: 1,
      display: "flex",
      justifyContent: "center",
      alignItems: "flex-end",
    },
  });
}
