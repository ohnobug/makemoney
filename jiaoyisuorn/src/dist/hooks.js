"use strict";
exports.__esModule = true;
exports.useStyles = exports.useAppSelector = exports.useAppDispatch = void 0;
var react_redux_1 = require("react-redux");
var react_1 = require("react");
var SystemSlice_1 = require("./store/SystemSlice");
// Use throughout your app instead of plain `useDispatch` and `useSelector`
exports.useAppDispatch = react_redux_1.useDispatch;
exports.useAppSelector = react_redux_1.useSelector;
exports.useStyles = function (setTheme) {
  var theme = exports.useAppSelector(SystemSlice_1.selectAppTheme);
  var _a = react_1.useState(setTheme(theme)),
    styles = _a[0],
    setStyles = _a[1];
  react_1.useEffect(
    function () {
      setStyles(setTheme(theme));
    },
    [theme]
  );
  return styles;
};
