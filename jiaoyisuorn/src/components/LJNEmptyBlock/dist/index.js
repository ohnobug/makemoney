"use strict";
exports.__esModule = true;
var react_native_1 = require("react-native");
var react_1 = require("react");
var hooks_1 = require("../../hooks");
var SystemSlice_1 = require("../../store/SystemSlice");
var styles_1 = require("./styles");
var LJNButton_1 = require("../LJNButton");
var index = function (props) {
  var theme = hooks_1.useAppSelector(SystemSlice_1.selectAppTheme);
  var _a = react_1.useState(styles_1.setTheme(theme)),
    styles = _a[0],
    setStyles = _a[1];
  react_1.useEffect(function () {
    setStyles(styles_1.setTheme(theme));
  }, []);
  return react_1["default"].createElement(
    react_native_1.View,
    { style: styles.ljn_emptyblock },
    react_1["default"].createElement(
      react_native_1.View,
      { style: styles.ljn_emptyblock_row1 },
      react_1["default"].createElement(react_native_1.Image, {
        style: styles.ljn_emptyblock_row1_img,
        source: require("../../assets/images/recharge.png"),
      })
    ),
    react_1["default"].createElement(
      react_native_1.View,
      { style: styles.ljn_emptyblock_row2 },
      react_1["default"].createElement(
        react_native_1.Text,
        { style: styles.ljn_emptyblock_row2_text },
        "\u7ACB\u5373\u5145\u503C\uFF0C\u5F00\u542F\u60A8\u7684\u6570\u5B57\u8D27\u5E01\u4E4B\u65C5\u5FEB\u901F\u5165\u91D1\u53EF\u9886\u53D6\u9AD8\u989D\u5956\u52B1"
      )
    ),
    react_1["default"].createElement(LJNButton_1["default"], {
      size: "middle",
      style: styles.ljn_emptyblock_row3,
      title: "去入金",
      onPress: function () {},
    })
  );
};
exports["default"] = index;
var styles = react_native_1.StyleSheet.create({});
