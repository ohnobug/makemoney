import { StyleSheet, Text, View, Image, Platform } from "react-native";
import React, { useEffect, useRef, useState } from "react";
import { ECharts } from "react-native-echarts-wrapper"; // android/ios
import ReactECharts from "echarts-for-react"; // web
import { useAppSelector } from "../../../../hooks";
import { selectTheme } from "../../../../store/SystemSlice";
import { setTheme } from "./styles";
import LJNLoading from "../../../../components/LJNLoading";

type Props = {};
const index = (props: Props) => {
  const theme = useAppSelector(selectTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
    option1Init.backgroundColor = styles.ljn_echartsbg.backgroundColor;
    option2Init.backgroundColor = styles.ljn_echartsbg.backgroundColor;
    option3Init.backgroundColor = styles.ljn_echartsbg.backgroundColor;

    setInterval(() => {
      option1Init.series[0].data.shift();
      option1Init.series[0].data.push(Math.trunc(Math.random() * 100));

      option2Init.series[0].data.shift();
      option2Init.series[0].data.push(Math.trunc(Math.random() * 100));

      option3Init.series[0].data.shift();
      option3Init.series[0].data.push(Math.trunc(Math.random() * 100));

      if (Platform.OS === "web") {
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
    }, 1000);

    return () => {
      if (Platform.OS === "web") {
        chart1Ref.current = null;
        chart1Ref.current = null;
        chart1Ref.current = null;
      } else {
        chart1Ref.current = null;
        chart1Ref.current = null;
        chart1Ref.current = null;
      }
    };
  }, [theme]);

  let chart1Ref = useRef<any>(null);
  let chart2Ref = useRef<any>(null);
  let chart3Ref = useRef<any>(null);

  let chart1 = useRef<any>(null).current,
    chart2 = useRef<any>(null).current,
    chart3 = useRef<any>(null).current;
  let [chartShow, setChartShow] = useState(false);
  if (Platform.OS === "web") {
    chart1 = <ReactECharts ref={chart1Ref} option={option1Init} />;
    chart2 = <ReactECharts ref={chart2Ref} option={option2Init} />;
    chart3 = <ReactECharts ref={chart3Ref} option={option3Init} />;
  } else {
    chart1 = (
      <ECharts
        canvas={true}
        onLoadEnd={() => {
          setTimeout(() => {
            setChartShow(true);
          }, 400);
        }}
        ref={chart1Ref}
        option={option1Init}
      />
    );
    chart2 = (
      <ECharts
        canvas={true}
        onLoadEnd={() => {
          setTimeout(() => {
            setChartShow(true);
          }, 400);
        }}
        ref={chart2Ref}
        option={option2Init}
      />
    );
    chart3 = (
      <ECharts
        canvas={true}
        onLoadEnd={() => {
          setTimeout(() => {
            setChartShow(true);
          }, 400);
        }}
        ref={chart3Ref}
        option={option3Init}
      />
    );
  }

  let [show, setShow] = useState(false);
  useEffect(() => {
    // web端默认可以显示
    if (Platform.OS === "web") {
      setChartShow(true);
    }

    let timer = setTimeout(() => {
      setShow(true);
    }, 0);

    return () => {
      chart1 = null;
      chart2 = null;
      chart3 = null;
      clearTimeout(timer);
    };
  }, []);

  return (
    <View style={styles.ljn_container}>
      {show ? (
        <>
          <View style={styles.ljn_title_area}>
            <View style={styles.ljn_title_area_left}>
              <View style={styles.ljn_title_area_left_title_before}>
                <Text style={styles.ljn_title_area_left_title_before_inner}>
                  热点
                </Text>
              </View>
              <View style={styles.ljn_title_area_left_title_after}>
                <Text style={styles.ljn_title_area_left_title_after_inner}>
                  果果投票上币活动项目入选名单
                </Text>
              </View>
            </View>
            <View style={styles.ljn_title_area_right}>
              <Image
                style={styles.ljn_title_area_right_img}
                source={require("../../../../assets/images/listicon.png")}
              />
            </View>
          </View>
          <View style={styles.ljn_hotinfo_area}>
            <View style={styles.ljn_hotinfo}>
              <View style={styles.ljn_currency_name_area}>
                <Text style={styles.ljn_currency_name}>BTC/USDT</Text>
                <Text style={styles.ljn_currency_name_float}>-0.07%</Text>
              </View>
              <View style={styles.ljn_currency_price_area}>
                <Text style={styles.ljn_currency_price_title}>16,722.41</Text>
              </View>

              {!chartShow ? (
                <View style={styles.ljn_currency_kline_area}>
                  <LJNLoading />
                </View>
              ) : null}

              <View
                style={StyleSheet.flatten([
                  styles.ljn_currency_kline_area,
                  { top: chartShow ? 0 : 99999, position: "relative" },
                ])}
              >
                {chart1}
              </View>
            </View>
            <View style={styles.ljn_hotinfo}>
              <View style={styles.ljn_currency_name_area}>
                <Text style={styles.ljn_currency_name}>BTC/USDT</Text>
                <Text style={styles.ljn_currency_name_float}>-0.07%</Text>
              </View>
              <View style={styles.ljn_currency_price_area}>
                <Text style={styles.ljn_currency_price_title}>16,722.41</Text>
              </View>

              {!chartShow ? (
                <View style={styles.ljn_currency_kline_area}>
                  <LJNLoading />
                </View>
              ) : null}

              <View
                style={StyleSheet.flatten([
                  styles.ljn_currency_kline_area,
                  { top: chartShow ? 0 : 99999, position: "relative" },
                ])}
              >
                {chart2}
              </View>
            </View>

            <View style={styles.ljn_hotinfo}>
              <View style={styles.ljn_currency_name_area}>
                <Text style={styles.ljn_currency_name}>BTC/USDT</Text>
                <Text style={styles.ljn_currency_name_float}>-0.07%</Text>
              </View>
              <View style={styles.ljn_currency_price_area}>
                <Text style={styles.ljn_currency_price_title}>16,722.41</Text>
              </View>

              {!chartShow ? (
                <View style={styles.ljn_currency_kline_area}>
                  <LJNLoading />
                </View>
              ) : null}

              <View
                style={StyleSheet.flatten([
                  styles.ljn_currency_kline_area,
                  { top: chartShow ? 0 : 99999, position: "relative" },
                ])}
              >
                {chart3}
              </View>
            </View>
          </View>
        </>
      ) : (
        <LJNLoading />
      )}
    </View>
  );
};

export default index;

const option1Init = {
  backgroundColor: "#18202d",
  grid: {
    left: "0%",
    right: "0%",
    top: "40%",
    bottom: "10%",
  },
  xAxis: {
    show: false, //不显示坐标轴线、坐标轴刻度线和坐标轴上的文字
    axisTick: {
      show: false, //不显示坐标轴刻度线
    },
    axisLine: {
      show: false, //不显示坐标轴线
    },
    axisLabel: {
      show: false, //不显示坐标轴上的文字
    },
    type: "category",
    data: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
  },
  yAxis: {
    show: false, //不显示坐标轴线、坐标轴刻度线和坐标轴上的文字
    axisTick: {
      show: false, //不显示坐标轴刻度线
    },
    axisLine: {
      show: false, //不显示坐标轴线
    },
    axisLabel: {
      show: false, //不显示坐标轴上的文字
    },
    type: "value",
  },
  series: [
    {
      data: [0, 30, 50, 40, 30, 20, 20],
      type: "line",
      smooth: true,
      symbol: "none", //去掉折线上的小圆点
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

const option2Init = {
  backgroundColor: "#18202d",
  grid: {
    left: "0%",
    right: "0%",
    top: "40%",
    bottom: "10%",
  },
  xAxis: {
    show: false, //不显示坐标轴线、坐标轴刻度线和坐标轴上的文字
    axisTick: {
      show: false, //不显示坐标轴刻度线
    },
    axisLine: {
      show: false, //不显示坐标轴线
    },
    axisLabel: {
      show: false, //不显示坐标轴上的文字
    },
    type: "category",
    data: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
  },
  yAxis: {
    show: false, //不显示坐标轴线、坐标轴刻度线和坐标轴上的文字
    axisTick: {
      show: false, //不显示坐标轴刻度线
    },
    axisLine: {
      show: false, //不显示坐标轴线
    },
    axisLabel: {
      show: false, //不显示坐标轴上的文字
    },
    type: "value",
  },
  series: [
    {
      data: [0, 30, 50, 40, 30, 20, 20],
      type: "line",
      smooth: true,
      symbol: "none", //去掉折线上的小圆点
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

const option3Init = {
  backgroundColor: "#18202d",
  grid: {
    left: "0%",
    right: "0%",
    top: "40%",
    bottom: "10%",
  },
  xAxis: {
    show: false, //不显示坐标轴线、坐标轴刻度线和坐标轴上的文字
    axisTick: {
      show: false, //不显示坐标轴刻度线
    },
    axisLine: {
      show: false, //不显示坐标轴线
    },
    axisLabel: {
      show: false, //不显示坐标轴上的文字
    },
    type: "category",
    data: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
  },
  yAxis: {
    show: false, //不显示坐标轴线、坐标轴刻度线和坐标轴上的文字
    axisTick: {
      show: false, //不显示坐标轴刻度线
    },
    axisLine: {
      show: false, //不显示坐标轴线
    },
    axisLabel: {
      show: false, //不显示坐标轴上的文字
    },
    type: "value",
  },
  series: [
    {
      data: [0, 30, 50, 40, 30, 20, 20],
      type: "line",
      smooth: true,
      symbol: "none", //去掉折线上的小圆点
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
