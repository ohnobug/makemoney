"use strict";
exports.__esModule = true;
var react_1 = require("react");
var react_native_1 = require("react-native");
var LJNTabbar_1 = require("../../components/LJNTabbar");
var utils_1 = require("../../utils/utils");
var hooks_1 = require("../../hooks");
var SystemSlice_1 = require("../../store/SystemSlice");
var AppStylesConfig_1 = require("../../AppStylesConfig");
// let timer: any;
function index(_a) {
  var dispatch = hooks_1.useAppDispatch();
  var theme = hooks_1.useAppSelector(SystemSlice_1.selectAppTheme);
  return react_1["default"].createElement(
    react_native_1.View,
    { style: styles.container },
    react_1["default"].createElement(
      react_native_1.View,
      {
        style: {
          flex: 1,
          backgroundColor: "#333333",
          display: "flex",
          justifyContent: "center",
          alignItems: "center",
        },
      },
      react_1["default"].createElement(
        react_native_1.Text,
        { style: { fontSize: utils_1.px2vw(50), color: "red" } },
        "\u5F53\u524D\u4E3B\u9898",
        theme
      )
    ),
    react_1["default"].createElement(
      react_native_1.View,
      { style: styles.ljn_main },
      react_1["default"].createElement(
        react_native_1.View,
        {
          style: {
            flex: 1,
            backgroundColor: "black",
            display: "flex",
            justifyContent: "center",
            alignItems: "center",
          },
          onTouchStart: function () {
            dispatch(SystemSlice_1.setTheme("dark"));
          },
        },
        react_1["default"].createElement(
          react_native_1.Text,
          { style: { fontSize: utils_1.px2vw(30), color: "red" } },
          "\u9ED1\u8272\u4E3B\u9898"
        )
      ),
      react_1["default"].createElement(
        react_native_1.View,
        {
          style: {
            flex: 1,
            backgroundColor: "white",
            display: "flex",
            justifyContent: "center",
            alignItems: "center",
          },
          onTouchStart: function () {
            dispatch(SystemSlice_1.setTheme("light"));
          },
        },
        react_1["default"].createElement(
          react_native_1.Text,
          { style: { fontSize: utils_1.px2vw(30), color: "red" } },
          "\u767D\u8272\u4E3B\u9898"
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
    flex: 3,
    backgroundColor: "#0f131f",
    display: "flex",
    flexDirection: "row",
  },
  ljn_footer: {
    flex: 0,
    minHeight: AppStylesConfig_1["default"].tabbarHeight,
  },
});
