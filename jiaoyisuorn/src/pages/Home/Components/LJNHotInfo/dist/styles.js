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
        ljn_echartsbg: {
            backgroundColor: theme.areaBackgroundColor
        },
        ljn_container: {
            height: utils_1.px2vw(146),
            backgroundColor: theme.areaBackgroundColor,
            paddingTop: utils_1.px2vw(5),
            paddingBottom: utils_1.px2vw(12),
            borderBottomLeftRadius: utils_1.px2vw(10),
            borderBottomRightRadius: utils_1.px2vw(10),
            marginBottom: utils_1.px2vw(10)
        },
        // 标题区域 --------------------start
        ljn_title_area: {
            height: utils_1.px2vw(30),
            display: "flex",
            justifyContent: "space-between",
            flexDirection: "row",
            borderBottomWidth: utils_1.px2vw(1),
            borderBottomColor: theme.borderColor,
            marginBottom: utils_1.px2vw(8)
        },
        ljn_title_area_left: {
            flex: 3,
            display: "flex",
            flexDirection: "row",
            paddingLeft: utils_1.px2vw(17)
        },
        ljn_title_area_left_title_before: {
            display: "flex",
            justifyContent: "center",
            marginRight: utils_1.px2vw(6)
        },
        ljn_title_area_left_title_before_inner: {
            borderRadius: utils_1.px2vw(3),
            color: "white",
            fontSize: utils_1.px2vw(10),
            width: utils_1.px2vw(30),
            height: utils_1.px2vw(16),
            textAlign: "center",
            backgroundColor: "#0070e7"
        },
        ljn_title_area_left_title_after: {
            display: "flex",
            justifyContent: "center"
        },
        ljn_title_area_left_title_after_inner: {
            color: theme.titleTextColor,
            fontSize: utils_1.px2vw(12)
        },
        ljn_title_area_right: {
            flex: 1,
            display: "flex",
            flexDirection: "row",
            alignItems: "center",
            justifyContent: "flex-end",
            paddingRight: utils_1.px2vw(17)
        },
        ljn_title_area_right_img: {
            width: utils_1.px2vw(16),
            height: utils_1.px2vw(16)
        },
        // --------------------------------------热门信息区域 start
        ljn_hotinfo_area: {
            display: "flex",
            flexDirection: "row",
            paddingLeft: utils_1.px2vw(10),
            paddingRight: utils_1.px2vw(10)
        },
        ljn_hotinfo: {
            flex: 1,
            paddingLeft: utils_1.px2vw(3),
            paddingRight: utils_1.px2vw(3)
        },
        ljn_currency_name_area: {
            // height: px2vw(14),
            fontSize: utils_1.px2vw(12),
            display: "flex",
            justifyContent: "center",
            alignItems: "center",
            flexDirection: "row",
            marginBottom: utils_1.px2vw(8)
        },
        ljn_currency_name: {
            color: theme.textColor,
            marginRight: utils_1.px2vw(3),
            fontSize: utils_1.px2vw(12)
        },
        ljn_currency_name_float: {
            color: "#dc6d63",
            fontSize: utils_1.px2vw(10)
        },
        ljn_currency_price_area: {
            height: utils_1.px2vw(18),
            marginBottom: utils_1.px2vw(8)
        },
        ljn_currency_price_title: {
            fontSize: utils_1.px2vw(14),
            fontWeight: "600",
            color: theme.textColor,
            textAlign: "center"
        },
        ljn_currency_kline_area: {
            // width: px2vw(150),
            height: utils_1.px2vw(30),
            textAlign: "center"
        },
        ljn_currency_kline: {
            color: "#f77f68",
            fontSize: utils_1.px2vw(14)
        }
    });
}
exports.setTheme = setTheme;
