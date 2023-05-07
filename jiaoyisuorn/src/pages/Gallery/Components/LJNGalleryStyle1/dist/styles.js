"use strict";
exports.__esModule = true;
exports.setTheme = void 0;
var react_native_1 = require("react-native");
var cssConfig_1 = require("../cssConfig");
function setTheme(name) {
    return react_native_1.StyleSheet.create({
        ljn_gallery_list: {
            display: "flex",
            // backgroundColor: "red",
            flexDirection: "row",
            justifyContent: "flex-start",
            flexWrap: "wrap"
        },
        ljn_gallery_item: {
            height: cssConfig_1["default"].boxSize,
            flexBasis: cssConfig_1["default"].boxSize,
            marginLeft: cssConfig_1["default"].boxGap,
            marginBottom: cssConfig_1["default"].boxGap
        },
        ljn_gallery_item_image: {
            width: "100%",
            height: "100%"
        }
    });
}
exports.setTheme = setTheme;
