"use strict";
exports.__esModule = true;
var react_native_1 = require("react-native");
var react_1 = require("react");
var utils_1 = require("utils/utils");
var index = function (_a, ref) {
  var _b = _a.children,
    children =
      _b === void 0
        ? react_1["default"].createElement(react_1["default"].Fragment, null)
        : _b,
    _c = _a.style,
    style = _c === void 0 ? {} : _c,
    _d = _a.horizontal,
    horizontal = _d === void 0 ? false : _d;
  return react_1["default"].createElement(
    react_native_1.ScrollView,
    {
      contentContainerStyle: {
        paddingBottom: utils_1.px2vw(20),
      },
      style: style,
      ref: ref,
      horizontal: horizontal,
      bounces: false,
      alwaysBounceHorizontal: false,
      alwaysBounceVertical: false,
      directionalLockEnabled: true,
      showsHorizontalScrollIndicator: false,
      showsVerticalScrollIndicator: false,
      scrollEnabled: true,
      overScrollMode: "never",
      disableIntervalMomentum: true,
      disableScrollViewPanResponder: true,
    },
    children
  );
};
exports["default"] = react_1["default"].forwardRef(index);
