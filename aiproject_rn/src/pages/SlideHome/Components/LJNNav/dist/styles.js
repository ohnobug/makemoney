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
    ljn_list_area: {
      height: utils_1.px2vw(170),
      backgroundColor: theme.areaBackgroundColor,
      paddingTop: utils_1.px2vw(12),
      paddingBottom: utils_1.px2vw(8),
      paddingLeft: utils_1.px2vw(0),
      paddingRight: utils_1.px2vw(0),
      borderRadius: utils_1.px2vw(10),
      marginBottom: utils_1.px2vw(10),
      display: "flex",
      flexDirection: "row",
      flexWrap: "wrap",
    },
    ljn_list_item: {
      flexGrow: 1,
      flexBasis: utils_1.px2vw(68.2),
      height: utils_1.px2vw(65),
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      flexDirection: "column",
      marginBottom: utils_1.px2vw(10),
    },
    ljn_list_item_icon: {
      width: utils_1.px2vw(35),
      height: utils_1.px2vw(35),
      marginBottom: utils_1.px2vw(8),
    },
    ljn_list_item_icon_img: {
      width: utils_1.px2vw(35),
      height: utils_1.px2vw(35),
    },
    ljn_list_item_title: {},
    ljn_list_item_title_inner: {
      color: theme.titleTextColor,
      textAlign: "center",
      fontSize: utils_1.px2vw(11),
    },
  });
}
exports.setTheme = setTheme;
