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
    ljn_tabs: {
      flex: 0,
      flexBasis: utils_1.px2vw(43),
      maxHeight: utils_1.px2vw(43),
      // width: px2vw(375),
      borderBottomWidth: utils_1.px2vw(1),
      borderBottomColor: theme.borderColor,
    },
    ljn_tab: {
      paddingLeft: utils_1.px2vw(10),
      paddingRight: utils_1.px2vw(10),
      height: utils_1.px2vw(40),
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
    },
    ljn_fly_bottom: {
      height: utils_1.px2vw(3),
      backgroundColor: "#32a1fc",
      position: "absolute",
      bottom: 0,
      left: 0,
    },
    ljn_tab_text: {
      color: theme.titleTextColor,
      fontSize: utils_1.px2vw(14),
      fontWeight: "600",
    },
    ljn_tab_text_active: {
      color: "#32a1fc",
    },
  });
}
exports.setTheme = setTheme;
