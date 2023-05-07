"use strict";
exports.__esModule = true;
var react_1 = require("react");
var noav = require("../../assets/noav.mp4");
function index(_a) {
    var style = _a.style;
    var video = react_1.useRef(null);
    return (react_1["default"].createElement("video", { ref: function (ref) {
            video.current = ref;
        }, style: style, src: noav }));
}
exports["default"] = index;
