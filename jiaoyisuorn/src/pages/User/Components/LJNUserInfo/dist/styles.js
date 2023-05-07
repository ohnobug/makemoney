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
        container: {
            flex: 1,
            display: "flex",
            flexDirection: "column",
            backgroundColor: theme.backgroundColor
        },
        ljn_main: {
            flex: 1,
            maxHeight: window.height - utils_1.px2vw(60)
        },
        // 用户信息
        ljn_header_area: {
            height: utils_1.px2vw(350),
            backgroundColor: theme.areaBackgroundColor,
            borderBottomLeftRadius: utils_1.px2vw(10),
            borderBottomRightRadius: utils_1.px2vw(10),
            marginBottom: utils_1.px2vw(12),
            padding: utils_1.px2vw(10)
        },
        // 顶部功能
        ljn_header_function: {
            height: utils_1.px2vw(30),
            display: "flex",
            flexDirection: "row",
            justifyContent: "flex-end",
            alignItems: "center"
        },
        // 顶部功能按钮
        ljn_header_function_btn: {
            flex: 0,
            flexBasis: utils_1.px2vw(25),
            marginLeft: utils_1.px2vw(25),
            height: utils_1.px2vw(30),
            width: utils_1.px2vw(30),
            display: "flex",
            flexDirection: "row",
            justifyContent: "center",
            alignItems: "center"
        },
        // 用户名称信息
        ljn_userinfo_area: {
            height: utils_1.px2vw(77),
            // backgroundColor: "yellow",
            display: "flex",
            flexDirection: "row",
            marginBottom: utils_1.px2vw(9)
        },
        ljn_userinfo_avatar_area: {
            flexBasis: utils_1.px2vw(92)
        },
        ljn_userinfo_avatar_area_img: {
            height: utils_1.px2vw(65),
            width: utils_1.px2vw(65),
            borderRadius: utils_1.px2vw(65)
        },
        ljn_userinfo: {
            flex: 1,
            display: "flex",
            flexDirection: "column"
        },
        ljn_userinfo_username: {
            marginBottom: utils_1.px2vw(7),
            height: utils_1.px2vw(25)
        },
        ljn_userinfo_username_text: {
            fontSize: utils_1.px2vw(19),
            color: theme.textColor,
            fontWeight: "600"
        },
        ljn_userinfo_uid: {
            display: "flex",
            alignItems: "flex-start",
            marginBottom: utils_1.px2vw(7),
            height: utils_1.px2vw(16)
        },
        ljn_userinfo_uid_area: {
            backgroundColor: theme.backgroundColor,
            display: "flex",
            flexDirection: "row",
            alignContent: "center",
            justifyContent: "center",
            paddingLeft: utils_1.px2vw(8),
            paddingRight: utils_1.px2vw(8),
            height: utils_1.px2vw(18),
            borderRadius: utils_1.px2vw(8)
        },
        ljn_userinfo_uid_copy_icon: {
            marginLeft: utils_1.px2vw(5),
            display: "flex",
            alignContent: "center",
            justifyContent: "center"
        },
        ljn_userinfo_uid_text: {
            color: theme.titleTextColor,
            fontSize: utils_1.px2vw(12)
        },
        ljn_userinfo_about: {
            display: "flex",
            flexDirection: "row"
        },
        ljn_userinfo_about_inner: {
            marginRight: utils_1.px2vw(15),
            display: "flex",
            flexDirection: "row"
        },
        ljn_userinfo_about_inner_val: {
            color: theme.textColor,
            fontSize: utils_1.px2vw(12),
            marginRight: utils_1.px2vw(5)
        },
        ljn_userinfo_about_inner_title: {
            fontSize: utils_1.px2vw(12),
            color: theme.titleTextColor
        },
        ljn_userinfo_auth: {
            flexBasis: utils_1.px2vw(68)
        },
        ljn_userinfo_auth_btn1: {
            height: utils_1.px2vw(22),
            borderColor: theme.borderColor,
            borderWidth: utils_1.px2vw(1),
            borderTopStartRadius: utils_1.px2vw(22),
            borderBottomStartRadius: utils_1.px2vw(22),
            paddingLeft: utils_1.px2vw(10),
            paddingRight: utils_1.px2vw(10),
            display: "flex",
            flexDirection: "row",
            alignItems: "center",
            justifyContent: "center",
            marginBottom: utils_1.px2vw(4),
            marginTop: utils_1.px2vw(15),
            position: "relative",
            right: utils_1.px2vw(-10)
        },
        ljn_userinfo_auth_btn1_text: {
            fontSize: utils_1.px2vw(12),
            color: theme.titleTextColor
        },
        ljn_userinfo_auth_btn2: {
            height: utils_1.px2vw(22),
            borderColor: theme.borderColor,
            borderWidth: utils_1.px2vw(1),
            borderTopStartRadius: utils_1.px2vw(22),
            borderBottomStartRadius: utils_1.px2vw(22),
            paddingLeft: utils_1.px2vw(10),
            paddingRight: utils_1.px2vw(10),
            display: "flex",
            flexDirection: "row",
            alignItems: "center",
            justifyContent: "center",
            position: "relative",
            right: utils_1.px2vw(-10)
        },
        ljn_userinfo_auth_btn2_text: {
            fontSize: utils_1.px2vw(12),
            color: theme.titleTextColor
        },
        // 用户等级
        ljn_userinfo_level_area: {
            backgroundColor: theme.areaBackgroundColor,
            borderRadius: utils_1.px2vw(10),
            borderWidth: utils_1.px2vw(1),
            borderColor: theme.borderColor,
            paddingTop: utils_1.px2vw(3),
            paddingRight: utils_1.px2vw(8),
            paddingBottom: utils_1.px2vw(3),
            paddingLeft: utils_1.px2vw(8),
            marginBottom: utils_1.px2vw(5)
        },
        ljn_userinfo_level_row1: {
            height: utils_1.px2vw(40),
            borderBottomColor: theme.borderColor,
            borderBottomWidth: utils_1.px2vw(1),
            display: "flex",
            flexDirection: "row",
            justifyContent: "space-between",
            alignItems: "center"
        },
        ljn_userinfo_level_row1_left: {},
        ljn_userinfo_level_row1_left_text1: {
            color: theme.textColor,
            fontWeight: "600",
            fontSize: utils_1.px2vw(18),
            fontStyle: "italic"
        },
        ljn_userinfo_level_row1_right: {
            display: "flex",
            flexDirection: "row"
        },
        ljn_userinfo_level_row1_right_text1: {
            color: theme.textColor,
            marginRight: utils_1.px2vw(5)
        },
        ljn_userinfo_level_row1_right_text2: {
            color: "#009bff",
            fontSize: utils_1.px2vw(14)
        },
        ljn_userinfo_level_row2: {
            height: utils_1.px2vw(30),
            display: "flex",
            flexDirection: "row",
            justifyContent: "flex-end",
            alignItems: "center"
        },
        ljn_userinfo_level_row2_text: {
            color: theme.titleTextColor,
            textAlign: "right",
            fontSize: utils_1.px2vw(12)
        },
        // 功能区1
        ljn_userinfo_detail_func1: {
            borderBottomColor: theme.borderColor,
            borderBottomWidth: utils_1.px2vw(1)
        },
        ljn_list_area: {
            backgroundColor: theme.areaBackgroundColor,
            display: "flex",
            flexDirection: "row",
            flexWrap: "wrap"
        },
        ljn_list_item: {
            flexGrow: 1,
            flexBasis: utils_1.px2vw(68.2),
            height: utils_1.px2vw(65),
            display: "flex",
            justifyContent: "center",
            alignItems: "center",
            flexDirection: "column",
            marginTop: utils_1.px2vw(5)
        },
        ljn_list_item_icon: {
            width: utils_1.px2vw(30),
            height: utils_1.px2vw(30),
            marginBottom: utils_1.px2vw(2)
        },
        ljn_list_item_icon_img: {
            width: utils_1.px2vw(30),
            height: utils_1.px2vw(30)
        },
        ljn_list_item_title: {},
        ljn_list_item_title_inner: {
            color: theme.titleTextColor,
            textAlign: "center",
            fontSize: utils_1.px2vw(11)
        },
        // 功能区2
        ljn_userinfo_detail_func2: {}
    });
}
exports.setTheme = setTheme;
