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
    ljn_container: {
      height: px2vw(570),
      backgroundColor: theme.areaBackgroundColor,
      borderRadius: px2vw(10),
      marginBottom: px2vw(10),
      display: "flex",
      flexDirection: "column",
    },

    // ----------------------------------列表 start
    ljn_list_area: {
      display: "flex",
      flex: 1,
    },

    // -------------------- 标题 start
    ljn_list_title_area: {
      display: "flex",
      flexDirection: "row",
      marginBottom: px2vw(5),
      minHeight: px2vw(30),
      marginTop: px2vw(5),
      flex: 0,
    },
    ljn_list_title1: {
      flex: 1.5,
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "flex-start",
    },
    ljn_list_title2: {
      flex: 1,
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
    },
    ljn_list_title3: {
      flex: 1,
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "flex-end",
    },
    ljn_list_title_inner: {
      fontSize: px2vw(14),
      color: "#707589",
    },
    // -------------------- 标题 end

    ljn_list: {
      display: "flex",
      flex: 1,
      flexDirection: "column",
      paddingLeft: px2vw(12),
      paddingRight: px2vw(12),
    },
    ljn_list_inner: {
      flex: 1,
    },

    ljn_list_item: {
      display: "flex",
      flexDirection: "row",
      height: px2vw(30),
      marginBottom: px2vw(15),
      backgroundColor: theme.areaBackgroundColor,
    },
    ljn_list_item_column1: {
      flex: 1.5,
      display: "flex",
      flexDirection: "row",
      justifyContent: "flex-start",
      alignItems: "center",
    },
    ljn_list_item_column2: {
      flex: 1,
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "flex-end",
      paddingRight: px2vw(32),
    },
    ljn_list_item_column2_text: {
      color: theme.textColor,
      fontSize: px2vw(14),
    },
    ljn_list_item_column3: {
      flex: 1,
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "flex-end",
    },
    ljn_list_item_icon: {
      width: px2vw(25),
      height: px2vw(25),
    },
    ljn_list_item_name: {
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      marginLeft: px2vw(6),
    },
    ljn_list_item_name1: {
      color: theme.textColor,
      fontSize: px2vw(14),
      fontWeight: "600",
    },
    ljn_list_item_name2: {
      color: theme.textColor,
      fontSize: px2vw(12),
      marginLeft: px2vw(3),
    },
    ljn_list_item_name3: {
      color: theme.textColor,
      fontSize: px2vw(10),
    },
    ljn_list_item_float_btn_up: {
      height: px2vw(30),
      width: px2vw(70),
      backgroundColor: "#11b394",
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      borderRadius: px2vw(4),
    },
    ljn_list_item_float_btn_down: {
      height: px2vw(30),
      width: px2vw(70),
      backgroundColor: "#dc291b",
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      borderRadius: px2vw(4),
    },
    ljn_list_item_float_btn_text: {
      color: "white",
    },
    // ---------------------------------- 列表end

    ljn_showmore: {
      flexBasis: px2vw(50),
      display: "flex",
      flexDirection: "row",
      justifyContent: "center",
      alignItems: "center",
    },
    ljn_showmore_text: {
      color: "#707589",
      fontSize: px2vw(12),
    },
  });
}
