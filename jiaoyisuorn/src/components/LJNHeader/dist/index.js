"use strict";
exports.__esModule = true;
var react_native_1 = require("react-native");
var react_1 = require("react");
var styles_1 = require("./styles");
var hooks_1 = require("../../hooks");
var SystemSlice_1 = require("../../store/SystemSlice");
var LJNIcon_1 = require("../LJNIcon");
var react_router_native_1 = require("react-router-native");
var index = function (props) {
    var navigate = react_router_native_1.useNavigate();
    var theme = hooks_1.useAppSelector(SystemSlice_1.selectTheme);
    var _a = react_1.useState(styles_1.setTheme(theme)), styles = _a[0], setStyles = _a[1];
    react_1.useEffect(function () {
        setStyles(styles_1.setTheme(theme));
    }, []);
    return (react_1["default"].createElement(react_native_1.View, { style: styles.ljn_header },
        react_1["default"].createElement(react_native_1.View, { style: styles.ljn_header_left },
            react_1["default"].createElement(react_native_1.View, { style: styles.ljn_header_left_icon, onTouchEnd: function () {
                    navigate(-1);
                } },
                react_1["default"].createElement(LJNIcon_1["default"], { title: "xitongfanhui", size: 20 }))),
        react_1["default"].createElement(react_native_1.View, { style: styles.ljn_header_middle },
            react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_header_middle_title }, props.title)),
        react_1["default"].createElement(react_native_1.View, { style: styles.ljn_header_right })));
};
exports["default"] = index;
