"use strict";
exports.__esModule = true;
exports.setTheme = void 0;
var react_native_1 = require("react-native");
var utils_1 = require("utils/utils");
var styles_1 = require("themes/default/styles");
var styles_2 = require("themes/light/styles");
var AppStylesConfig_1 = require("../../AppStylesConfig");
var window = react_native_1.Dimensions.get("window");
function setTheme(name) {
  var theme;
  if (name === "dark") {
    theme = styles_1["default"];
  } else {
    theme = styles_2["default"];
  }
  return react_native_1.StyleSheet.create({
    container: {
      flex: 1,
      display: "flex",
      flexDirection: "column",
      backgroundColor: theme.backgroundColor,
    },
    ljn_main: {
      flex: 1,
      maxHeight: window.height - AppStylesConfig_1["default"].tabbarHeight,
    },
    ljn_assets_area: {
      height: utils_1.px2vw(271),
      backgroundColor: theme.areaBackgroundColor,
      borderBottomLeftRadius: utils_1.px2vw(10),
      borderBottomrightRadius: utils_1.px2vw(10),
      padding: utils_1.px2vw(17),
      marginBottom: utils_1.px2vw(10),
    },
    ljn_header: {
      height: utils_1.px2vw(30),
      display: "flex",
      flexDirection: "row",
      marginBottom: utils_1.px2vw(8),
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
      fontSize: utils_1.px2vw(16),
      fontWeight: "600",
    },
    ljn_header_left_2: {
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      marginLeft: utils_1.px2vw(10),
    },
    ljn_header_left_2_text: {
      color: theme.textColor,
      fontSize: utils_1.px2vw(12),
    },
    ljn_header_left_3: {
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      marginLeft: utils_1.px2vw(10),
    },
    ljn_header_right: {
      flex: 1,
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "flex-end",
    },
    ljn_assets_info: {
      height: utils_1.px2vw(130),
      backgroundColor: "#0173e5",
      padding: utils_1.px2vw(17),
      borderRadius: utils_1.px2vw(10),
      marginTop: utils_1.px2vw(10),
    },
    ljn_assets_amount_area: {
      display: "flex",
      flexDirection: "row",
      marginBottom: utils_1.px2vw(24),
    },
    ljn_assets_amount: {
      flex: 1,
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
    },
    ljn_assets_value_icon: {
      marginRight: utils_1.px2vw(0),
    },
    ljn_assets_value_text: {
      color: "white",
      fontSize: utils_1.px2vw(20),
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
      marginRight: utils_1.px2vw(5),
    },
    ljn_assets_chart_text: {
      fontSize: utils_1.px2vw(12),
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
      fontSize: utils_1.px2vw(14),
      color: "white",
      marginBottom: utils_1.px2vw(3),
    },
    ljn_assets_benefit_info1_value: {
      fontSize: utils_1.px2vw(14),
      color: "white",
    },
    ljn_assets_benefit_info2: {
      flex: 1,
    },
    ljn_assets_benefit_info2_title: {
      fontSize: utils_1.px2vw(14),
      color: "white",
      marginBottom: utils_1.px2vw(3),
    },
    ljn_assets_benefit_info2_value: {
      fontSize: utils_1.px2vw(14),
      color: "white",
    },
    ljn_assets_benefit_info3: {
      display: "flex",
      flexDirection: "column",
    },
    ljn_assets_benefit_info3_title: {
      flexWrap: "nowrap",
      fontSize: utils_1.px2vw(14),
      color: "white",
      marginBottom: utils_1.px2vw(3),
      borderBottomColor: "white",
      borderBottomWidth: utils_1.px2vw(2),
      borderStyle: "dotted",
    },
    ljn_assets_benefit_info3_value: {
      fontSize: utils_1.px2vw(14),
      color: "white",
    },
    ljn_list_area: {
      display: "flex",
      flexDirection: "row",
      flexWrap: "nowrap",
    },
    ljn_list_item: {
      flex: 1,
      height: utils_1.px2vw(65),
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      flexDirection: "column",
    },
    ljn_list_item_icon: {
      width: utils_1.px2vw(30),
      height: utils_1.px2vw(30),
      marginBottom: utils_1.px2vw(2),
    },
    ljn_list_item_icon_img: {
      width: utils_1.px2vw(30),
      height: utils_1.px2vw(30),
    },
    ljn_list_item_title: {},
    ljn_list_item_title_inner: {
      color: theme.titleTextColor,
      textAlign: "center",
      fontSize: utils_1.px2vw(11),
    },
    ljn_quick_recharge: {
      height: utils_1.px2vw(500),
      backgroundColor: theme.areaBackgroundColor,
    },
    ljn_footer: {
      flex: 0,
      minHeight: AppStylesConfig_1["default"].tabbarHeight,
    },
  });
}
exports.setTheme = setTheme;
