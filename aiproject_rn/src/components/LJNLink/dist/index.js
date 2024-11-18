"use strict";
exports.__esModule = true;
var react_native_1 = require("react-native");
var react_1 = require("react");
var hooks_1 = require("hooks");
var styles_1 = require("./styles");
var SystemSlice_1 = require("store/SystemSlice");
var index = function (_a) {
  var title = _a.title,
    style = _a.style,
    onPress = _a.onPress;
  var theme = hooks_1.useAppSelector(SystemSlice_1.selectAppTheme);
  var _b = react_1.useState(styles_1.setTheme(theme)),
    styles = _b[0],
    setStyles = _b[1];
  react_1.useEffect(function () {
    setStyles(styles_1.setTheme(theme));
  }, []);
  return react_1["default"].createElement(
    react_native_1.TouchableOpacity,
    { activeOpacity: 0.6, onPress: onPress },
    react_1["default"].createElement(
      react_native_1.Text,
      { style: react_native_1.StyleSheet.flatten([styles.ljn_link, style]) },
      title
    )
  );
};
exports["default"] = index;
