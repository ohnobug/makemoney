"use strict";
exports.__esModule = true;
var react_1 = require("react");
var react_native_1 = require("react-native");
var LJNButton_1 = require("../../../../components/LJNButton");
var LJNIcon_1 = require("../../../../components/LJNIcon");
var LJNLoading_1 = require("../../../../components/LJNLoading");
var hooks_1 = require("../../../../hooks");
var styles_1 = require("./styles");
var SystemSlice_1 = require("../../../../store/SystemSlice");
/* 买卖操作 */
var index = function (props) {
    var theme = hooks_1.useAppSelector(SystemSlice_1.selectTheme);
    var styles = hooks_1.useStyles(styles_1.setTheme);
    // 上一次的价格
    var prevPrice = react_1.useRef(0).current;
    // 是否上涨
    var _a = react_1.useState(false), isUp = _a[0], setIsUp = _a[1];
    // 输入框
    var _b = react_1.useState(""), text = _b[0], setText = _b[1];
    var _c = react_1.useState([
        { price: 22886.49, amount: 0.0406, percentage: "30%" },
        { price: 22886.49, amount: 0.0406, percentage: "30%" },
        { price: 22886.49, amount: 0.0406, percentage: "30%" },
        { price: 22886.49, amount: 0.0406, percentage: "30%" },
        { price: 22886.49, amount: 0.0406, percentage: "30%" },
        { price: 22886.49, amount: 0.0406, percentage: "30%" },
        { price: 22886.49, amount: 0.0406, percentage: "30%" },
        { price: 22886.49, amount: 0.0406, percentage: "30%" },
        { price: 22886.49, amount: 0.0406, percentage: "30%" },
        { price: 22886.49, amount: 0.0406, percentage: "30%" },
    ]), list1 = _c[0], setList1 = _c[1];
    react_1.useEffect(function () {
        var timer = setInterval(function () {
            setList1(function (l) {
                var nl = l.map(function (item) {
                    return {
                        price: (Math.round(Math.random() * 10000 * 100) / 100).toFixed(2),
                        amount: Math.random().toFixed(4),
                        percentage: Math.random() * 100 + "%"
                    };
                });
                nl.sort(function (a, b) {
                    return b.price - a.price;
                });
                if (prevPrice > nl[5].price) {
                    setIsUp(false);
                }
                else {
                    setIsUp(true);
                }
                prevPrice = nl[5].price;
                return nl;
            });
        }, 500);
        return function () {
            clearInterval(timer);
        };
    }, []);
    var _d = react_1.useState(false), show = _d[0], setShow = _d[1];
    react_1.useEffect(function () {
        var timer = setTimeout(function () {
            setShow(true);
        }, 100);
        return function () {
            clearTimeout(timer);
        };
    }, []);
    return (react_1["default"].createElement(react_native_1.View, { style: styles.ljn_container }, show ? (react_1["default"].createElement(react_1["default"].Fragment, null,
        react_1["default"].createElement(react_native_1.View, { style: styles.ljn_header },
            react_1["default"].createElement(react_native_1.View, { style: styles.ljn_header_left },
                react_1["default"].createElement(react_native_1.View, { style: styles.ljn_header_left_1 },
                    react_1["default"].createElement(react_native_1.Text, { style: react_native_1.StyleSheet.flatten([
                            styles.ljn_header_left_1_text,
                            styles.ljn_header_left_1_text_active,
                        ]) }, "\u73B0\u8D27")),
                react_1["default"].createElement(react_native_1.View, { style: styles.ljn_header_left_1 },
                    react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_header_left_1_text }, "\u6760\u6760")),
                react_1["default"].createElement(react_native_1.View, { style: styles.ljn_header_left_1 },
                    react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_header_left_1_text }, "\u6CD5\u5E01")))),
        react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation },
            react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_left },
                react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_left_title_area },
                    react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_left_title_area_icon },
                        react_1["default"].createElement(LJNIcon_1["default"], { title: "xinxi", size: 18 })),
                    react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_trade_operation_left_title_area_text1 }, "BTC/USDT"),
                    react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_trade_operation_left_title_area_text2 }, "-1.24%")),
                react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_buysell_buttons },
                    react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_buysell_buy },
                        react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_trade_operation_buysell_buy_text }, "\u4E70\u5165")),
                    react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_buysell_sell },
                        react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_trade_operation_buysell_sell_text }, "\u5356\u51FA"))),
                react_1["default"].createElement(react_native_1.TextInput, { editable: true, multiline: false, maxLength: 40, onChangeText: function (val) {
                        setText(val);
                    }, value: text, placeholder: "\u9650\u4EF7\u59D4\u6258", placeholderTextColor: theme === "dark" ? "white" : "black", style: react_native_1.StyleSheet.flatten([
                        styles.ljn_trade_operation_input,
                        react_native_1.Platform.OS === "web"
                            ? {
                                outline: "none"
                            }
                            : null,
                    ]) }),
                react_1["default"].createElement(react_native_1.TextInput, { editable: true, multiline: false, maxLength: 40, onChangeText: function (val) {
                        setText(val);
                    }, value: text, placeholder: "22887.55", placeholderTextColor: theme === "dark" ? "white" : "black", style: react_native_1.StyleSheet.flatten([
                        styles.ljn_trade_operation_input,
                        {
                            marginBottom: 0
                        },
                        react_native_1.Platform.OS === "web"
                            ? {
                                outline: "none"
                            }
                            : null,
                    ]) }),
                react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_about_value },
                    react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_trade_operation_about_value_text }, "\u224822887.55 CNY")),
                react_1["default"].createElement(react_native_1.TextInput, { editable: true, multiline: false, maxLength: 40, onChangeText: function (val) {
                        setText(val);
                    }, value: text, placeholder: "\u6570\u91CF", placeholderTextColor: theme === "dark" ? "white" : "black", style: react_native_1.StyleSheet.flatten([
                        styles.ljn_trade_operation_input,
                        react_native_1.Platform.OS === "web"
                            ? {
                                outline: "none"
                            }
                            : null,
                    ]) }),
                react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_percentage_selector },
                    react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_percentage_selector_button },
                        react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_trade_operation_percentage_selector_button_text }, "25%")),
                    react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_percentage_selector_button },
                        react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_trade_operation_percentage_selector_button_text }, "50%")),
                    react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_percentage_selector_button },
                        react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_trade_operation_percentage_selector_button_text }, "75%")),
                    react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_percentage_selector_button },
                        react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_trade_operation_percentage_selector_button_text }, "100%"))),
                react_1["default"].createElement(react_native_1.TextInput, { editable: true, multiline: false, maxLength: 40, onChangeText: function (val) {
                        setText(val);
                    }, value: text, placeholder: "\u4EA4\u6613\u989D", placeholderTextColor: theme === "dark" ? "white" : "black", style: react_native_1.StyleSheet.flatten([
                        styles.ljn_trade_operation_input,
                        react_native_1.Platform.OS === "web"
                            ? {
                                outline: "none"
                            }
                            : null,
                    ]) }),
                react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_balance_area },
                    react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_trade_balance_area_title }, "\u53EF\u7528"),
                    react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_balance_area_value },
                        react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_trade_balance_area_value_text1 }, "--"),
                        react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_trade_balance_area_value_text2 }, "USDT"),
                        react_1["default"].createElement(LJNIcon_1["default"], { title: "xinxi", size: 12 }))),
                react_1["default"].createElement(LJNButton_1["default"], { title: "登录", size: "middle" })),
            react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_right },
                react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_right_title_area },
                    react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_right_title_button },
                        react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_trade_operation_right_title_button_text }, "200X")),
                    react_1["default"].createElement(LJNIcon_1["default"], { title: "gupiao", size: 25 }),
                    react_1["default"].createElement(LJNIcon_1["default"], { title: "gengduo", size: 25 })),
                react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_right_float_title_area },
                    react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_right_float_title },
                        react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_trade_operation_right_float_title_text }, "\u4EF7\u683C")),
                    react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_right_float_title },
                        react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_trade_operation_right_float_title_text }, "\u6570\u91CF"))),
                list1.slice(0, 5).map(function (item, index) {
                    return (react_1["default"].createElement(react_native_1.View, { key: index, style: styles.ljn_trade_operation_right_float_data_area },
                        react_1["default"].createElement(react_native_1.View, { style: react_native_1.StyleSheet.flatten([
                                styles.ljn_trade_operation_right_float_data_background,
                                {
                                    backgroundColor: "#df5e52",
                                    opacity: 0.5,
                                    width: item.percentage
                                },
                            ]) }),
                        react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_right_float_data },
                            react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_trade_operation_right_float_data_text1 }, item.price)),
                        react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_right_float_data },
                            react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_trade_operation_right_float_data_text2 }, item.amount))));
                }),
                react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_current_price },
                    react_1["default"].createElement(react_native_1.Text, { style: react_native_1.StyleSheet.flatten([
                            styles.ljn_trade_operation_current_price_text1,
                            isUp ? { color: "#139a86" } : { color: "#df5e52" },
                        ]) }, list1[5].price),
                    react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_trade_operation_current_price_text2 },
                        "\u2248",
                        (list1[5].price * 7.5).toFixed(2),
                        "CNY")),
                list1.slice(5, 10).map(function (item, index) {
                    return (react_1["default"].createElement(react_native_1.View, { key: index, style: styles.ljn_trade_operation_right_float_data_area },
                        react_1["default"].createElement(react_native_1.View, { style: react_native_1.StyleSheet.flatten([
                                styles.ljn_trade_operation_right_float_data_background,
                                {
                                    backgroundColor: "#139a86",
                                    opacity: 0.5,
                                    width: item.percentage
                                },
                            ]) }),
                        react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_right_float_data },
                            react_1["default"].createElement(react_native_1.Text, { style: react_native_1.StyleSheet.flatten([
                                    styles.ljn_trade_operation_right_float_data_text1,
                                    {
                                        color: "#139a86"
                                    },
                                ]) }, item.price)),
                        react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_right_float_data },
                            react_1["default"].createElement(react_native_1.Text, { style: styles.ljn_trade_operation_right_float_data_text2 }, item.amount))));
                }),
                react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_accuracy },
                    react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_accuracy_selector_area },
                        react_1["default"].createElement(react_native_1.TextInput, { editable: false, multiline: false, maxLength: 40, onChangeText: function (val) {
                                setText(val);
                            }, value: text, placeholder: "0.01", placeholderTextColor: theme === "dark" ? "white" : "black", style: react_native_1.StyleSheet.flatten([
                                styles.ljn_trade_operation_accuracy_selector,
                                react_native_1.Platform.OS === "web"
                                    ? {
                                        outline: "none"
                                    }
                                    : null,
                            ]) })),
                    react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_accuracy_icon },
                        react_1["default"].createElement(react_native_1.View, { style: styles.ljn_trade_operation_accuracy_icon_box },
                            react_1["default"].createElement(LJNIcon_1["default"], { title: "liebiao", size: 20 })))))))) : (react_1["default"].createElement(LJNLoading_1["default"], null))));
};
exports["default"] = index;
