"use strict";
exports.__esModule = true;
var echarts_for_react_1 = require("echarts-for-react"); // web
var react_1 = require("react");
var react_native_1 = require("react-native");
var react_native_echarts_wrapper_1 = require("react-native-echarts-wrapper"); // android/ios
var LJNLoading_1 = require("components/LJNLoading");
var hooks_1 = require("hooks");
var styles_1 = require("./styles");
var index = function (props) {
  var styles = hooks_1.useStyles(styles_1.setTheme);
  react_1.useEffect(
    function () {
      option1Init.backgroundColor = styles.ljn_echartsbg.backgroundColor;
      option2Init.backgroundColor = styles.ljn_echartsbg.backgroundColor;
      option3Init.backgroundColor = styles.ljn_echartsbg.backgroundColor;
      setInterval(function () {
        option1Init.series[0].data.shift();
        option1Init.series[0].data.push(Math.trunc(Math.random() * 100));
        option2Init.series[0].data.shift();
        option2Init.series[0].data.push(Math.trunc(Math.random() * 100));
        option3Init.series[0].data.shift();
        option3Init.series[0].data.push(Math.trunc(Math.random() * 100));
        if (react_native_1.Platform.OS === "web") {
          chart1Ref.current &&
            chart1Ref.current.getEchartsInstance().setOption(option1Init);
          chart2Ref.current &&
            chart2Ref.current.getEchartsInstance().setOption(option2Init);
          chart3Ref.current &&
            chart3Ref.current.getEchartsInstance().setOption(option3Init);
        } else {
          chart1Ref.current && chart1Ref.current.setOption(option1Init);
          chart2Ref.current && chart2Ref.current.setOption(option2Init);
          chart3Ref.current && chart3Ref.current.setOption(option3Init);
        }
      }, 2000);
      return function () {
        if (react_native_1.Platform.OS === "web") {
          chart1Ref.current = null;
          chart1Ref.current = null;
          chart1Ref.current = null;
        } else {
          chart1Ref.current = null;
          chart1Ref.current = null;
          chart1Ref.current = null;
        }
      };
    },
    [styles]
  );
  var chart1Ref = react_1.useRef(null);
  var chart2Ref = react_1.useRef(null);
  var chart3Ref = react_1.useRef(null);
  var chart1 = react_1.useRef(null).current,
    chart2 = react_1.useRef(null).current,
    chart3 = react_1.useRef(null).current;
  var _a = react_1.useState(false),
    chartShow = _a[0],
    setChartShow = _a[1];
  if (react_native_1.Platform.OS === "web") {
    chart1 = react_1["default"].createElement(echarts_for_react_1["default"], {
      ref: chart1Ref,
      option: option1Init,
    });
    chart2 = react_1["default"].createElement(echarts_for_react_1["default"], {
      ref: chart2Ref,
      option: option2Init,
    });
    chart3 = react_1["default"].createElement(echarts_for_react_1["default"], {
      ref: chart3Ref,
      option: option3Init,
    });
  } else {
    chart1 = react_1["default"].createElement(
      react_native_echarts_wrapper_1.ECharts,
      {
        canvas: true,
        onLoadEnd: function () {
          setTimeout(function () {
            setChartShow(true);
          }, 400);
        },
        ref: chart1Ref,
        option: option1Init,
      }
    );
    chart2 = react_1["default"].createElement(
      react_native_echarts_wrapper_1.ECharts,
      {
        canvas: true,
        onLoadEnd: function () {
          setTimeout(function () {
            setChartShow(true);
          }, 400);
        },
        ref: chart2Ref,
        option: option2Init,
      }
    );
    chart3 = react_1["default"].createElement(
      react_native_echarts_wrapper_1.ECharts,
      {
        canvas: true,
        onLoadEnd: function () {
          setTimeout(function () {
            setChartShow(true);
          }, 400);
        },
        ref: chart3Ref,
        option: option3Init,
      }
    );
  }
  var _b = react_1.useState(false),
    show = _b[0],
    setShow = _b[1];
  react_1.useEffect(function () {
    // web端默认可以显示
    if (react_native_1.Platform.OS === "web") {
      setChartShow(true);
    }
    var timer = setTimeout(function () {
      setShow(true);
    }, 0);
    return function () {
      chart1 = null;
      chart2 = null;
      chart3 = null;
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
            { style: styles.ljn_title_area },
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_title_area_left },
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_title_area_left_title_before },
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_title_area_left_title_before_inner },
                  "\u70ED\u70B9"
                )
              ),
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_title_area_left_title_after },
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_title_area_left_title_after_inner },
                  "\u679C\u679C\u6295\u7968\u4E0A\u5E01\u6D3B\u52A8\u9879\u76EE\u5165\u9009\u540D\u5355"
                )
              )
            ),
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_title_area_right },
              react_1["default"].createElement(react_native_1.Image, {
                style: styles.ljn_title_area_right_img,
                source: require("assets/images/listicon.png"),
              })
            )
          ),
          react_1["default"].createElement(
            react_native_1.View,
            { style: styles.ljn_hotinfo_area },
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_hotinfo },
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_currency_name_area },
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_currency_name },
                  "BTC/USDT"
                ),
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_currency_name_float },
                  "-0.07%"
                )
              ),
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_currency_price_area },
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_currency_price_title },
                  "16,722.41"
                )
              ),
              !chartShow
                ? react_1["default"].createElement(
                    react_native_1.View,
                    { style: styles.ljn_currency_kline_area },
                    react_1["default"].createElement(
                      LJNLoading_1["default"],
                      null
                    )
                  )
                : null,
              react_1["default"].createElement(
                react_native_1.View,
                {
                  style: react_native_1.StyleSheet.flatten([
                    styles.ljn_currency_kline_area,
                    { top: chartShow ? 0 : 99999, position: "relative" },
                  ]),
                },
                chart1
              )
            ),
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_hotinfo },
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_currency_name_area },
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_currency_name },
                  "BTC/USDT"
                ),
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_currency_name_float },
                  "-0.07%"
                )
              ),
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_currency_price_area },
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_currency_price_title },
                  "16,722.41"
                )
              ),
              !chartShow
                ? react_1["default"].createElement(
                    react_native_1.View,
                    { style: styles.ljn_currency_kline_area },
                    react_1["default"].createElement(
                      LJNLoading_1["default"],
                      null
                    )
                  )
                : null,
              react_1["default"].createElement(
                react_native_1.View,
                {
                  style: react_native_1.StyleSheet.flatten([
                    styles.ljn_currency_kline_area,
                    { top: chartShow ? 0 : 99999, position: "relative" },
                  ]),
                },
                chart2
              )
            ),
            react_1["default"].createElement(
              react_native_1.View,
              { style: styles.ljn_hotinfo },
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_currency_name_area },
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_currency_name },
                  "BTC/USDT"
                ),
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_currency_name_float },
                  "-0.07%"
                )
              ),
              react_1["default"].createElement(
                react_native_1.View,
                { style: styles.ljn_currency_price_area },
                react_1["default"].createElement(
                  react_native_1.Text,
                  { style: styles.ljn_currency_price_title },
                  "16,722.41"
                )
              ),
              !chartShow
                ? react_1["default"].createElement(
                    react_native_1.View,
                    { style: styles.ljn_currency_kline_area },
                    react_1["default"].createElement(
                      LJNLoading_1["default"],
                      null
                    )
                  )
                : null,
              react_1["default"].createElement(
                react_native_1.View,
                {
                  style: react_native_1.StyleSheet.flatten([
                    styles.ljn_currency_kline_area,
                    { top: chartShow ? 0 : 99999, position: "relative" },
                  ]),
                },
                chart3
              )
            )
          )
        )
      : react_1["default"].createElement(LJNLoading_1["default"], null)
  );
};
exports["default"] = index;
var option1Init = {
  backgroundColor: "#18202d",
  grid: {
    left: "0%",
    right: "0%",
    top: "40%",
    bottom: "10%",
  },
  xAxis: {
    show: false,
    axisTick: {
      show: false,
    },
    axisLine: {
      show: false,
    },
    axisLabel: {
      show: false,
    },
    type: "category",
    data: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
  },
  yAxis: {
    show: false,
    axisTick: {
      show: false,
    },
    axisLine: {
      show: false,
    },
    axisLabel: {
      show: false,
    },
    type: "value",
  },
  series: [
    {
      data: [0, 30, 50, 40, 30, 20, 20],
      type: "line",
      smooth: true,
      symbol: "none",
      itemStyle: {
        normal: {
          lineStyle: {
            color: "#bc5e62",
          },
        },
      },
    },
  ],
};
var option2Init = {
  backgroundColor: "#18202d",
  grid: {
    left: "0%",
    right: "0%",
    top: "40%",
    bottom: "10%",
  },
  xAxis: {
    show: false,
    axisTick: {
      show: false,
    },
    axisLine: {
      show: false,
    },
    axisLabel: {
      show: false,
    },
    type: "category",
    data: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
  },
  yAxis: {
    show: false,
    axisTick: {
      show: false,
    },
    axisLine: {
      show: false,
    },
    axisLabel: {
      show: false,
    },
    type: "value",
  },
  series: [
    {
      data: [0, 30, 50, 40, 30, 20, 20],
      type: "line",
      smooth: true,
      symbol: "none",
      itemStyle: {
        normal: {
          lineStyle: {
            color: "#bc5e62",
          },
        },
      },
    },
  ],
};
var option3Init = {
  backgroundColor: "#18202d",
  grid: {
    left: "0%",
    right: "0%",
    top: "40%",
    bottom: "10%",
  },
  xAxis: {
    show: false,
    axisTick: {
      show: false,
    },
    axisLine: {
      show: false,
    },
    axisLabel: {
      show: false,
    },
    type: "category",
    data: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
  },
  yAxis: {
    show: false,
    axisTick: {
      show: false,
    },
    axisLine: {
      show: false,
    },
    axisLabel: {
      show: false,
    },
    type: "value",
  },
  series: [
    {
      data: [0, 30, 50, 40, 30, 20, 20],
      type: "line",
      smooth: true,
      symbol: "none",
      itemStyle: {
        normal: {
          lineStyle: {
            color: "#bc5e62",
          },
        },
      },
    },
  ],
};
