"use strict";
exports.__esModule = true;
exports.setTheme = void 0;
var react_native_1 = require("react-native");
var utils_1 = require("utils/utils");
var styles_1 = require("themes/default/styles");
var styles_2 = require("themes/light/styles");
var window = react_native_1.Dimensions.get("window");
function setTheme(name) {
  var theme;
  if (name === "dark") {
    theme = styles_1["default"];
  } else {
    theme = styles_2["default"];
  }
  return react_native_1.StyleSheet.create({
    ljn_container: {
      flex: 1,
      display: "flex",
      flexDirection: "column",
      backgroundColor: theme.backgroundColor,
    },
    ljn_main: {
      flex: 1,
      maxHeight: window.height - utils_1.px2vw(190),
    },
    ljn_logout_area: {
      flex: 0,
      flexBasis: utils_1.px2vw(150),
      padding: utils_1.px2vw(10),
      display: "flex",
      alignItems: "center",
      // backgroundColor: "red",
      flexDirection: "column",
    },
    ljn_switch_account: {
      marginBottom: utils_1.px2vw(31),
      color: theme.textColor,
    },
    ljn_logout: {
      color: theme.textColor,
      fontSize: utils_1.px2vw(14),
    },
  });
}
exports.setTheme = setTheme;
