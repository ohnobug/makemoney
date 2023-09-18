"use strict";
exports.__esModule = true;
var react_native_1 = require("react-native");
var react_1 = require("react");
var styles_1 = require("./styles");
var hooks_1 = require("../../hooks");
var SystemSlice_1 = require("../../store/SystemSlice");
var index = function (_a) {
  var title = _a.title;
  var theme = hooks_1.useAppSelector(SystemSlice_1.selectAppTheme);
  var _b = react_1.useState(styles_1.setTheme(theme)),
    styles = _b[0],
    setStyles = _b[1];
  react_1.useEffect(function () {
    setStyles(styles_1.setTheme(theme));
  }, []);
  return react_1["default"].createElement(
    react_native_1.View,
    { style: styles.ljn_line_title },
    react_1["default"].createElement(
      react_native_1.Text,
      { style: styles.ljn_title },
      title
    ),
    react_1["default"].createElement(react_native_1.View, {
      style: styles.ljn_line,
    })
  );
};
exports["default"] = index;
