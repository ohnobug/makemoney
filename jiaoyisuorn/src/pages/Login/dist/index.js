"use strict";
exports.__esModule = true;
var react_1 = require("react");
var react_native_1 = require("react-native");
var LJNButton_1 = require("../../components/LJNButton");
var LJNHeader_1 = require("../../components/LJNHeader");
var LJNHeaderScroll_1 = require("../../components/LJNHeaderScroll");
var LJNLineTitle_1 = require("../../components/LJNLineTitle");
var LJNLink_1 = require("../../components/LJNLink");
var hooks_1 = require("../../hooks");
var styles_1 = require("./styles");
var index = function (props) {
    var styles = hooks_1.useStyles(styles_1.setTheme);
    // 顶部滑动
    var myswiperHeader = react_1.useRef(null);
    // 输入框
    var _a = react_1.useState(""), text = _a[0], setText = _a[1];
    return (react_1["default"].createElement(react_native_1.View, { style: styles.ljn_container },
        react_1["default"].createElement(LJNHeader_1["default"], { title: "" }),
        react_1["default"].createElement(react_native_1.View, { style: styles.ljn_main },
            react_1["default"].createElement(react_native_1.View, { style: styles.ljn_login_title },
                react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_login_title_text }, "\u6CE8\u518C/\u767B\u5F55\u60A8\u7684\u8D26\u53F7")),
            react_1["default"].createElement(react_native_1.View, { style: styles.ljn_login_form_area },
                react_1["default"].createElement(LJNHeaderScroll_1["default"], { ref: myswiperHeader, list: ["邮箱", "手机号"], onChange: function (n) { } }),
                react_1["default"].createElement(react_native_1.View, { style: styles.ljn_login_form },
                    react_1["default"].createElement(react_native_1.View, { style: styles.ljn_login_form_row1 },
                        react_1["default"].createElement(react_native_1.TextInput, { editable: true, multiline: false, maxLength: 40, onChangeText: function (val) {
                                setText(val);
                            }, value: text, style: react_native_1.StyleSheet.flatten([
                                styles.ljn_login_form_row1_input,
                                react_native_1.Platform.OS === "web"
                                    ? {
                                        outline: "none"
                                    }
                                    : null,
                            ]) })),
                    react_1["default"].createElement(react_native_1.View, { style: styles.ljn_login_form_row2 },
                        react_1["default"].createElement(LJNButton_1["default"], { size: "normal", title: "获取验证码", style: { width: "100%" }, onPress: function () { } })),
                    react_1["default"].createElement(react_native_1.View, { style: styles.ljn_login_form_row3 },
                        react_1["default"].createElement(LJNLink_1["default"], { title: "\u5BC6\u7801\u767B\u5F55", style: styles.ljn_login_form_row3_text })))),
            react_1["default"].createElement(LJNLineTitle_1["default"], { title: "其他方式" }),
            react_1["default"].createElement(react_native_1.View, { style: styles.ljn_other_login_style },
                react_1["default"].createElement(react_native_1.TouchableOpacity, { activeOpacity: 0.6, style: styles.ljn_other_login_style_item },
                    react_1["default"].createElement(react_native_1.View, { style: styles.ljn_other_login_logo },
                        react_1["default"].createElement(react_native_1.Image, { style: styles.ljn_other_login_logo_img, source: require("../../assets/images/facebook_logo.png") })),
                    react_1["default"].createElement(react_native_1.View, { style: styles.ljn_other_login_title },
                        react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_other_login_title_text }, "Facebook"))),
                react_1["default"].createElement(react_native_1.TouchableOpacity, { activeOpacity: 0.6, style: styles.ljn_other_login_style_item },
                    react_1["default"].createElement(react_native_1.View, { style: styles.ljn_other_login_logo },
                        react_1["default"].createElement(react_native_1.Image, { style: styles.ljn_other_login_logo_img, source: require("../../assets/images/google_logo.png") })),
                    react_1["default"].createElement(react_native_1.View, { style: styles.ljn_other_login_title },
                        react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_other_login_title_text }, "Google"))),
                react_1["default"].createElement(react_native_1.TouchableOpacity, { activeOpacity: 0.6, style: styles.ljn_other_login_style_item },
                    react_1["default"].createElement(react_native_1.View, { style: styles.ljn_other_login_logo },
                        react_1["default"].createElement(react_native_1.Image, { style: styles.ljn_other_login_logo_img, source: require("../../assets/images/twitter_logo.png") })),
                    react_1["default"].createElement(react_native_1.View, { style: styles.ljn_other_login_title },
                        react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_other_login_title_text }, "Twitter")))),
            react_1["default"].createElement(react_native_1.View, { style: styles.ljn_tips_text },
                react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_user_tips_text }, "\u7EE7\u7EED\u6CE8\u518C\u5373\u4EE3\u8868\u540C\u610F"),
                react_1["default"].createElement(LJNLink_1["default"], { title: "\u300A\u7528\u6237\u534F\u8BAE\u300B", style: styles.ljn_user_agreement }),
                react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_user_tips_text }, "\u548C"),
                react_1["default"].createElement(LJNLink_1["default"], { title: "\u300A\u9690\u79C1\u534F\u8BAE\u300B" })))));
};
exports["default"] = index;
