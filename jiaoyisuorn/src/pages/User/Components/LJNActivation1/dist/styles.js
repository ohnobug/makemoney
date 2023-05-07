"use strict";
exports.__esModule = true;
exports.setTheme = void 0;
var react_native_1 = require("react-native");
var utils_1 = require("../../../../utils/utils");
var styles_1 = require("../../../../themes/default/styles");
var styles_2 = require("../../../../themes/light/styles");
var window = react_native_1.Dimensions.get("window");
function setTheme(name) {
    var theme;
    if (name === "dark") {
        theme = styles_1["default"];
    }
    else {
        theme = styles_2["default"];
    }
    return react_native_1.StyleSheet.create({
        ljn_activation_box: {
            // flexBasis: px2vw(177.5),
            width: utils_1.px2vw(182.5),
            height: utils_1.px2vw(177),
            backgroundColor: theme.areaBackgroundColor,
            marginBottom: utils_1.px2vw(10),
            borderRadius: utils_1.px2vw(10),
            display: "flex",
            flexDirection: "column"
        },
        ljn_activation_header: {
            flex: 0,
            flexBasis: utils_1.px2vw(38),
            display: "flex",
            flexDirection: "row"
        },
        ljn_activation_header_left: {
            flex: 2,
            display: "flex",
            justifyContent: "center",
            alignItems: "flex-start"
        },
        ljn_activation_header_left_title: {
            fontSize: utils_1.px2vw(16),
            color: theme.textColor,
            marginLeft: utils_1.px2vw(10)
        },
        ljn_activation_header_right: {
            flex: 1,
            display: "flex",
            justifyContent: "center",
            alignItems: "flex-end",
            marginRight: utils_1.px2vw(10)
        },
        ljn_activation_header_title: {},
        ljn_activation_main: {
            flex: 1,
            fontSize: utils_1.px2vw(30),
            paddingTop: utils_1.px2vw(10),
            paddingLeft: utils_1.px2vw(20),
            paddingBottom: utils_1.px2vw(20),
            paddingRight: utils_1.px2vw(20),
            display: "flex",
            flexDirection: "column"
        },
        ljn_activation_row1: {
            flex: 1,
            display: "flex",
            justifyContent: "center",
            alignItems: "center"
        },
        ljn_activation_row1_img: {
            height: utils_1.px2vw(30),
            width: utils_1.px2vw(80)
        },
        ljn_activation_row2: {
            flex: 1,
            display: "flex",
            justifyContent: "center",
            alignItems: "center"
        },
        ljn_activation_row2_text: {
            color: theme.textColor,
            fontSize: utils_1.px2vw(14)
        },
        ljn_activation_row3: {
            flex: 1,
            display: "flex",
            justifyContent: "center",
            alignItems: "center"
        }
    });
}
exports.setTheme = setTheme;
