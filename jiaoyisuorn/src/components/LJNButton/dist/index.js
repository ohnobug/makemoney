"use strict";
exports.__esModule = true;
var react_native_1 = require("react-native");
var react_1 = require("react");
var hooks_1 = require("hooks");
var SystemSlice_1 = require("store/SystemSlice");
var styles_1 = require("./styles");
var index = function (_a) {
  var title = _a.title,
    _b = _a.size,
    size = _b === void 0 ? "normal" : _b,
    onPress = _a.onPress,
    style = _a.style;
  var theme = hooks_1.useAppSelector(SystemSlice_1.selectAppTheme);
  var _c = react_1.useState(styles_1.setTheme(theme)),
    styles = _c[0],
    setStyles = _c[1];
  react_1.useEffect(function () {
    setStyles(styles_1.setTheme(theme));
  }, []);
  return react_1["default"].createElement(
    react_native_1.TouchableOpacity,
    {
      activeOpacity: 0.6,
      style: react_native_1.StyleSheet.flatten([
        styles["ljn_" + size + "_button"],
        style,
      ]),
      onPress: onPress,
    },
    react_1["default"].createElement(
      react_native_1.Text,
      { style: styles["ljn_" + size + "_button_text"] },
      title
    )
  );
};
exports["default"] = index;
