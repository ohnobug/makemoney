"use strict";
exports.__esModule = true;
var react_1 = require("react");
var react_native_1 = require("react-native");
var LJNLoading_1 = require("components/LJNLoading");
var hooks_1 = require("hooks");
var styles_1 = require("./styles");
var index = function (props) {
  var styles = hooks_1.useStyles(styles_1.setTheme);
  var _a = react_1.useState(true),
    show = _a[0],
    setShow = _a[1];
  react_1.useEffect(function () {
    var timer = setTimeout(function () {
      setShow(true);
    }, 0);
    return function () {
      clearTimeout(timer);
    };
  }, []);
  return react_1["default"].createElement(
    react_native_1.View,
    { style: styles.ljn_container },
    show
      ? react_1["default"].createElement(
          react_1["default"].Fragment,
          null,
          react_1["default"].createElement(
            react_native_1.View,
            { style: styles.ljn_container_area_1 },
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_function_left_area },
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_function_area_title1 },
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_function_area_title1_inner },
                  "\u65B0\u5E01\u4E13\u533A"
                )
              ),
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_function_area_title2 },
                react_1["default"].createElement(
                  react_native_1.Text,
                  {
                    style: styles.ljn_function_area_title2_inner,
                    numberOfLines: 10,
                  },
                  "\u514D\u8D39\u7A7A\u6295\u5929\u5929\u9886"
                )
              ),
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_function_area_title3 },
                react_1["default"].createElement(
                  react_native_1.Text,
                  {
                    style: styles.ljn_function_area_title3_inner,
                    numberOfLines: 11,
                  },
                  "500U\u9526\u9CA4\u5927\u5956\u7B49\u4F60\u62FF"
                )
              )
            ),
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_function_right_area },
              react_1["default"].createElement(react_native_1.Image, {
                style: styles.ljn_function_right_area_img_inner,
                source: require("assets/images/function1icon.png"),
              })
            )
          ),
          react_1["default"].createElement(
            react_native_1.View,
            { style: styles.ljn_container_area_2 },
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_function_left_area },
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_function_area_title1 },
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_function_area_title1_inner },
                  "\u5FEB\u6377\u4E70\u5E01"
                )
              ),
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_function_area_title2 },
                react_1["default"].createElement(
                  react_native_1.Text,
                  {
                    style: styles.ljn_function_area_title2_inner,
                    numberOfLines: 10,
                  },
                  "\u5145\u5E01/C2C"
                )
              ),
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_function_area_title3 },
                react_1["default"].createElement(
                  react_native_1.Text,
                  {
                    style: styles.ljn_function_area_title3_inner,
                    numberOfLines: 11,
                  },
                  "1.00 CNY/USDT"
                )
              )
            ),
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_function_right_area },
              react_1["default"].createElement(react_native_1.Image, {
                style: styles.ljn_function_right_area_img_inner,
                source: require("assets/images/function2icon.png"),
              })
            )
          ),
          react_1["default"].createElement(
            react_native_1.View,
            { style: styles.ljn_container_area_3 },
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_function_left_area },
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_function_area_title1 },
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_function_area_title1_inner },
                  "\u679C\u679C\u7406\u8D22"
                )
              ),
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_function_area_title2 },
                react_1["default"].createElement(
                  react_native_1.Text,
                  {
                    style: styles.ljn_function_area_title2_inner,
                    numberOfLines: 10,
                  },
                  "USDD 18%\u5E74\u5229\u7387"
                )
              ),
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_function_area_title3 },
                react_1["default"].createElement(
                  react_native_1.Text,
                  {
                    style: styles.ljn_function_area_title3_inner,
                    numberOfLines: 11,
                  },
                  "\u8F7B\u677E\u4FDD\u672C\u7A33\u5065\u8D5A"
                )
              )
            ),
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_function_right_area },
              react_1["default"].createElement(react_native_1.Image, {
                style: styles.ljn_function_right_area_img_inner,
                source: require("assets/images/function3icon.png"),
              })
            )
          ),
          react_1["default"].createElement(
            react_native_1.View,
            { style: styles.ljn_container_area_4 },
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_function_left_area },
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_function_area_title1 },
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_function_area_title1_inner },
                  "\u76F4\u64AD"
                ),
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_function_area_title1_inner2 },
                  "\u6B63\u5728\u76F4\u64AD"
                )
              ),
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_function_area_title2 },
                react_1["default"].createElement(
                  react_native_1.Text,
                  {
                    style: styles.ljn_function_area_title2_inner,
                    numberOfLines: 10,
                  },
                  "\u591A\u6295\u83B7\u5229, \u5E02\u573A\u5E7F\u5927"
                )
              ),
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_function_area_title3 },
                react_1["default"].createElement(
                  react_native_1.Text,
                  {
                    style: styles.ljn_function_area_title3_inner,
                    numberOfLines: 11,
                  },
                  "\u89C2\u770B\uFF1A410"
                )
              )
            ),
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_function_right_area },
              react_1["default"].createElement(react_native_1.Image, {
                style: styles.ljn_function_right_area_img_inner,
                source: require("assets/images/function4icon.png"),
              })
            )
          )
        )
      : react_1["default"].createElement(LJNLoading_1["default"], null)
  );
};
exports["default"] = index;
