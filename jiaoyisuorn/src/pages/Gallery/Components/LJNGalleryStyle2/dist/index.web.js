"use strict";
exports.__esModule = true;
var react_1 = require("react");
var react_native_1 = require("react-native");
var hooks_1 = require("../../../../hooks");
var styles_1 = require("./styles");
var react_native_video_1 = require("react-native-video");
var noav = require("../../../../assets/noav.mp4");
var index = function (_a) {
    var gallery = _a.gallery;
    var styles = hooks_1.useStyles(styles_1.setTheme);
    var video = react_1.useRef(null);
    // const [status, setStatus] = useState<any>({});
    var handleLayout = function (event) {
        var _a = event.nativeEvent.layout, x = _a.x, y = _a.y, width = _a.width, height = _a.height;
        console.log("视图布局发生变化：", { x: x, y: y, width: width, height: height });
    };
    return (react_1["default"].createElement(react_native_1.View, { style: styles.ljn_gallery_list, onLayout: handleLayout },
        react_1["default"].createElement(react_native_1.View, { style: styles.ljn_gallery_list_left },
            react_1["default"].createElement(react_native_1.View, { style: styles.ljn_gallery_item },
                react_1["default"].createElement(react_native_video_1["default"], { ref: function (ref) {
                        video.current = ref;
                    }, repeat: true, muted: true, resizeMode: "cover", style: styles.ljn_gallery_item_video, source: noav }))),
        react_1["default"].createElement(react_native_1.View, { style: styles.ljn_gallery_list_right }, gallery.slice(1).map(function (item, index) { return (react_1["default"].createElement(react_native_1.View, { style: styles.ljn_gallery_item, key: index },
            react_1["default"].createElement(react_native_1.Image, { style: styles.ljn_gallery_item_image, source: {
                    uri: item.image
                } }))); }))));
};
exports["default"] = index;
