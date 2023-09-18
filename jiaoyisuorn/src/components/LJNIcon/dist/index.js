"use strict";
exports.__esModule = true;
var react_1 = require("react");
var iconfont_1 = require("./iconfont");
var hooks_1 = require("../../hooks");
var SystemSlice_1 = require("../../store/SystemSlice");
var styles_1 = require("../../themes/default/styles");
var styles_2 = require("../../themes/light/styles");
var utils_1 = require("../../utils/utils");
var index = function (_a) {
  var title = _a.title,
    _b = _a.size,
    size = _b === void 0 ? 20 : _b,
    _c = _a.color,
    color = _c === void 0 ? "" : _c;
  var theme = hooks_1.useAppSelector(SystemSlice_1.selectAppTheme);
  var _d = react_1.useState(color),
    IconColor = _d[0],
    setIconColor = _d[1];
  size = utils_1.px2vw(size);
  react_1.useEffect(function () {
    if (color === "") {
      if (theme === "dark") {
        setIconColor(styles_1["default"].titleTextColor);
      } else {
        setIconColor(styles_2["default"].titleTextColor);
      }
    }
  }, []);
  return react_1["default"].createElement(iconfont_1["default"], {
    name: title,
    size: size,
    color: IconColor,
  });
};
exports["default"] = index;
