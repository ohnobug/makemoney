"use strict";
exports.__esModule = true;
var react_1 = require("react");
var react_native_1 = require("react-native");
var LJNEmptyBlock_1 = require("../../components/LJNEmptyBlock");
var LJNIcon_1 = require("../../components/LJNIcon");
var LJNScrollView_1 = require("../../components/LJNScrollView");
var LJNTabbar_1 = require("../../components/LJNTabbar");
var hooks_1 = require("hooks");
var styles_1 = require("./styles");
function index(_a) {
  var styles = hooks_1.useStyles(styles_1.setTheme);
  var _b = react_1.useState([
      {
        icon: require("assets/images/nav1icon.png"),
        title: "CNY买币",
        path: "/",
      },
      {
        icon: require("assets/images/nav2icon.png"),
        title: "交易机器人",
        path: "/",
      },
      {
        icon: require("assets/images/nav3icon.png"),
        title: "USDT合约",
        path: "/",
      },
      {
        icon: require("assets/images/nav4icon.png"),
        title: "理财",
        path: "/",
      },
      {
        icon: require("assets/images/nav5icon.png"),
        title: "跟单 ",
        path: "/",
      },
    ]),
    list = _b[0],
    setList = _b[1];
  var bigScrollView = react_1.useRef(null);
  return react_1["default"].createElement(
    react_native_1.View,
    { style: styles.container },
    react_1["default"].createElement(LJNScrollView_1["default"], {
      style: styles.ljn_main,
      horizontal: false,
      ref: bigScrollView,
      children: react_1["default"].createElement(
        react_1["default"].Fragment,
        null,
        react_1["default"].createElement(
          react_native_1.View,
          { style: styles.ljn_assets_area },
          react_1["default"].createElement(
            react_native_1.View,
            { style: styles.ljn_header },
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_header_left },
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_header_left_1 },
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_header_left_1_text },
                  "\u603B\u8D44\u4EA7"
                )
              ),
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_header_left_2 },
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_header_left_2_text },
                  "CNY"
                ),
                react_1["default"].createElement(LJNIcon_1["default"], {
                  title: "xiajiantou",
                  size: 12,
                })
              ),
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_header_left_3 },
                react_1["default"].createElement(LJNIcon_1["default"], {
                  title: "eye",
                  size: 16,
                })
              )
            ),
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_header_right },
              react_1["default"].createElement(LJNIcon_1["default"], {
                title: "fenxiang_2",
                size: 20,
              })
            )
          ),
          react_1["default"].createElement(
            react_native_1.View,
            { style: styles.ljn_assets_info },
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_assets_amount_area },
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_assets_amount },
                react_1["default"].createElement(
                  react_native_1.View,
                  { style: styles.ljn_assets_value_icon },
                  react_1["default"].createElement(LJNIcon_1["default"], {
                    title: "rmb",
                    size: 20,
                    color: "white",
                  })
                ),
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_assets_value_text },
                  "0.00"
                )
              ),
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_assets_chart },
                react_1["default"].createElement(
                  react_native_1.View,
                  { style: styles.ljn_assets_chart_icon },
                  react_1["default"].createElement(LJNIcon_1["default"], {
                    title: "jinyizhoushouyi",
                    size: 16,
                    color: "white",
                  })
                ),
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_assets_chart_text },
                  "\u76C8\u4E8F\u65E5\u62A5"
                )
              )
            ),
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_assets_benefit_area },
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_assets_benefit_info1 },
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_assets_benefit_info1_title },
                  "\u4ECA\u65E5\u6536\u76CA"
                ),
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_assets_benefit_info1_value },
                  "--"
                )
              ),
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_assets_benefit_info2 },
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_assets_benefit_info2_title },
                  "\u4ECA\u65E5\u6536\u76CA\u7387"
                ),
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_assets_benefit_info2_value },
                  "0.00%"
                )
              ),
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_assets_benefit_info3 },
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_assets_benefit_info3_title },
                  "\u7D2F\u8BA1\u6536\u76CA"
                ),
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_assets_benefit_info3_value },
                  "--"
                )
              )
            )
          ),
          react_1["default"].createElement(
            react_native_1.View,
            { style: styles.ljn_list_area },
            list.map(function (item, index) {
              return react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_list_item, key: index },
                react_1["default"].createElement(
                  react_native_1.View,
                  { style: styles.ljn_list_item_icon },
                  react_1["default"].createElement(react_native_1.Image, {
                    style: styles.ljn_list_item_icon_img,
                    source: item.icon,
                  })
                ),
                react_1["default"].createElement(
                  react_native_1.View,
                  { style: styles.ljn_list_item_title },
                  react_1["default"].createElement(
                    react_native_1.Text,
                    { style: styles.ljn_list_item_title_inner },
                    item.title
                  )
                )
              );
            })
          )
        ),
        react_1["default"].createElement(
          react_native_1.View,
          { style: styles.ljn_quick_recharge },
          react_1["default"].createElement(LJNEmptyBlock_1["default"], null)
        )
      ),
    }),
    react_1["default"].createElement(
      react_native_1.View,
      { style: styles.ljn_footer },
      react_1["default"].createElement(LJNTabbar_1["default"], null)
    )
  );
}
exports["default"] = index;
