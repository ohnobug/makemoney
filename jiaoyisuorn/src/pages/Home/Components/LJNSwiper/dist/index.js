"use strict";
exports.__esModule = true;
var react_1 = require("react");
var react_native_1 = require("react-native");
var bus_1 = require("../../../../bus");
var hooks_1 = require("../../../../hooks");
var index_1 = require("../../../../library/react-native-web-swiper/src/index");
var utils_1 = require("../../../../utils/utils");
var styles_1 = require("./styles");
// 接收父组件ref
var bigScrollView;
bus_1["default"].on("getBigScrollView", function (e) {
    bigScrollView = e;
});
var index = function (props) {
    var _a = react_1.useState([
        require("../../../../assets/images/ad1.jpg"),
        require("../../../../assets/images/ad2.jpg"),
        require("../../../../assets/images/ad3.jpg"),
        require("../../../../assets/images/ad4.jpg"),
        require("../../../../assets/images/ad5.jpg"),
    ]), list = _a[0], setList = _a[1];
    var fd = react_1.useCallback(utils_1.debounce(function () {
        bigScrollView === null || bigScrollView === void 0 ? void 0 : bigScrollView.setNativeProps({
            scrollEnabled: true
        });
    }, 500), []);
    var _b = react_1.useState(false), show = _b[0], setShow = _b[1];
    react_1.useEffect(function () {
        var timer = setTimeout(function () {
            setShow(true);
        }, 100);
        return function () {
            // 如果不加该行，可能会操作已经被销毁的View
            bigScrollView = null;
            clearTimeout(timer);
        };
    }, []);
    var styles = hooks_1.useStyles(styles_1.setTheme);
    return (react_1["default"].createElement(react_native_1.View, { style: styles.container }, show ? (react_1["default"].createElement(index_1["default"], { loop: false, vertical: false, minDistanceToCapture: 10, minDistanceForAction: 0.1, onAnimationStart: function () {
            bigScrollView === null || bigScrollView === void 0 ? void 0 : bigScrollView.setNativeProps({
                scrollEnabled: false
            });
        }, onAnimationEnd: function () {
            fd();
        }, springConfig: {
            stiffness: 100,
            damping: 100,
            mass: 0.2
        }, controlsEnabled: true, controlsProps: {
            prevPos: false,
            nextPos: false
        } }, list.map(function (item, index) {
        return (react_1["default"].createElement(react_native_1.View, { style: styles.ljn_slide, key: index },
            react_1["default"].createElement(react_native_1.Image, { style: styles.ljn_slide_image, source: item })));
    }))) : (react_1["default"].createElement(react_native_1.View, { style: styles.ljn_slide },
        react_1["default"].createElement(react_native_1.Image, { style: styles.ljn_slide_image, source: list[0] })))));
};
exports["default"] = index;
