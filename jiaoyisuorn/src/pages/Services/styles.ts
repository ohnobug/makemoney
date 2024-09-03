import { StyleSheet, Dimensions } from "react-native";
import { px2vw } from "utils/utils";
import darkTheme from "themes/default/styles";
import lightTheme from "themes/light/styles";
import AppStylesConfig from "AppStylesConfig";

const window = Dimensions.get("window");
export function setTheme(name: string) {
  let theme: ITheme;
  if (name === "dark") {
    theme = darkTheme;
  } else {
    theme = lightTheme;
  }

  return StyleSheet.create({
    ljn_main: {
      flex: 1,
      backgroundColor: theme.backgroundColor,
      maxHeight: window.height,
    },
    ljn_assets_area: {
      height: px2vw(271),
      backgroundColor: theme.areaBackgroundColor,
      borderBottomLeftRadius: px2vw(10),
      borderBottomRightRadius: px2vw(10),
      padding: px2vw(17),
      marginBottom: px2vw(10),
    },
    ljn_header: {
      height: px2vw(30),
      display: "flex",
      flexDirection: "row",
      marginBottom: px2vw(8),
    },
    ljn_header_left: {
      flex: 1,
      display: "flex",
      flexDirection: "row",
      justifyContent: "flex-start",
    },
    ljn_header_left_1: {
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
    },
    ljn_header_left_1_text: {
      color: theme.textColor,
      fontSize: px2vw(16),
      fontWeight: "600",
    },
    ljn_header_left_2: {
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      marginLeft: px2vw(10),
    },
    ljn_header_left_2_text: {
      color: theme.textColor,
      fontSize: px2vw(12),
    },
    ljn_header_left_3: {
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      marginLeft: px2vw(10),
    },
    ljn_header_right: {
      flex: 1,
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "flex-end",
    },
    ljn_assets_info: {
      height: px2vw(130),
      backgroundColor: "#0173e5",
      padding: px2vw(17),
      borderRadius: px2vw(10),
      marginTop: px2vw(10),
    },
    ljn_assets_amount_area: {
      display: "flex",
      flexDirection: "row",
      marginBottom: px2vw(24),
    },
    ljn_assets_amount: {
      flex: 1,
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
    },
    ljn_assets_value_icon: {
      marginRight: px2vw(0),
    },
    ljn_assets_value_text: {
      color: "white",
      fontSize: px2vw(20),
      fontWeight: "600",
    },
    ljn_assets_chart: {
      flex: 1,
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "flex-end",
    },
    ljn_assets_chart_icon: {
      marginRight: px2vw(5),
    },
    ljn_assets_chart_text: {
      fontSize: px2vw(12),
      color: "white",
    },
    ljn_assets_benefit_area: {
      display: "flex",
      flexDirection: "row",
    },
    ljn_assets_benefit_info1: {
      flex: 1,
    },
    ljn_assets_benefit_info1_title: {
      fontSize: px2vw(14),
      color: "white",
      marginBottom: px2vw(3),
    },
    ljn_assets_benefit_info1_value: {
      fontSize: px2vw(14),
      color: "white",
    },
    ljn_assets_benefit_info2: {
      flex: 1,
    },
    ljn_assets_benefit_info2_title: {
      fontSize: px2vw(14),
      color: "white",
      marginBottom: px2vw(3),
    },
    ljn_assets_benefit_info2_value: {
      fontSize: px2vw(14),
      color: "white",
    },
    ljn_assets_benefit_info3: {
      display: "flex",
      flexDirection: "column",
    },
    ljn_assets_benefit_info3_title: {
      flexWrap: "nowrap",
      fontSize: px2vw(14),
      color: "white",
      marginBottom: px2vw(3),
      borderBottomColor: "white",
      borderBottomWidth: px2vw(2),
      borderStyle: "dotted",
    },
    ljn_assets_benefit_info3_value: {
      fontSize: px2vw(14),
      color: "white",
    },

    ljn_list_area: {
      display: "flex",
      flexDirection: "row",
      flexWrap: "nowrap",
    },
    ljn_list_item: {
      flex: 1,
      height: px2vw(65),
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      flexDirection: "column",
    },
    ljn_list_item_icon: {
      width: px2vw(30),
      height: px2vw(30),
      marginBottom: px2vw(2),
      // backgroundColor: "blue",
    },
    ljn_list_item_icon_img: {
      width: px2vw(30),
      height: px2vw(30),
    },
    ljn_list_item_title: {},
    ljn_list_item_title_inner: {
      color: theme.titleTextColor,
      textAlign: "center",
      fontSize: px2vw(11),
    },
    ljn_quick_recharge: {
      height: px2vw(500),
      backgroundColor: theme.areaBackgroundColor,
    },

    ljn_footer: {
      flex: 0,
      minHeight: AppStylesConfig.tabbarHeight,
    },
  });
}
