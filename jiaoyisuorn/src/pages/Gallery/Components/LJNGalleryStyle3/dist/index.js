"use strict";
exports.__esModule = true;
var react_1 = require("react");
var react_native_1 = require("react-native");
var hooks_1 = require("../../../../hooks");
var styles_1 = require("./styles");
var index = function (_a) {
    var gallery = _a.gallery;
    var styles = hooks_1.useStyles(styles_1.setTheme);
    return (react_1["default"].createElement(react_native_1.View, { style: styles.ljn_gallery_list },
        react_1["default"].createElement(react_native_1.View, { style: styles.ljn_gallery_list_left }, gallery.slice(1).map(function (item, index) {
            return (react_1["default"].createElement(react_native_1.View, { style: styles.ljn_gallery_item, key: index },
                react_1["default"].createElement(react_native_1.Image, { style: styles.ljn_gallery_item_image, source: {
                        uri: item.image
                    } })));
        })),
        react_1["default"].createElement(react_native_1.View, { style: styles.ljn_gallery_list_right },
            react_1["default"].createElement(react_native_1.Image, { style: styles.ljn_gallery_list_right_image, source: {
                    uri: gallery[0].image
                } }))));
};
exports["default"] = index;
