"use strict";
exports.__esModule = true;
var react_1 = require("react");
var react_native_1 = require("react-native");
var LJNScrollView_1 = require("../../components/LJNScrollView");
var LJNTabbar_1 = require("../../components/LJNTabbar");
var hooks_1 = require("../../hooks");
var LJNAssetsInfo_1 = require("./Components/LJNAssetsInfo");
var LJNTradeOperation_1 = require("./Components/LJNTradeOperation");
var styles_1 = require("./styles");
function index(_a) {
    var styles = hooks_1.useStyles(styles_1.setTheme);
    var bigScrollView = react_1.useRef(null);
    return (react_1["default"].createElement(react_native_1.View, { style: styles.container },
        react_1["default"].createElement(LJNScrollView_1["default"], { style: styles.ljn_main, horizontal: false, ref: bigScrollView, children: react_1["default"].createElement(react_1["default"].Fragment, null,
                react_1["default"].createElement(react_native_1.View, { style: styles.container },
                    react_1["default"].createElement(LJNTradeOperation_1["default"], null),
                    react_1["default"].createElement(LJNAssetsInfo_1["default"], null))) }),
        react_1["default"].createElement(react_native_1.View, { style: styles.ljn_footer },
            react_1["default"].createElement(LJNTabbar_1["default"], null))));
}
exports["default"] = index;
