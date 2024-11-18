"use strict";
exports.__esModule = true;
var react_1 = require("react");
var hooks_1 = require("hooks");
var SystemSlice_1 = require("store/SystemSlice");
var index = function (props) {
  var theme = hooks_1.useAppSelector(SystemSlice_1.selectAppTheme);
  var _a = react_1.useState(SystemSlice_1.setTheme(theme)),
    styles = _a[0],
    setStyles = _a[1];
  react_1.useEffect(
    function () {
      setStyles(SystemSlice_1.setTheme(theme));
    },
    [theme]
  );
  return react_1["default"].createElement(
    react_1["default"].Fragment,
    null,
    props.children
  );
};
exports["default"] = index;
