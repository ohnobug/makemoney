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
    ljn_container: {
      flex: 1,
      display: "flex",
      flexDirection: "column",
      backgroundColor: theme.backgroundColor,
    },
    ljn_main: {
      flex: 1,
      maxHeight: window.height - px2vw(190),
    },
    ljn_logout_area: {
      flex: 0,
      flexBasis: px2vw(150),
      padding: px2vw(10),
      display: "flex",
      alignItems: "center",
      // backgroundColor: "red",
      flexDirection: "column",
    },
    ljn_switch_account: {
      marginBottom: px2vw(31),
      color: theme.textColor,
    },
    ljn_logout: {
      color: theme.textColor,
      fontSize: px2vw(14),
    },
  });
}
