"use strict";
exports.__esModule = true;
exports.setTheme = void 0;
var react_native_1 = require("react-native");
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
    ljn_footer: {
      minHeight: AppStylesConfig_1["default"].tabbarHeight,
    },
  });
}
exports.setTheme = setTheme;
