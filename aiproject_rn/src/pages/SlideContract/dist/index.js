"use strict";
exports.__esModule = true;
var react_1 = require("react");
var react_native_1 = require("react-native");
var LJNTabbar_1 = require("../../components/LJNTabbar");
var utils_1 = require("utils/utils");
var AppStylesConfig_1 = require("../../AppStylesConfig");
// let timer: any;
function index(_a) {
  var _b = react_1.useState(true),
    scrollEnabled = _b[0],
    setScrollEnabled = _b[1];
  var mySetScrollEnabled = function (value) {
    if (scrollEnabled !== value) {
      setScrollEnabled(value);
    }
  };
  return react_1["default"].createElement(
    react_native_1.View,
    { style: styles.container },
    react_1["default"].createElement(
      react_native_1.ScrollView,
      {
        directionalLockEnabled: true,
        horizontal: false,
        style: styles.ljn_main,
        scrollEnabled: scrollEnabled,
      },
      react_1["default"].createElement(
        react_native_1.View,
        { style: styles.ljn_big_box },
        react_1["default"].createElement(
          react_native_1.Text,
          {
            style: {
              fontSize: utils_1.px2vw(50),
              color: "white",
            },
          },
          "\u5408\u7EA6"
        )
      )
    ),
    react_1["default"].createElement(
      react_native_1.View,
      { style: styles.ljn_footer },
      react_1["default"].createElement(LJNTabbar_1["default"], null)
    )
  );
}
exports["default"] = index;
var styles = react_native_1.StyleSheet.create({
  container: {
    // position: "absolute",
    // top: screen.height - window.height,
    flex: 1,
    display: "flex",
    flexDirection: "column",
  },
  ljn_main: {
    flex: 1,
    // maxHeight: window.height - AppStylesConfig.tabbarHeight,
    backgroundColor: "#0f131f",
  },
  ljn_big_box: {
    height: utils_1.px2vw(500),
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
  },
  ljn_footer: {
    flex: 0,
    minHeight: AppStylesConfig_1["default"].tabbarHeight,
  },
});
