"use strict";
exports.__esModule = true;
exports.setTheme = void 0;
var react_native_1 = require("react-native");
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
            justifyContent: "center",
            alignItems: "center"
        },
        ljn_container_text: {
            color: theme.textColor
        }
    });
}
exports.setTheme = setTheme;
