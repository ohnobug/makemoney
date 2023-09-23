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
    ljn_activation_box: {
      // flexBasis: px2vw(177.5),
      width: px2vw(182.5),
      height: px2vw(177),
      backgroundColor: theme.areaBackgroundColor,
      marginBottom: px2vw(10),
      borderRadius: px2vw(10),
      display: "flex",
      flexDirection: "column",
    },
    ljn_activation_header: {
      flex: 0,
      flexBasis: px2vw(38),
      display: "flex",
      flexDirection: "row",
    },
    ljn_activation_header_left: {
      flex: 2,
      display: "flex",
      justifyContent: "center",
      alignItems: "flex-start",
    },
    ljn_activation_header_left_title: {
      fontSize: px2vw(16),
      color: theme.textColor,
      marginLeft: px2vw(10),
    },
    ljn_activation_header_right: {
      flex: 1,
      display: "flex",
      justifyContent: "center",
      alignItems: "flex-end",
      marginRight: px2vw(10),
    },
    ljn_activation_header_title: {},
    ljn_activation_main: {
      flex: 1,
      fontSize: px2vw(30),
      paddingTop: px2vw(10),
      paddingLeft: px2vw(20),
      paddingBottom: px2vw(20),
      paddingRight: px2vw(20),
      display: "flex",
      flexDirection: "column",
    },
    ljn_activation_row1: {
      flex: 1,
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
    },
    ljn_activation_row1_img: {
      height: px2vw(30),
      width: px2vw(80),
    },
    ljn_activation_row2: {
      flex: 1,
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
    },
    ljn_activation_row2_text: {
      color: theme.textColor,
      fontSize: px2vw(14),
    },
    ljn_activation_row3: {
      flex: 1,
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
    },
  });
}
