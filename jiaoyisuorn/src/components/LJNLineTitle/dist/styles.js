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
    ljn_line_title: {
      width: "100%",
      // backgroundColor: "yellow",
      display: "flex",
      alignItems: "center",
      justifyContent: "center",
      position: "relative",
    },
    ljn_title: {
      color: theme.titleTextColor,
      zIndex: 1,
      backgroundColor: theme.backgroundColor,
      paddingLeft: utils_1.px2vw(30),
      paddingRight: utils_1.px2vw(30),
    },
    ljn_line: {
      height: utils_1.px2vw(1),
      backgroundColor: theme.borderColor,
      position: "absolute",
      top: utils_1.px2vw(10),
      width: "100%",
      zIndex: 0,
    },
  });
}
exports.setTheme = setTheme;
