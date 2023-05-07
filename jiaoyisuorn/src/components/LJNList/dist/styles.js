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
        ljn_list: {
            backgroundColor: theme.areaBackgroundColor,
            borderRadius: utils_1.px2vw(10),
            marginBottom: utils_1.px2vw(10)
        },
        ljn_list_item_last: {
            borderBottomColor: theme.areaBackgroundColor
        },
        ljn_list_item: {
            height: utils_1.px2vw(64),
            borderBottomColor: theme.borderColor,
            borderBottomWidth: utils_1.px2vw(1),
            marginLeft: utils_1.px2vw(17),
            marginRight: utils_1.px2vw(17),
            display: "flex"
        },
        ljn_list_item_inner: {
            height: utils_1.px2vw(64),
            display: "flex",
            flexDirection: "row",
            alignItems: "center"
        },
        ljn_list_item_title: {
            flex: 1
        },
        ljn_list_item_title_text: {
            color: theme.textColor,
            fontSize: utils_1.px2vw(16)
        },
        ljn_list_item_desc: {
            flex: 1,
            display: "flex",
            alignItems: "flex-end"
        },
        ljn_list_item_desc_text: {
            color: theme.titleTextColor,
            fontSize: utils_1.px2vw(14)
        },
        ljn_list_item_icon: {
            flexBasis: utils_1.px2vw(20),
            display: "flex",
            alignItems: "flex-end"
        },
        ljn_list_item_icon_img: {
        // width: px2vw(16),
        // height: px2vw(16),
        }
    });
}
exports.setTheme = setTheme;
