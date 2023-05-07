"use strict";
exports.__esModule = true;
var react_native_1 = require("react-native");
var react_1 = require("react");
var hooks_1 = require("../../hooks");
var SystemSlice_1 = require("../../store/SystemSlice");
var styles_1 = require("./styles");
var LJNIcon_1 = require("../LJNIcon");
var index = function (props) {
    var theme = hooks_1.useAppSelector(SystemSlice_1.selectTheme);
    var _a = react_1.useState(styles_1.setTheme(theme)), styles = _a[0], setStyles = _a[1];
    react_1.useEffect(function () {
        setStyles(styles_1.setTheme(theme));
    }, []);
    return (react_1["default"].createElement(react_native_1.View, { style: styles.ljn_list }, props.list.map(function (item, index) {
        return (react_1["default"].createElement(react_native_1.View, { style: react_native_1.StyleSheet.flatten([
                styles.ljn_list_item,
                index === props.list.length - 1
                    ? styles.ljn_list_item_last
                    : null,
            ]), key: index },
            react_1["default"].createElement(react_native_1.TouchableOpacity, { style: styles.ljn_list_item_inner, activeOpacity: 0.6 },
                react_1["default"].createElement(react_native_1.View, { style: styles.ljn_list_item_title },
                    react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_list_item_title_text }, item.title)),
                react_1["default"].createElement(react_native_1.View, { style: styles.ljn_list_item_desc }, item.desc ? (react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_list_item_desc_text }, item.desc)) : null),
                react_1["default"].createElement(react_native_1.View, { style: styles.ljn_list_item_icon }, item.desc ? (react_1["default"].createElement(react_native_1.View, { style: styles.ljn_list_item_icon_img },
                    react_1["default"].createElement(LJNIcon_1["default"], { title: "jinrujiantouxiao", size: 14 }))) : null))));
    })));
};
exports["default"] = index;
