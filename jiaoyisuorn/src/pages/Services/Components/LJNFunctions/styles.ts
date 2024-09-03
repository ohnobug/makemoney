import { StyleSheet } from "react-native";
import { px2vw } from "utils/utils";
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
    ljn_list_item: {
      flexGrow: 1,
      flexBasis: px2vw(68.2),
      height: px2vw(65),
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      flexDirection: "column",
      marginBottom: px2vw(10),
    },
    ljn_list_item_icon: {
      width: px2vw(35),
      height: px2vw(35),
      marginBottom: px2vw(8),
      // backgroundColor: "blue",
    },
    ljn_list_item_icon_img: {
      width: px2vw(35),
      height: px2vw(35),
    },
    ljn_list_item_title: {},
    ljn_list_item_title_inner: {
      color: theme.titleTextColor,
      textAlign: "center",
      fontSize: px2vw(11),
    },
  });
}
