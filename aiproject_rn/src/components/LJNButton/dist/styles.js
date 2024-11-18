"use strict";
exports.__esModule = true;
exports.setTheme = void 0;
var react_native_1 = require("react-native");
var styles_1 = require("themes/default/styles");
var styles_2 = require("themes/light/styles");
var utils_1 = require("utils/utils");
function setTheme(name) {
  var theme;
  if (name === "dark") {
    theme = styles_1["default"];
  } else {
    theme = styles_2["default"];
  }
  return react_native_1.StyleSheet.create({
    // 小
    ljn_small_button: {
      flex: 0,
      paddingLeft: utils_1.px2vw(20),
      paddingRight: utils_1.px2vw(20),
      minHeight: utils_1.px2vw(30),
      backgroundColor: theme.primaryColor,
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      borderRadius: utils_1.px2vw(5),
    },
    ljn_small_button_text: {
      color: "white",
      fontSize: utils_1.px2vw(12),
    },
    // 中
    ljn_middle_button: {
      flex: 0,
      paddingLeft: utils_1.px2vw(25),
      paddingRight: utils_1.px2vw(25),
      minHeight: utils_1.px2vw(40),
      backgroundColor: theme.primaryColor,
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      borderRadius: utils_1.px2vw(5),
    },
    ljn_middle_button_text: {
      color: "white",
      fontSize: utils_1.px2vw(14),
    },
    // 常规
    ljn_normal_button: {
      flex: 0,
      paddingLeft: utils_1.px2vw(25),
      paddingRight: utils_1.px2vw(25),
      minHeight: utils_1.px2vw(47),
      backgroundColor: theme.primaryColor,
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      borderRadius: utils_1.px2vw(5),
    },
    ljn_normal_button_text: {
      color: "white",
      fontSize: utils_1.px2vw(16),
    },
    // 大
    ljn_big_button: {
      flex: 0,
      paddingLeft: utils_1.px2vw(25),
      paddingRight: utils_1.px2vw(25),
      minHeight: utils_1.px2vw(52),
      backgroundColor: theme.primaryColor,
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      borderRadius: utils_1.px2vw(5),
    },
    ljn_big_button_text: {
      color: "white",
      fontSize: utils_1.px2vw(18),
    },
  });
}
exports.setTheme = setTheme;
