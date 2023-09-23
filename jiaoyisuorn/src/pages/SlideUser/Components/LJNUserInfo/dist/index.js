"use strict";
exports.__esModule = true;
var react_1 = require("react");
var react_native_1 = require("react-native");
var react_router_native_1 = require("react-router-native");
var LJNIcon_1 = require("components/LJNIcon");
var LJNLoading_1 = require("components/LJNLoading");
var hooks_1 = require("hooks");
var styles_1 = require("./styles");
var index = function (props) {
  var navigate = react_router_native_1.useNavigate();
  var styles = hooks_1.useStyles(styles_1.setTheme);
  var _a = react_1.useState([
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
    list = _a[0],
    setList = _a[1];
  var _b = react_1.useState(false),
    show = _b[0],
    setShow = _b[1];
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
    { style: styles.ljn_header_area },
    show
      ? react_1["default"].createElement(
          react_1["default"].Fragment,
          null,
          react_1["default"].createElement(
            react_native_1.View,
            { style: styles.ljn_header_function },
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_header_function_btn },
              react_1["default"].createElement(LJNIcon_1["default"], {
                title: "yuyan",
                size: 20,
              })
            ),
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_header_function_btn },
              react_1["default"].createElement(LJNIcon_1["default"], {
                title: "xinxi",
                size: 18,
              })
            ),
            react_1["default"].createElement(
              react_native_1.View,
              {
                style: styles.ljn_header_function_btn,
                onTouchEnd: function () {
                  navigate("/setting");
                },
              },
              react_1["default"].createElement(LJNIcon_1["default"], {
                title: "shezhi",
                size: 20,
              })
            )
          ),
          react_1["default"].createElement(
            react_native_1.View,
            { style: styles.ljn_userinfo_area },
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_userinfo_avatar_area },
              react_1["default"].createElement(react_native_1.Image, {
                style: styles.ljn_userinfo_avatar_area_img,
                source: require("assets/images/ad2.jpg"),
              })
            ),
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_userinfo },
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_userinfo_username },
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_userinfo_username_text },
                  "228****@qq.com"
                )
              ),
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_userinfo_uid },
                react_1["default"].createElement(
                  react_native_1.View,
                  { style: styles.ljn_userinfo_uid_area },
                  react_1["default"].createElement(
                    react_native_1.Text,
                    { style: styles.ljn_userinfo_uid_text },
                    "UID 427678500"
                  ),
                  react_1["default"].createElement(
                    react_native_1.View,
                    { style: styles.ljn_userinfo_uid_copy_icon },
                    react_1["default"].createElement(LJNIcon_1["default"], {
                      title: "fuzhi",
                      size: 10,
                    })
                  )
                )
              ),
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_userinfo_about },
                react_1["default"].createElement(
                  react_native_1.View,
                  { style: styles.ljn_userinfo_about_inner },
                  react_1["default"].createElement(
                    react_native_1.Text,
                    { style: styles.ljn_userinfo_about_inner_val },
                    "0"
                  ),
                  react_1["default"].createElement(
                    react_native_1.Text,
                    { style: styles.ljn_userinfo_about_inner_title },
                    "\u5173\u6CE8"
                  )
                ),
                react_1["default"].createElement(
                  react_native_1.View,
                  { style: styles.ljn_userinfo_about_inner },
                  react_1["default"].createElement(
                    react_native_1.Text,
                    { style: styles.ljn_userinfo_about_inner_val },
                    "0"
                  ),
                  react_1["default"].createElement(
                    react_native_1.Text,
                    { style: styles.ljn_userinfo_about_inner_title },
                    "\u7C89\u4E1D"
                  )
                ),
                react_1["default"].createElement(
                  react_native_1.View,
                  { style: styles.ljn_userinfo_about_inner },
                  react_1["default"].createElement(
                    react_native_1.Text,
                    { style: styles.ljn_userinfo_about_inner_val },
                    "0"
                  ),
                  react_1["default"].createElement(
                    react_native_1.Text,
                    { style: styles.ljn_userinfo_about_inner_title },
                    "\u52A8\u6001"
                  )
                )
              )
            ),
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_userinfo_auth_area },
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_userinfo_auth_btn1 },
                react_1["default"].createElement(LJNIcon_1["default"], {
                  title: "4",
                  color: "#f9934a",
                }),
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_userinfo_auth_btn1_text },
                  "DMC"
                )
              ),
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_userinfo_auth_btn2 },
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_userinfo_auth_btn1_text },
                  "\u5F85\u8BA4\u8BC1"
                )
              )
            )
          ),
          react_1["default"].createElement(
            react_native_1.View,
            { style: styles.ljn_userinfo_level_area },
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_userinfo_level_row1 },
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_userinfo_level_row1_left },
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_userinfo_level_row1_left_text1 },
                  "Prime 0"
                )
              ),
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_userinfo_level_row1_right },
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_userinfo_level_row1_right_text1 },
                  "\u5347\u7EA7\u8FD8\u9700\u8981\u73B0\u8D27\u4EA4\u6613"
                ),
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_userinfo_level_row1_right_text2 },
                  "10000.00U"
                )
              )
            ),
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_userinfo_level_row2 },
              react_1["default"].createElement(
                react_native_1.Text,
                { style: styles.ljn_userinfo_level_row2_text },
                "HT\u62B5\u626375\u6298\u2022HT\u6301\u5E01\u63D0\u901F"
              )
            )
          ),
          react_1["default"].createElement(
            react_native_1.View,
            { style: styles.ljn_userinfo_detail_func1 },
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
            { style: styles.ljn_userinfo_detail_func2 },
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
          )
        )
      : react_1["default"].createElement(LJNLoading_1["default"], null)
  );
};
exports["default"] = index;
