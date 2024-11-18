"use strict";
exports.__esModule = true;
var react_1 = require("react");
var react_native_1 = require("react-native");
var LJNLoading_1 = require("components/LJNLoading");
var hooks_1 = require("hooks");
var styles_1 = require("./styles");
var react_router_native_1 = require("react-router-native");
var index = function (props) {
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
      {
        icon: require("assets/images/nav6icon.png"),
        title: "社区",
        path: "/gallery",
      },
      {
        icon: require("assets/images/nav7icon.png"),
        title: "HT专区",
        path: "/",
      },
      {
        icon: require("assets/images/nav8icon.png"),
        title: "福利中心",
        path: "/",
      },
      {
        icon: require("assets/images/nav9icon.png"),
        title: "邀请返佣",
        path: "/",
      },
      {
        icon: require("assets/images/nav10icon.png"),
        title: "PI交易赛",
        path: "/",
      },
    ]),
    list = _a[0],
    setList = _a[1];
  var styles = hooks_1.useStyles(styles_1.setTheme);
  var _b = react_1.useState(true),
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
  var navigate = react_router_native_1.useNavigate();
  return react_1["default"].createElement(
    react_native_1.View,
    { style: styles.ljn_list_area },
    show
      ? list.map(function (item, index) {
          return react_1["default"].createElement(
            react_native_1.View,
            {
              style: styles.ljn_list_item,
              key: index,
              onTouchEnd: function () {
                console.log(item.path);
                navigate(item.path);
              },
            },
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
      : react_1["default"].createElement(LJNLoading_1["default"], null)
  );
};
exports["default"] = index;
