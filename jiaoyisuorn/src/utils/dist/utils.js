"use strict";
exports.__esModule = true;
exports.debounce = exports.px2vw = void 0;
var react_native_1 = require("react-native");
var deviceInfo = react_native_1.Dimensions.get("screen");
// 转换单位
function px2vw(value) {
    if (value === 1)
        return 1;
    var baseWidth = 375;
    return (value / baseWidth) * deviceInfo.width;
}
exports.px2vw = px2vw;
// 防抖
function debounce(fn, wait) {
    var timer = null;
    return function () {
        if (timer !== null) {
            clearTimeout(timer);
        }
        timer = setTimeout(fn, wait);
    };
}
exports.debounce = debounce;
