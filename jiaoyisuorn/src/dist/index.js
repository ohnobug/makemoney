"use strict";
exports.__esModule = true;
var react_1 = require("react");
var react_native_1 = require("react-native");
var bus_1 = require("../../bus");
var LJNScrollView_1 = require("../../components/LJNScrollView");
var LJNTabbar_1 = require("../../components/LJNTabbar");
var hooks_1 = require("hooks");
var LJNFunctions_1 = require("./Components/LJNFunctions");
var LJNHotInfo_1 = require("./Components/LJNHotInfo");
var LJNList_1 = require("./Components/LJNList");
var LJNNav_1 = require("./Components/LJNNav");
var LJNSwiper_1 = require("./Components/LJNSwiper");
var styles_1 = require("./styles");
function index(_a) {
  var bigScrollView = react_1.useRef(null);
  react_1.useEffect(
    function () {
      bus_1["default"].emit("getBigScrollView", bigScrollView.current);
    },
    [bigScrollView]
  );
  var styles = hooks_1.useStyles(styles_1.setTheme);
  return react_1["default"].createElement(
    react_native_1.View,
    { style: styles.container },
    react_1["default"].createElement(LJNScrollView_1["default"], {
      style: styles.ljn_main,
      horizontal: false,
      ref: bigScrollView,
      children: react_1["default"].createElement(
        react_1["default"].Fragment,
        null,
        react_1["default"].createElement(LJNSwiper_1["default"], null),
        react_1["default"].createElement(LJNHotInfo_1["default"], null),
        react_1["default"].createElement(LJNNav_1["default"], null),
        react_1["default"].createElement(LJNFunctions_1["default"], null),
        react_1["default"].createElement(LJNList_1["default"], null)
      ),
    }),
    react_1["default"].createElement(
      react_native_1.View,
      { style: styles.ljn_footer },
      react_1["default"].createElement(LJNTabbar_1["default"], null)
    )
  );
}
exports["default"] = index;
