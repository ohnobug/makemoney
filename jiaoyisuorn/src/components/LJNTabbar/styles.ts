import { StyleSheet } from "react-native";
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
    ljn_tabbar: {
      height: px2vw(60),
      paddingTop: px2vw(5),
      paddingBottom: px2vw(5),
      display: "flex",
      flexDirection: "row",
      backgroundColor: theme.areaBackgroundColor,
      borderTopWidth: px2vw(1),
      borderTopColor: theme.borderColor,
    },
    ljn_tabbar_item: {
      flex: 1,
      display: "flex",
      flexDirection: "column",
      alignItems: "center",
    },
    ljn_tabbar_item_img_area: {
      flex: 1,
      display: "flex",
      alignItems: "center",
      flexDirection: "row",
    },
    ljn_tabbar_item_img: {
      width: px2vw(27),
      height: px2vw(27),
    },
    ljn_tabbar_item_title_area: {
      flex: 0,
      minHeight: px2vw(15),
      width: "100%",
      display: "flex",
      justifyContent: "center",
      flexDirection: "row",
      alignItems: "center",
    },
    ljn_tabbar_item_title: {
      fontSize: px2vw(12),
      color: theme.titleTextColor,
    },
    ljn_tabbar_item_title_active: {
      color: name === "dark" ? "white" : "#0089ff",
      fontWeight: "600",
    },
  });
}
