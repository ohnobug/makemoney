import { StyleSheet } from "react-native";
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
    ljn_list: {
      backgroundColor: theme.areaBackgroundColor,
      borderRadius: px2vw(10),
      marginBottom: px2vw(10),
    },
    ljn_list_item_last: {
      borderBottomColor: theme.areaBackgroundColor,
    },
    ljn_list_item: {
      height: px2vw(64),
      borderBottomColor: theme.borderColor,
      borderBottomWidth: px2vw(1),
      marginLeft: px2vw(17),
      marginRight: px2vw(17),
      display: "flex",
    },
    ljn_list_item_inner: {
      height: px2vw(64),
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
    },
    ljn_list_item_title: {
      flex: 1,
    },
    ljn_list_item_title_text: {
      color: theme.textColor,
      fontSize: px2vw(16),
    },
    ljn_list_item_desc: {
      flex: 1,
      display: "flex",
      alignItems: "flex-end",
    },
    ljn_list_item_desc_text: {
      color: theme.titleTextColor,
      fontSize: px2vw(14),
    },
    ljn_list_item_icon: {
      flexBasis: px2vw(20),
      display: "flex",
      alignItems: "flex-end",
    },
    ljn_list_item_icon_img: {
      // width: px2vw(16),
      // height: px2vw(16),
    },
  });
}
