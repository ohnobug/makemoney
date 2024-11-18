"use strict";
exports.__esModule = true;
exports.setTheme = void 0;
var react_native_1 = require("react-native");
var cssConfig_1 = require("../cssConfig");
function setTheme(name) {
    return react_native_1.StyleSheet.create({
        ljn_gallery_list: {
            display: "flex",
            flexDirection: "row"
        },
        ljn_gallery_list_middle: {
            flexBasis: cssConfig_1["default"].boxSize,
            height: cssConfig_1["default"].boxSize * 2 + cssConfig_1["default"].boxGap,
            marginLeft: cssConfig_1["default"].boxGap
        },
        ljn_gallery_list_middle_image: {
            width: "100%",
            height: "100%"
        },
        ljn_gallery_list_side: {
            flexBasis: cssConfig_1["default"].boxSize + cssConfig_1["default"].boxGap,
            display: "flex",
            flexWrap: "wrap",
            flexDirection: "row",
            justifyContent: "flex-start"
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
