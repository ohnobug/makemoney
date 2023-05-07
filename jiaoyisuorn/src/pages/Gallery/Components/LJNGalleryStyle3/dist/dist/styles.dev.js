"use strict";

exports.__esModule = true;
exports.setTheme = void 0;

var react_native_1 = require("react-native");

var utils_1 = require("../../../../utils/utils");

function setTheme(name) {
  return react_native_1.StyleSheet.create({
    ljn_gallery_list: {
      display: "flex",
      flexDirection: "row-reverse",
      gap: utils_1.px2vw(1),
      marginBottom: utils_1.px2vw(1)
    },
    ljn_gallery_list_left: {
      flexBasis: utils_1.px2vw(123.665),
      height: utils_1.px2vw(249.66)
    },
    ljn_gallery_list_left_image: {
      width: "100%",
      height: "100%"
    },
    ljn_gallery_list_right: {
      flex: 1,
      display: "flex",
      flexWrap: "wrap",
      flexDirection: "row",
      justifyContent: "flex-start",
      gap: utils_1.px2vw(1)
    },
    ljn_gallery_item: {
      height: utils_1.px2vw(123.665),
      flexBasis: utils_1.px2vw(123.665)
    },
    ljn_gallery_item_image: {
      width: "100%",
      height: "100%"
    },
    ljn_footer: {
      flex: 0,
      minHeight: utils_1.px2vw(60)
    }
  });
}

exports.setTheme = setTheme;