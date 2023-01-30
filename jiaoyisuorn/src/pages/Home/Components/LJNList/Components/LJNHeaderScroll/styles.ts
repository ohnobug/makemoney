import { StyleSheet } from "react-native";
import { px2vw } from "../../../../../../utils/utils";
import darkTheme from "../../../../../../themes/default/styles";
import lightTheme from "../../../../../../themes/light/styles";

export function setTheme(name: string) {
  let theme: ITheme;
  if (name === "dark") {
    theme = darkTheme;
  } else {
    theme = lightTheme;
  }

  return StyleSheet.create({
    ljn_tabs: {
      flex: 1,
      width: px2vw(375),
      maxHeight: px2vw(43),
      borderBottomWidth: px2vw(1),
      borderBottomColor: theme.borderColor,
      backgroundColor: theme.areaBackgroundColor,
    },
    ljn_tab: {
      paddingLeft: px2vw(10),
      paddingRight: px2vw(10),
      height: px2vw(40),
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
    },
    ljn_fly_bottom: {
      height: px2vw(3),
      backgroundColor: "#32a1fc",
      position: "absolute",
      bottom: 0,
      left: 0,
    },
    ljn_tab_text: {
      color: theme.titleTextColor,
      fontSize: px2vw(14),
      fontWeight: "600",
    },
    ljn_tab_text_active: {
      color: "#32a1fc",
    },
  });
}
