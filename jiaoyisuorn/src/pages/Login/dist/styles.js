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
        ljn_container: {
            flex: 1,
            display: "flex",
            flexDirection: "column",
            backgroundColor: theme.backgroundColor
        },
        ljn_main: {
            paddingRight: utils_1.px2vw(17),
            paddingBottom: utils_1.px2vw(17),
            paddingLeft: utils_1.px2vw(17)
        },
        ljn_login_title: {
            height: utils_1.px2vw(95),
            display: "flex",
            alignItems: "flex-start",
            justifyContent: "center"
        },
        ljn_login_title_text: {
            fontSize: utils_1.px2vw(28),
            fontWeight: "600",
            color: theme.textColor
        },
        ljn_login_form_area: {},
        ljn_login_form: {
            display: "flex",
            height: utils_1.px2vw(200),
            marginBottom: utils_1.px2vw(50)
        },
        ljn_login_form_row1: {
            flexBasis: utils_1.px2vw(80),
            display: "flex",
            flexDirection: "row",
            alignItems: "center",
            justifyContent: "center"
        },
        ljn_login_form_row1_input: {
            backgroundColor: theme.areaBackgroundColor,
            height: utils_1.px2vw(47),
            borderRadius: utils_1.px2vw(5),
            flex: 1,
            paddingLeft: utils_1.px2vw(25),
            paddingRight: utils_1.px2vw(25),
            color: theme.textColor,
            fontSize: utils_1.px2vw(16),
            fontWeight: "600"
        },
        ljn_login_form_row2: {
            flex: 1,
            display: "flex",
            alignItems: "center",
            justifyContent: "center"
        },
        ljn_login_form_row3: {
            flex: 1,
            display: "flex",
            alignItems: "center",
            justifyContent: "center"
        },
        ljn_login_form_row3_text: {
        // color: theme.primaryColor,
        },
        ljn_other_login_style: {
            marginTop: utils_1.px2vw(20),
            display: "flex",
            flexDirection: "row",
            justifyContent: "space-around",
            marginBottom: utils_1.px2vw(20)
        },
        ljn_other_login_style_item: {
            height: utils_1.px2vw(80)
        },
        ljn_other_login_logo: {
            flexBasis: utils_1.px2vw(50),
            display: "flex",
            alignItems: "center",
            justifyContent: "center"
        },
        ljn_other_login_logo_img: {
            width: utils_1.px2vw(40),
            height: utils_1.px2vw(40)
        },
        ljn_other_login_title: {
            flex: 1,
            display: "flex",
            alignItems: "center",
            justifyContent: "center"
        },
        ljn_other_login_title_text: {
            color: theme.textColor
        },
        ljn_tips_text: {
            display: "flex",
            flexDirection: "row",
            justifyContent: "center"
        },
        ljn_user_tips_text: {
            color: theme.titleTextColor,
            fontSize: utils_1.px2vw(12)
        },
        ljn_user_agreement: {
            fontSize: utils_1.px2vw(12)
        }
    });
}
exports.setTheme = setTheme;
