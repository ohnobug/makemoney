"use strict";
exports.__esModule = true;
exports.setTheme = void 0;
var react_native_1 = require("react-native");
var utils_1 = require("../../utils/utils");
var styles_1 = require("../../themes/default/styles");
var styles_2 = require("../../themes/light/styles");
function setTheme(name) {
    var theme;
    if (name === "dark") {
        theme = styles_1["default"];
    }
    else {
        theme = styles_2["default"];
    }
    return react_native_1.StyleSheet.create({
        ljn_tabbar: {
            height: utils_1.px2vw(60),
            paddingTop: utils_1.px2vw(5),
            paddingBottom: utils_1.px2vw(5),
            display: "flex",
            flexDirection: "row",
            backgroundColor: theme.areaBackgroundColor,
            borderTopWidth: utils_1.px2vw(1),
            borderTopColor: theme.borderColor
        },
        ljn_tabbar_item: {
            flex: 1,
            display: "flex",
            flexDirection: "column",
            alignItems: "center"
        },
        ljn_tabbar_item_img_area: {
            flex: 1,
            display: "flex",
            alignItems: "center",
            flexDirection: "row"
        },
        ljn_tabbar_item_img: {
            width: utils_1.px2vw(27),
            height: utils_1.px2vw(27)
        },
        ljn_tabbar_item_title_area: {
            flex: 0,
            minHeight: utils_1.px2vw(15),
            width: "100%",
            display: "flex",
            justifyContent: "center",
            flexDirection: "row",
            alignItems: "center"
        },
        ljn_tabbar_item_title: {
            fontSize: utils_1.px2vw(12),
            color: theme.titleTextColor,
            transform: [{ scale: 0.85 }]
        },
        ljn_tabbar_item_title_active: {
            color: name === "dark" ? "white" : theme.primaryColor,
            fontWeight: "600"
        }
    });
}
exports.setTheme = setTheme;
