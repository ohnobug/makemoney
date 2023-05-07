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
        ljn_container: {
            height: utils_1.px2vw(350),
            backgroundColor: theme.areaBackgroundColor,
            display: "flex",
            flexDirection: "column"
        },
        // 资产、历史信息
        ljn_assets_history_info: {
            backgroundColor: theme.areaBackgroundColor
        }
    });
}
exports.setTheme = setTheme;
