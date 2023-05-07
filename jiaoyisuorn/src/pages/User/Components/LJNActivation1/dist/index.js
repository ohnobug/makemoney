"use strict";
exports.__esModule = true;
var react_1 = require("react");
var react_native_1 = require("react-native");
var react_router_native_1 = require("react-router-native");
var LJNButton_1 = require("../../../../components/LJNButton");
var LJNIcon_1 = require("../../../../components/LJNIcon");
var LJNLoading_1 = require("../../../../components/LJNLoading");
var hooks_1 = require("../../../../hooks");
var styles_1 = require("./styles");
var index = function (props) {
    var navigate = react_router_native_1.useNavigate();
    var styles = hooks_1.useStyles(styles_1.setTheme);
    var _a = react_1.useState(false), show = _a[0], setShow = _a[1];
    react_1.useEffect(function () {
        var timer = setTimeout(function () {
            setShow(true);
        }, 100);
        return function () {
            clearTimeout(timer);
        };
    }, []);
    return (react_1["default"].createElement(react_native_1.View, { style: styles.ljn_activation_box }, show ? (react_1["default"].createElement(react_1["default"].Fragment, null,
        react_1["default"].createElement(react_native_1.View, { style: styles.ljn_activation_header },
            react_1["default"].createElement(react_native_1.View, { style: styles.ljn_activation_header_left },
                react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_activation_header_left_title }, "\u65B0\u624B\u4EFB\u52A1")),
            react_1["default"].createElement(react_native_1.View, { style: styles.ljn_activation_header_right },
                react_1["default"].createElement(LJNIcon_1["default"], { title: "jinrujiantouxiao", size: 14 }))),
        react_1["default"].createElement(react_native_1.View, { style: styles.ljn_activation_main },
            react_1["default"].createElement(react_native_1.View, { style: styles.ljn_activation_row1 },
                react_1["default"].createElement(react_native_1.Image, { style: styles.ljn_activation_row1_img, source: require("../../../../assets/images/nftimg.png") })),
            react_1["default"].createElement(react_native_1.View, { style: styles.ljn_activation_row2 },
                react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_activation_row2_text }, "\u6CE8\u518C\u767B\u5F55\u5373\u53EF\u83B7\u5F97")),
            react_1["default"].createElement(react_native_1.View, { style: styles.ljn_activation_row3 },
                react_1["default"].createElement(LJNButton_1["default"], { size: "small", title: "去完成", onPress: function () {
                        navigate("/login");
                    } }))))) : (react_1["default"].createElement(LJNLoading_1["default"], null))));
};
exports["default"] = index;
var styles = react_native_1.StyleSheet.create({});
