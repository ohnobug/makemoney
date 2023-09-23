"use strict";
exports.__esModule = true;
exports.setTheme = void 0;
var react_native_1 = require("react-native");
var utils_1 = require("../../../../utils/utils");
var styles_1 = require("../../../../themes/default/styles");
var styles_2 = require("../../../../themes/light/styles");
function setTheme(name) {
    var theme;
    if (name === "dark") {
        theme = styles_1["default"];
    }
    else {
        theme = styles_2["default"];
    }
    return react_native_1.StyleSheet.create({
        ljn_container: {
            display: "flex",
            flexDirection: "row",
            flexWrap: "wrap",
            backgroundColor: theme.areaBackgroundColor,
            height: utils_1.px2vw(160),
            borderRadius: utils_1.px2vw(10),
            marginBottom: utils_1.px2vw(10)
        },
        ljn_container_area_1: {
            paddingTop: utils_1.px2vw(10),
            paddingBottom: utils_1.px2vw(13),
            paddingLeft: utils_1.px2vw(17),
            paddingRight: utils_1.px2vw(17),
            flex: 1,
            flexBasis: utils_1.px2vw(186.5),
            height: utils_1.px2vw(80),
            borderBottomWidth: utils_1.px2vw(1),
            borderBottomColor: theme.borderColor,
            borderRightWidth: utils_1.px2vw(1),
            borderRightColor: theme.borderColor,
            display: "flex",
            flexDirection: "row"
        },
        ljn_container_area_2: {
            paddingTop: utils_1.px2vw(10),
            paddingBottom: utils_1.px2vw(13),
            paddingLeft: utils_1.px2vw(17),
            paddingRight: utils_1.px2vw(17),
            flex: 1,
            flexBasis: utils_1.px2vw(187.5),
            height: utils_1.px2vw(80),
            borderBottomWidth: utils_1.px2vw(1),
            borderBottomColor: theme.borderColor,
            display: "flex",
            flexDirection: "row"
        },
        ljn_container_area_3: {
            paddingTop: utils_1.px2vw(10),
            paddingBottom: utils_1.px2vw(13),
            paddingLeft: utils_1.px2vw(17),
            paddingRight: utils_1.px2vw(17),
            flex: 1,
            flexBasis: utils_1.px2vw(186.5),
            height: utils_1.px2vw(80),
            borderRightWidth: utils_1.px2vw(1),
            borderRightColor: theme.borderColor,
            display: "flex",
            flexDirection: "row"
        },
        ljn_container_area_4: {
            paddingTop: utils_1.px2vw(10),
            paddingBottom: utils_1.px2vw(13),
            paddingLeft: utils_1.px2vw(17),
            paddingRight: utils_1.px2vw(17),
            flex: 1,
            flexBasis: utils_1.px2vw(187.5),
            height: utils_1.px2vw(80),
            display: "flex",
            flexDirection: "row",
            position: "relative"
        },
        ljn_function_left_area: {
            flex: 1
        },
        ljn_function_area_title1: {
            marginBottom: utils_1.px2vw(5),
            display: "flex",
            flexDirection: "row",
            alignItems: "center"
        },
        ljn_function_area_title1_inner: {
            color: theme.titleTextColor,
            fontWeight: "600",
            fontSize: utils_1.px2vw(12)
        },
        ljn_function_area_title1_inner2: {
            color: "#dc731a",
            // marginLeft: px2vw(5),
            paddingTop: utils_1.px2vw(2),
            paddingBottom: utils_1.px2vw(2),
            paddingLeft: utils_1.px2vw(8),
            paddingRight: utils_1.px2vw(8),
            fontSize: utils_1.px2vw(12),
            transform: [{ scale: 0.8 }],
            backgroundColor: theme.backgroundColor,
            fontStyle: "italic",
            borderRadius: utils_1.px2vw(4)
        },
        ljn_function_area_title2: {
            marginBottom: utils_1.px2vw(5)
        },
        ljn_function_area_title2_inner: {
            color: theme.reverseTextColor,
            fontWeight: "600",
            fontSize: utils_1.px2vw(14),
            height: utils_1.px2vw(18)
        },
        ljn_function_area_title3: {
        // marginBottom: px2vw(5),
        },
        ljn_function_area_title3_inner: {
            color: theme.titleTextColor,
            fontSize: utils_1.px2vw(10),
            height: utils_1.px2vw(14)
        },
        ljn_function_right_area: {
            flex: 0,
            flexBasis: utils_1.px2vw(45),
            // height: px2vw(45),
            display: "flex",
            flexDirection: "row",
            justifyContent: "flex-end",
            alignItems: "center"
        },
        ljn_function_right_area_img_inner: {
            width: utils_1.px2vw(38),
            height: utils_1.px2vw(38)
        }
    });
}
exports.setTheme = setTheme;
