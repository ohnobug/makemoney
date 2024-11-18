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
    ljn_emptyblock: {
      // backgroundColor: "red",
      width: utils_1.px2vw(220),
      marginLeft: "auto",
      marginRight: "auto",
      display: "flex",
      marginTop: utils_1.px2vw(50),
    },
    ljn_emptyblock_row1: {
      flexBasis: utils_1.px2vw(85),
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
    },
    ljn_emptyblock_row1_img: {
      width: utils_1.px2vw(80),
      height: utils_1.px2vw(80),
    },
    ljn_emptyblock_row2: {
      flexBasis: utils_1.px2vw(50),
    },
    ljn_emptyblock_row2_text: {
      textAlign: "center",
      color: theme.textColor,
    },
    ljn_emptyblock_row3: {
      flex: 1,
      width: utils_1.px2vw(160),
      marginLeft: "auto",
      marginRight: "auto",
    },
  });
}
exports.setTheme = setTheme;
