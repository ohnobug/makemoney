"use strict";
exports.__esModule = true;
var react_1 = require("react");
var react_native_video_1 = require("react-native-video");
var noav = require("../../assets/noav.mp4");
function index(_a) {
    var style = _a.style;
    var video = react_1.useRef(null);
    return (react_1["default"].createElement(react_native_video_1["default"], { ref: function (ref) {
            video.current = ref;
        }, repeat: true, muted: true, resizeMode: "cover", style: style, source: noav }));
}
exports["default"] = index;
