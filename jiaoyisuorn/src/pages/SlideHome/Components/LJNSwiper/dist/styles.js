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
    container: {
      width: utils_1.px2vw(375),
      height: utils_1.px2vw(160),
      backgroundColor: theme.areaBackgroundColor,
    },
    ljn_slide: {
      flex: 1,
      justifyContent: "center",
      alignItems: "center",
    },
    ljn_slide_image: {
      width: "100%",
      height: "100%",
    },
  });
}
exports.setTheme = setTheme;
