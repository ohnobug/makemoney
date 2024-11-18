"use strict";
exports.__esModule = true;
exports.setTheme = void 0;
var react_native_1 = require("react-native");
var utils_1 = require("utils/utils");
var styles_1 = require("themes/default/styles");
var styles_2 = require("themes/light/styles");
function setTheme(name) {
  var theme;
  if (name === "dark") {
    theme = styles_1["default"];
  } else {
    theme = styles_2["default"];
  }
  return react_native_1.StyleSheet.create({
    ljn_container: {
      height: utils_1.px2vw(488),
      backgroundColor: theme.areaBackgroundColor,
      marginBottom: utils_1.px2vw(10),
    },
    ljn_header: {
      height: utils_1.px2vw(50),
      display: "flex",
      flexDirection: "row",
      paddingTop: utils_1.px2vw(17),
      paddingLeft: utils_1.px2vw(17),
      paddingRight: utils_1.px2vw(17),
      paddingBottom: utils_1.px2vw(0),
      // backgroundColor: theme.areaBackgroundColor,
      // backgroundColor: "red",
      color: theme.textColor,
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
      marginRight: utils_1.px2vw(17),
    },
    ljn_header_left_1_text_active: {
      color: theme.textColor,
    },
    ljn_header_left_1_text: {
      fontSize: utils_1.px2vw(16),
      // fontWeight: "600",
      color: name === "dark" ? "#999" : "black",
    },
    ljn_header_right: {
      flex: 1,
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "flex-end",
    },
    // 买卖操作
    ljn_trade_operation: {
      height: utils_1.px2vw(438),
      display: "flex",
      flexDirection: "row",
      backgroundColor: theme.areaBackgroundColor,
    },
    ljn_trade_operation_left: {
      flexBasis: utils_1.px2vw(230),
      // backgroundColor: "red",
      paddingLeft: utils_1.px2vw(17),
      paddingRight: utils_1.px2vw(17),
    },
    ljn_trade_operation_left_title_area: {
      height: utils_1.px2vw(45),
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
    },
    ljn_trade_operation_left_title_area_icon: {
      marginRight: utils_1.px2vw(5),
    },
    ljn_trade_operation_left_title_area_text1: {
      fontSize: utils_1.px2vw(20),
      color: theme.textColor,
      marginRight: utils_1.px2vw(10),
    },
    ljn_trade_operation_left_title_area_text2: {
      fontSize: utils_1.px2vw(12),
      color: "red",
    },
    ljn_trade_operation_buysell_buttons: {
      display: "flex",
      flexDirection: "row",
      height: utils_1.px2vw(36),
      marginBottom: utils_1.px2vw(10),
    },
    ljn_trade_operation_buysell_buy: {
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      flex: 1,
      backgroundColor: "#12b298",
      borderTopLeftRadius: utils_1.px2vw(3),
      borderBottomLeftRadius: utils_1.px2vw(3),
    },
    ljn_trade_operation_buysell_buy_text: {
      color: theme.textColor,
      fontSize: utils_1.px2vw(14),
      fontWeight: "600",
    },
    ljn_trade_operation_buysell_sell: {
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      flex: 1,
      backgroundColor: theme.areaBackgroundColor,
      borderTopRightRadius: utils_1.px2vw(3),
      borderBottomRightRadius: utils_1.px2vw(3),
    },
    ljn_trade_operation_buysell_sell_text: {
      color: theme.textColor,
      fontSize: utils_1.px2vw(14),
      fontWeight: "600",
    },
    // 近似值
    ljn_trade_operation_about_value: {
      marginBottom: utils_1.px2vw(10),
    },
    ljn_trade_operation_about_value_text: {
      color: theme.titleTextColor,
      fontSize: utils_1.px2vw(12),
    },
    // 快速选择
    ljn_trade_operation_percentage_selector: {
      display: "flex",
      flexDirection: "row",
      justifyContent: "space-around",
      marginBottom: utils_1.px2vw(10),
    },
    ljn_trade_operation_percentage_selector_button: {
      paddingTop: utils_1.px2vw(3),
      paddingBottom: utils_1.px2vw(3),
      paddingLeft: utils_1.px2vw(10),
      paddingRight: utils_1.px2vw(10),
      backgroundColor: theme.backgroundColor,
      borderRadius: utils_1.px2vw(3),
    },
    ljn_trade_operation_percentage_selector_button_text: {
      color: theme.textColor,
      fontSize: utils_1.px2vw(12),
      transform: [{ scale: 0.9 }],
    },
    // 操作输入框
    ljn_trade_operation_input: {
      backgroundColor: theme.backgroundColor,
      height: utils_1.px2vw(42),
      borderRadius: utils_1.px2vw(5),
      paddingLeft: utils_1.px2vw(10),
      paddingRight: utils_1.px2vw(10),
      color: theme.textColor,
      fontSize: utils_1.px2vw(14),
      fontWeight: "600",
      marginBottom: utils_1.px2vw(10),
    },
    // 可用
    ljn_trade_balance_area: {
      display: "flex",
      flexDirection: "row",
      justifyContent: "space-between",
      height: utils_1.px2vw(28),
      alignItems: "center",
      marginBottom: utils_1.px2vw(10),
    },
    ljn_trade_balance_area_title: {
      color: theme.titleTextColor,
      borderBottomColor: theme.titleTextColor,
      borderBottomWidth: utils_1.px2vw(1),
      borderStyle: "dashed",
    },
    ljn_trade_balance_area_value: {
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "flex-end",
    },
    ljn_trade_balance_area_value_text1: {
      color: theme.textColor,
      marginRight: utils_1.px2vw(5),
    },
    ljn_trade_balance_area_value_text2: {
      color: theme.textColor,
      marginRight: utils_1.px2vw(5),
    },
    // 倍速与标题
    ljn_trade_operation_right: {
      flex: 1,
    },
    // 倍速
    ljn_trade_operation_right_title_area: {
      height: utils_1.px2vw(45),
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "space-around",
    },
    ljn_trade_operation_right_title_button: {
      width: utils_1.px2vw(57),
      height: utils_1.px2vw(25),
      display: "flex",
      alignItems: "center",
      justifyContent: "center",
      backgroundColor: theme.areaBackgroundColor,
      borderRadius: utils_1.px2vw(3),
    },
    ljn_trade_operation_right_title_button_text: {
      color: theme.textColor,
      fontSize: utils_1.px2vw(12),
    },
    // 标题
    ljn_trade_operation_right_float_title_area: {
      display: "flex",
      flexDirection: "row",
      justifyContent: "space-between",
      height: utils_1.px2vw(30),
      alignItems: "center",
    },
    ljn_trade_operation_right_float_title: {
      flex: 1,
      textAlign: "center",
    },
    ljn_trade_operation_right_float_title_text: {
      color: theme.titleTextColor,
    },
    // 浮动数据
    ljn_trade_operation_right_float_data_area: {
      display: "flex",
      flexDirection: "row",
      justifyContent: "space-between",
      height: utils_1.px2vw(25),
      alignItems: "center",
      position: "relative",
    },
    ljn_trade_operation_right_float_data_background: {
      height: utils_1.px2vw(25),
      position: "absolute",
      right: 0,
    },
    ljn_trade_operation_right_float_data: {
      flex: 1,
      textAlign: "left",
    },
    ljn_trade_operation_right_float_data_text1: {
      color: "#df5e52",
    },
    ljn_trade_operation_right_float_data_text2: {
      color: theme.titleTextColor,
      textAlign: "center",
    },
    // 当前价格
    ljn_trade_operation_current_price: {
      height: utils_1.px2vw(65),
      paddingTop: utils_1.px2vw(3),
    },
    ljn_trade_operation_current_price_text1: {
      fontSize: utils_1.px2vw(28),
      fontWeight: "600",
      color: "#df5e52",
    },
    ljn_trade_operation_current_price_text2: {
      color: theme.titleTextColor,
      fontSize: utils_1.px2vw(12),
    },
    // 调整精度
    ljn_trade_operation_accuracy: {
      display: "flex",
      height: utils_1.px2vw(30),
      flexDirection: "row",
      justifyContent: "space-between",
      marginTop: utils_1.px2vw(6),
    },
    ljn_trade_operation_accuracy_selector_area: {
      flexBasis: utils_1.px2vw(100),
      height: utils_1.px2vw(30),
    },
    ljn_trade_operation_accuracy_selector: {
      backgroundColor: theme.backgroundColor,
      height: utils_1.px2vw(30),
      borderRadius: utils_1.px2vw(5),
      paddingLeft: utils_1.px2vw(10),
      paddingRight: utils_1.px2vw(10),
      color: theme.textColor,
      fontSize: utils_1.px2vw(14),
      fontWeight: "600",
    },
    ljn_trade_operation_accuracy_icon: {
      flex: 1,
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
    },
    ljn_trade_operation_accuracy_icon_box: {
      width: utils_1.px2vw(30),
      height: utils_1.px2vw(30),
      backgroundColor: theme.areaBackgroundColor,
      borderRadius: utils_1.px2vw(3),
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
    },
  });
}
exports.setTheme = setTheme;
