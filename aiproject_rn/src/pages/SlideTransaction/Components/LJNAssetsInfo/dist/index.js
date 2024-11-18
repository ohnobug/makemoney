"use strict";
exports.__esModule = true;
var react_1 = require("react");
var react_native_1 = require("react-native");
var LJNEmptyBlock_1 = require("components/LJNEmptyBlock");
var LJNHeaderScroll_1 = require("components/LJNHeaderScroll");
var LJNLoading_1 = require("components/LJNLoading");
var hooks_1 = require("hooks");
var styles_1 = require("./styles");
var index = function (props) {
  var styles = hooks_1.useStyles(styles_1.setTheme);
  // 顶部滑动
  var myswiperHeader = react_1.useRef(null);
  var _a = react_1.useState(true),
    show = _a[0],
    setShow = _a[1];
  react_1.useEffect(function () {
    var timer = setTimeout(function () {
      setShow(true);
    }, 100);
    return function () {
      clearTimeout(timer);
    };
  }, []);
  return react_1["default"].createElement(
    react_native_1.View,
    { style: styles.ljn_container },
    show
      ? react_1["default"].createElement(
          react_native_1.View,
          { style: styles.ljn_assets_history_info },
          react_1["default"].createElement(LJNHeaderScroll_1["default"], {
            ref: myswiperHeader,
            list: ["资产", "当前委托", "历史成交"],
            onChange: function (n) {},
          }),
          react_1["default"].createElement(
            react_native_1.View,
            null,
            react_1["default"].createElement(LJNEmptyBlock_1["default"], null)
          )
        )
      : react_1["default"].createElement(LJNLoading_1["default"], null)
  );
};
exports["default"] = index;
