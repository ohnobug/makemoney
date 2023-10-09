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
    ljn_echartsbg: {
      backgroundColor: theme.areaBackgroundColor,
    },
    ljn_container: {
      height: px2vw(146),
      backgroundColor: theme.areaBackgroundColor,
      paddingTop: px2vw(5),
      paddingBottom: px2vw(12),
      borderBottomLeftRadius: px2vw(10),
      borderBottomRightRadius: px2vw(10),
      marginBottom: px2vw(10),
    },

    // 标题区域 --------------------start
    ljn_title_area: {
      height: px2vw(30),
      display: "flex",
      justifyContent: "space-between",
      flexDirection: "row",
      borderBottomWidth: px2vw(0.5),
      borderBottomColor: theme.borderColor,
      marginBottom: px2vw(8),
    },
    ljn_title_area_left: {
      flex: 3,
      display: "flex",
      flexDirection: "row",
      paddingLeft: px2vw(17),
    },
    ljn_title_area_left_title_before: {
      display: "flex",
      justifyContent: "center",
      marginRight: px2vw(6),
    },
    ljn_title_area_left_title_before_inner: {
      borderRadius: px2vw(3),
      color: "white",
      fontSize: px2vw(10),
      width: px2vw(30),
      height: px2vw(16),
      textAlign: "center",
      backgroundColor: "#0070e7",
    },
    ljn_title_area_left_title_after: {
      display: "flex",
      justifyContent: "center",
    },
    ljn_title_area_left_title_after_inner: {
      color: theme.titleTextColor,
      fontSize: px2vw(12),
    },
    ljn_title_area_right: {
      flex: 1,
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "flex-end",
      paddingRight: px2vw(17),
    },
    ljn_title_area_right_img: {
      width: px2vw(16),
      height: px2vw(16),
    },

    // --------------------------------------热门信息区域 start
    ljn_hotinfo_area: {
      display: "flex",
      flexDirection: "row",
      paddingLeft: px2vw(10),
      paddingRight: px2vw(10),
    },
    ljn_hotinfo: {
      flex: 1,
      paddingLeft: px2vw(3),
      paddingRight: px2vw(3),
    },
    ljn_currency_name_area: {
      // height: px2vw(14),
      fontSize: px2vw(12),
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      flexDirection: "row",
      marginBottom: px2vw(8),
    },
    ljn_currency_name: {
      color: theme.textColor,
      marginRight: px2vw(3),
      fontSize: px2vw(12),
    },
    ljn_currency_name_float: {
      color: "#dc6d63",
      fontSize: px2vw(10),
    },
    ljn_currency_price_area: {
      height: px2vw(18),
      marginBottom: px2vw(8),
    },
    ljn_currency_price_title: {
      fontSize: px2vw(14),
      fontWeight: "600",
      color: theme.textColor,
      textAlign: "center",
    },
    ljn_currency_kline_area: {
      // width: px2vw(150),
      height: px2vw(30),
      textAlign: "center",
    },
    ljn_currency_kline: {
      color: "#f77f68",
      fontSize: px2vw(14),
    },
    // --------------------------------------热门信息区域 end
  });
}
