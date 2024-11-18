"use strict";
var __spreadArrays =
  (this && this.__spreadArrays) ||
  function () {
    for (var s = 0, i = 0, il = arguments.length; i < il; i++)
      s += arguments[i].length;
    for (var r = Array(s), k = 0, i = 0; i < il; i++)
      for (var a = arguments[i], j = 0, jl = a.length; j < jl; j++, k++)
        r[k] = a[j];
    return r;
  };
exports.__esModule = true;
/// <reference path="../../index.d.ts" />
var react_1 = require("react");
var react_native_1 = require("react-native");
var bus_1 = require("bus");
var LJNHeaderScroll_1 = require("components/LJNHeaderScroll");
var LJNIcon_1 = require("components/LJNIcon");
var LJNLoading_1 = require("components/LJNLoading");
var hooks_1 = require("hooks");
var index_1 = require("library/react-native-web-swiper/src/index");
var utils_1 = require("utils/utils");
var styles_1 = require("./styles");
// 接收父组件ref
var bigScrollView;
bus_1["default"].on("getBigScrollView", function (e) {
  bigScrollView = e;
});
var index = function (props) {
  var styles = hooks_1.useStyles(styles_1.setTheme);
  var _a = react_1.useState(initData2),
    list = _a[0],
    setList = _a[1];
  // 滑动列表
  var myswiper = react_1.useRef(null);
  // 顶部滑动
  var myswiperHeader = react_1.useRef(null);
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
  react_1.useEffect(function () {
    var timerMock = setInterval(function () {
      var newList = list.map(function (titem) {
        var nlist = titem.list.map(function (item) {
          item.price =
            Math.round(
              (Math.trunc(Math.random() * 1000) +
                Math.trunc(Math.random() * 10000) / 10000) *
                10000
            ) / 10000;
          var float = Math.random() * 100;
          var sign = Math.random() > 0.5;
          if (sign) {
            item.float = "-" + float.toFixed(2) + "%";
          } else {
            item.float = "+" + float.toFixed(2) + "%";
          }
          return item;
        });
        titem.list = __spreadArrays(nlist);
        return titem;
      });
      setList(__spreadArrays(newList));
    }, 1000);
    return function () {
      // 如果不加该行，可能会操作已经被销毁的View
      bigScrollView = null;
      clearInterval(timerMock);
    };
  }, []);
  var fd = react_1.useCallback(
    utils_1.debounce(function () {
      bigScrollView === null || bigScrollView === void 0
        ? void 0
        : bigScrollView.setNativeProps({
            scrollEnabled: true,
          });
    }, 500),
    []
  );
  return react_1["default"].createElement(
    react_native_1.View,
    { style: styles.ljn_container },
    show
      ? react_1["default"].createElement(
          react_1["default"].Fragment,
          null,
          react_1["default"].createElement(LJNHeaderScroll_1["default"], {
            ref: myswiperHeader,
            list: list.map(function (item) {
              return item.tabname;
            }),
            onChange: function (n) {
              var _a;
              (_a = myswiper.current) === null || _a === void 0
                ? void 0
                : _a.goTo(n);
            },
          }),
          react_1["default"].createElement(
            react_native_1.View,
            { style: styles.ljn_list_area },
            react_1["default"].createElement(
              index_1["default"],
              {
                ref: myswiper,
                loop: false,
                vertical: false,
                minDistanceToCapture: 10,
                minDistanceForAction: 0.1,
                onAnimationStart: function () {
                  bigScrollView === null || bigScrollView === void 0
                    ? void 0
                    : bigScrollView.setNativeProps({
                        scrollEnabled: false,
                      });
                },
                onAnimationEnd: function () {
                  fd();
                },
                onIndexChanged: function (n) {
                  myswiperHeader.current.goTo(n);
                },
                springConfig: {
                  stiffness: 100,
                  damping: 100,
                  mass: 0.2,
                },
                controlsEnabled: false,
                controlsProps: {
                  prevPos: false,
                  nextPos: false,
                },
              },
              list.map(function (item1, index1) {
                return react_1["default"].createElement(SwiperSlice, {
                  key: index1,
                  list: item1.list,
                });
              })
            )
          )
        )
      : react_1["default"].createElement(LJNLoading_1["default"], null)
  );
};
exports["default"] = index;
var SwiperSlice = function (_a) {
  var _b = _a.list,
    list = _b === void 0 ? [] : _b;
  var styles = hooks_1.useStyles(styles_1.setTheme);
  return react_1["default"].createElement(
    react_native_1.View,
    { style: styles.ljn_list },
    react_1["default"].createElement(
      react_native_1.View,
      { style: styles.ljn_list_title_area },
      react_1["default"].createElement(
        react_native_1.View,
        { style: styles.ljn_list_title1 },
        react_1["default"].createElement(
          react_native_1.Text,
          { style: styles.ljn_list_title_inner },
          "\u540D\u79F0"
        )
      ),
      react_1["default"].createElement(
        react_native_1.View,
        { style: styles.ljn_list_title2 },
        react_1["default"].createElement(
          react_native_1.Text,
          { style: styles.ljn_list_title_inner },
          "\u6700\u65B0\u4EF7\u683C"
        )
      ),
      react_1["default"].createElement(
        react_native_1.View,
        { style: styles.ljn_list_title3 },
        react_1["default"].createElement(
          react_native_1.Text,
          { style: styles.ljn_list_title_inner },
          "\u6DA8\u8DCC\u5E45"
        )
      )
    ),
    react_1["default"].createElement(
      react_native_1.View,
      { style: styles.ljn_list_inner },
      list.map(function (item, index) {
        return react_1["default"].createElement(
          react_native_1.View,
          { style: styles.ljn_list_item, key: index },
          react_1["default"].createElement(
            react_native_1.View,
            { style: styles.ljn_list_item_column1 },
            react_1["default"].createElement(react_native_1.Image, {
              style: styles.ljn_list_item_icon,
              source: item.icon,
            }),
            item.name
          ),
          react_1["default"].createElement(
            react_native_1.View,
            { style: styles.ljn_list_item_column2 },
            react_1["default"].createElement(
              react_native_1.Text,
              { style: styles.ljn_list_item_column2_text },
              item.price
            )
          ),
          react_1["default"].createElement(
            react_native_1.View,
            { style: styles.ljn_list_item_column3 },
            item.float.indexOf("-") === 0
              ? react_1["default"].createElement(
                  react_native_1.View,
                  { style: styles.ljn_list_item_float_btn_down },
                  react_1["default"].createElement(
                    react_native_1.Text,
                    { style: styles.ljn_list_item_float_btn_text },
                    item.float
                  )
                )
              : react_1["default"].createElement(
                  react_native_1.View,
                  { style: styles.ljn_list_item_float_btn_up },
                  react_1["default"].createElement(
                    react_native_1.Text,
                    { style: styles.ljn_list_item_float_btn_text },
                    item.float
                  )
                )
          )
        );
      })
    ),
    react_1["default"].createElement(
      react_native_1.View,
      { style: styles.ljn_showmore },
      react_1["default"].createElement(
        react_native_1.Text,
        { style: styles.ljn_showmore_text },
        "\u67E5\u770B\u66F4\u591A"
      ),
      react_1["default"].createElement(LJNIcon_1["default"], {
        title: "jinrujiantouxiao",
        size: 10,
      })
    )
  );
};
// 标题
var CoinName = function (_a) {
  var name1 = _a.name1,
    name2 = _a.name2;
  var styles = hooks_1.useStyles(styles_1.setTheme);
  return react_1["default"].createElement(
    react_native_1.View,
    { style: styles.ljn_list_item_name },
    react_1["default"].createElement(
      react_native_1.Text,
      { style: styles.ljn_list_item_name1 },
      name1
    ),
    react_1["default"].createElement(
      react_native_1.Text,
      { style: styles.ljn_list_item_name2 },
      "/"
    ),
    react_1["default"].createElement(
      react_native_1.Text,
      { style: styles.ljn_list_item_name3 },
      name2
    )
  );
};
var img = require("assets/images/nav1icon.png");
var initData = [
  {
    key: "1",
    icon: img,
    name: react_1["default"].createElement(CoinName, {
      name1: "HKT",
      name2: "USDT",
    }),
    price: 5.3251,
    float: "+0.91%",
  },
  {
    key: "2",
    icon: img,
    name: react_1["default"].createElement(CoinName, {
      name1: "TRX",
      name2: "USDT",
    }),
    price: 0.055375,
    float: "+0.04%",
  },
  {
    key: "3",
    icon: img,
    name: react_1["default"].createElement(CoinName, {
      name1: "PI",
      name2: "USDT",
    }),
    price: 79.498777,
    float: "-20.89%",
  },
  {
    key: "4",
    icon: img,
    name: react_1["default"].createElement(CoinName, {
      name1: "FIL",
      name2: "USDT",
    }),
    price: 3.2908,
    float: "+4.92%",
  },
  {
    key: "5",
    icon: img,
    name: react_1["default"].createElement(CoinName, {
      name1: "ETH",
      name2: "USDT",
    }),
    price: 1248.23,
    float: "+3.00%",
  },
  {
    key: "6",
    icon: img,
    name: react_1["default"].createElement(CoinName, {
      name1: "SOL",
      name2: "USDT",
    }),
    price: 13.7589,
    float: "+5.20%",
  },
  {
    key: "7",
    icon: img,
    name: react_1["default"].createElement(CoinName, {
      name1: "BTC",
      name2: "USDT",
    }),
    price: 16854.3,
    float: "+1.06%",
  },
  {
    key: "8",
    icon: img,
    name: react_1["default"].createElement(CoinName, {
      name1: "ETC",
      name2: "USDT",
    }),
    price: 17.619,
    float: "+10.70%",
  },
  {
    key: "9",
    icon: img,
    name: react_1["default"].createElement(CoinName, {
      name1: "LTC",
      name2: "USDT",
    }),
    price: 76.62,
    float: "+2.62%",
  },
  {
    key: "10",
    icon: img,
    name: react_1["default"].createElement(CoinName, {
      name1: "OP",
      name2: "USDT",
    }),
    price: 1.0177,
    float: "+4.60%",
  },
];
var initData2 = [
  { tabname: "自选", list: initData },
  { tabname: "热榜", list: initData },
  { tabname: "涨幅榜", list: initData },
  { tabname: "新币榜", list: initData },
  { tabname: "成交额榜", list: initData },
];
