"use strict";
exports.__esModule = true;
var react_native_1 = require("react-native");
var react_1 = require("react");
var utils_1 = require("../../utils/utils");
var LJNScrollView_1 = require("../../components/LJNScrollView");
var hooks_1 = require("../../hooks");
var styles_1 = require("./styles");
var SystemSlice_1 = require("../../store/SystemSlice");
// 位置信息
var index = function (_a, ref) {
    var list = _a.list, onChange = _a.onChange;
    var theme = hooks_1.useAppSelector(SystemSlice_1.selectTheme);
    var _b = react_1.useState(styles_1.setTheme(theme)), styles = _b[0], setStyles = _b[1];
    react_1.useEffect(function () {
        setStyles(styles_1.setTheme(theme));
    }, [theme]);
    var TabPositionInfo = react_1.useRef([]).current;
    // 滚动对象
    var myScrollView = react_1.useRef(null);
    var _c = react_1.useState(0), activeIndex = _c[0], setActiveIndex = _c[1];
    // tabs 底部蓝色
    var springLeft = react_1.useRef(new react_native_1.Animated.Value(9.6)).current;
    var springWidth = react_1.useRef(new react_native_1.Animated.Value(26.8)).current;
    // 蓝块滑动
    var spring = function (x, width) {
        var c = {
            toValue: x,
            duration: 300,
            useNativeDriver: false
        };
        react_native_1.Animated.timing(springLeft, c).start();
        var d = {
            toValue: width,
            duration: 200,
            useNativeDriver: false
        };
        react_native_1.Animated.timing(springWidth, d).start();
    };
    // 当按钮改变的时候;
    var change = function (index, callfunction) {
        var _a;
        if (callfunction === void 0) { callfunction = true; }
        if (TabPositionInfo.length !== list.length)
            index = 0;
        var item = TabPositionInfo[index];
        // 下方蓝色方块动画
        if (item) {
            spring(item.x, item.width);
            // 居中-------------------------------------
            var value = item.x - utils_1.px2vw(182.5) + item.width / 2;
            if (value < 0)
                value = 0;
            (_a = myScrollView.current) === null || _a === void 0 ? void 0 : _a.scrollTo({
                x: value,
                animated: true
            });
        }
        if (callfunction) {
            // 父节点方法
            onChange && onChange(index);
        }
    };
    react_1.useImperativeHandle(ref, function () { return ({
        goTo: function (index) {
            setActiveIndex(index);
        }
    }); });
    react_1.useEffect(function () {
        change(activeIndex);
    }, [activeIndex]);
    return (react_1["default"].createElement(LJNScrollView_1["default"], { style: styles.ljn_tabs, horizontal: true, ref: myScrollView, children: react_1["default"].createElement(react_1["default"].Fragment, null,
            react_1["default"].createElement(react_native_1.Animated.View, { style: react_native_1.StyleSheet.flatten([
                    styles.ljn_fly_bottom,
                    {
                        width: springWidth,
                        left: springLeft
                    },
                ]) }),
            list.map(function (item, index) {
                return (react_1["default"].createElement(react_native_1.View, { onLayout: function (event) {
                        var layout = event.nativeEvent.layout;
                        TabPositionInfo.push({
                            x: layout.x + utils_1.px2vw(10),
                            width: layout.width - utils_1.px2vw(20)
                        });
                    }, style: styles.ljn_tab, key: index, onTouchEnd: function () {
                        setActiveIndex(index);
                    } },
                    react_1["default"].createElement(react_native_1.Text, { style: react_native_1.StyleSheet.flatten([
                            styles.ljn_tab_text,
                            index === activeIndex ? styles.ljn_tab_text_active : null,
                        ]) }, item)));
            })) }));
};
exports["default"] = react_1["default"].forwardRef(index);
