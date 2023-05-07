"use strict";
exports.__esModule = true;
var react_native_1 = require("react-native");
var react_1 = require("react");
var LJNHeader_1 = require("../../components/LJNHeader");
var LJNList_1 = require("../../components/LJNList");
var styles_1 = require("./styles");
var hooks_1 = require("../../hooks");
var LJNScrollView_1 = require("../../components/LJNScrollView");
var LJNButton_1 = require("../../components/LJNButton");
var LJNLink_1 = require("../../components/LJNLink");
var react_router_native_1 = require("react-router-native");
var listData1 = [
    { title: "安全设置", desc: "", url: "" },
    { title: "交易设置", desc: "", url: "" },
];
var listData2 = [
    { title: "通知管理", desc: "", url: "" },
    { title: "语言", desc: "简体中文", url: "" },
    { title: "计价方式", desc: "CNY", url: "" },
    { title: "涨跌颜色", desc: "绿涨红跌", url: "" },
    { title: "颜色模式", desc: "深色模式", url: "" },
    { title: "网络检测", desc: " ", url: "" },
    { title: "清空缓存", desc: " ", url: "" },
    { title: "关于我们", desc: "版本号 9.5.0", url: "" },
];
var index = function (props) {
    var navigate = react_router_native_1.useNavigate();
    var styles = hooks_1.useStyles(styles_1.setTheme);
    return (react_1["default"].createElement(react_native_1.View, { style: styles.ljn_container },
        react_1["default"].createElement(LJNHeader_1["default"], { title: "设置" }),
        react_1["default"].createElement(LJNScrollView_1["default"], { style: styles.ljn_main, horizontal: false, children: react_1["default"].createElement(react_1["default"].Fragment, null,
                react_1["default"].createElement(LJNList_1["default"], { list: listData1 }),
                react_1["default"].createElement(LJNList_1["default"], { list: listData2 })) }),
        react_1["default"].createElement(react_native_1.View, { style: styles.ljn_logout_area },
            react_1["default"].createElement(LJNButton_1["default"], { style: styles.ljn_switch_account, onPress: function () { }, title: "\u5207\u6362\u8D26\u53F7\u767B\u5F55" }),
            react_1["default"].createElement(LJNLink_1["default"], { title: "\u9000\u51FA", style: styles.ljn_logout, onPress: function () {
                    navigate("/login");
                } }))));
};
exports["default"] = index;
