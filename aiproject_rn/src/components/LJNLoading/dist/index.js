"use strict";
exports.__esModule = true;
var react_native_1 = require("react-native");
var react_1 = require("react");
var styles_1 = require("./styles");
var hooks_1 = require("hooks");
var SystemSlice_1 = require("store/SystemSlice");
var utils_1 = require("utils/utils");
var dotlength = 0;
var index = function (_a) {
  var _b = _a.size,
    size = _b === void 0 ? 14 : _b;
  var theme = hooks_1.useAppSelector(SystemSlice_1.selectAppTheme);
  var _c = react_1.useState(styles_1.setTheme(theme)),
    styles = _c[0],
    setStyles = _c[1];
  var _d = react_1.useState("..."),
    dot = _d[0],
    setDot = _d[1];
  react_1.useEffect(function () {
    setStyles(styles_1.setTheme(theme));
    var timer = setInterval(function () {
      dotlength += 1;
      if (dotlength > 3) dotlength = 0;
      setDot(".".repeat(dotlength));
    }, 300);
    return function () {
      clearInterval(timer);
    };
  }, []);
  return react_1["default"].createElement(
    react_native_1.View,
    { style: styles.ljn_container },
    react_1["default"].createElement(
      react_native_1.Text,
      {
        style: react_native_1.StyleSheet.flatten([
          styles.ljn_container_text,
          { fontSize: utils_1.px2vw(size) },
        ]),
      },
      "\u52A0\u8F7D\u4E2D",
      dot
    )
  );
};
exports["default"] = index;
