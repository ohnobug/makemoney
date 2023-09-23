"use strict";
exports.__esModule = true;
var react_native_1 = require("react-native");
var react_1 = require("react");
var react_router_native_1 = require("react-router-native");
var hooks_1 = require("../../hooks");
var SystemSlice_1 = require("../../store/SystemSlice");
var hooks_2 = require("../../hooks");
var styles_1 = require("./styles");
var index = function (props) {
  var navigate = react_router_native_1.useNavigate();
  var _a = react_1.useState([
      {
        title: "首页",
        path: "/",
        icon: require("../../assets/images/nav1icon.png"),
      },
      {
        title: "行情",
        path: "/quotation",
        icon: require("../../assets/images/nav2icon.png"),
      },
      {
        title: "交易",
        path: "/transaction",
        icon: require("../../assets/images/nav3icon.png"),
      },
      {
        title: "合约",
        path: "/contract",
        icon: require("../../assets/images/nav4icon.png"),
      },
      {
        title: "资产",
        path: "/assets",
        icon: require("../../assets/images/nav5icon.png"),
      },
      {
        title: "我的",
        path: "/user",
        icon: require("../../assets/images/nav6icon.png"),
      },
    ]),
    tabs = _a[0],
    setTabs = _a[1];
  var dispatch = hooks_2.useAppDispatch();
  var tabbarIndex = hooks_1.useAppSelector(SystemSlice_1.selectTabbarIndex);
  var theme = hooks_1.useAppSelector(SystemSlice_1.selectAppTheme);
  var _b = react_1.useState(styles_1.setTheme(theme)),
    styles = _b[0],
    setStyles = _b[1];
  react_1.useEffect(
    function () {
      setStyles(styles_1.setTheme(theme));
    },
    [theme]
  );
  return react_1["default"].createElement(
    react_native_1.View,
    { style: styles.ljn_tabbar },
    tabs.map(function (item, index) {
      return react_1["default"].createElement(
        react_native_1.TouchableOpacity,
        {
          activeOpacity: 0.6,
          style: styles.ljn_tabbar_item,
          key: index,
          onPress: function () {
            dispatch(SystemSlice_1.setTabbarIndex(index));
            navigate(item.path);
          },
        },
        react_1["default"].createElement(
          react_native_1.View,
          { style: styles.ljn_tabbar_item_img_area },
          react_1["default"].createElement(react_native_1.Image, {
            style: styles.ljn_tabbar_item_img,
            source: item.icon,
          })
        ),
        react_1["default"].createElement(
          react_native_1.View,
          { style: styles.ljn_tabbar_item_title_area },
          react_1["default"].createElement(
            react_native_1.Text,
            {
              style: react_native_1.StyleSheet.flatten([
                styles.ljn_tabbar_item_title,
                index === tabbarIndex
                  ? styles.ljn_tabbar_item_title_active
                  : {},
              ]),
            },
            item.title
          )
        )
      );
    })
  );
};
exports["default"] = index;
