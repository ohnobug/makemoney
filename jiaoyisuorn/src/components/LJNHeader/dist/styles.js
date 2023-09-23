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
    ljn_header: {
      flexBasis: utils_1.px2vw(40),
      flex: 0,
      height: utils_1.px2vw(40),
      // backgroundColor: "red",
      display: "flex",
      flexDirection: "row",
    },
    ljn_header_left: {
      flex: 1,
      display: "flex",
      justifyContent: "center",
      alignItems: "flex-start",
    },
    ljn_header_left_icon: {
      paddingLeft: utils_1.px2vw(17),
      paddingRight: utils_1.px2vw(17),
      height: utils_1.px2vw(40),
      display: "flex",
      justifyContent: "center",
    },
    ljn_header_middle: {
      flex: 1,
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
    },
    ljn_header_middle_title: {
      fontSize: utils_1.px2vw(18),
      color: theme.titleTextColor,
      fontWeight: "600",
    },
    ljn_header_right: {
      flex: 1,
      display: "flex",
      justifyContent: "center",
      alignItems: "flex-end",
    },
  });
}
exports.setTheme = setTheme;
