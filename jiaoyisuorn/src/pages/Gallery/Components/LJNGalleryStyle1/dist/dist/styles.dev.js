"use strict";

exports.__esModule = true;
exports.setTheme = void 0;

var react_native_1 = require("react-native");

var utils_1 = require("../../../../utils/utils");

function setTheme(name) {
  return react_native_1.StyleSheet.create({
    ljn_gallery_list: {
      display: "flex",
      flexDirection: "row",
      justifyContent: "flex-start",
      flexWrap: "wrap",
      gap: utils_1.px2vw(1),
      marginBottom: utils_1.px2vw(1),
    },
    ljn_gallery_item: {
      height: utils_1.px2vw(123.665),
      flex: 1,
      // 减去左右两侧的线
      flexBasis: utils_1.px2vw(123.665),
    },
    ljn_gallery_item_image: {
      width: "100%",
      height: "100%",
    },
    ljn_footer: {
      flex: 0,
      minHeight: utils_1.px2vw(60),
    },
  });
}

exports.setTheme = setTheme;
