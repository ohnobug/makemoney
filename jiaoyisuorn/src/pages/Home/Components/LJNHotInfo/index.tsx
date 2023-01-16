import { StyleSheet, Text, View, Image, Platform } from "react-native";
import React, { useEffect, useLayoutEffect, useRef, useState } from "react";
import { ECharts } from "react-native-echarts-wrapper"; // android/ios
import ReactECharts from "echarts-for-react"; // web
import { useAppSelector } from "../../../../hooks";
import { selectTheme } from "../../../../store/SystemSlice";
import { setTheme } from "./styles";

type Props = {};
const index = (props: Props) => {
  const theme = useAppSelector(selectTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));

  let chart1Ref = useRef<any>(null);
  let chart2Ref = useRef<any>(null);
  let chart3Ref = useRef<any>(null);

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

  let chart1: any, chart2: any, chart3: any;
  const [show1, setShow1] = useState(Platform.OS === "web" ? true : false);
  const [show2, setShow2] = useState(Platform.OS === "web" ? true : false);
  const [show3, setShow3] = useState(Platform.OS === "web" ? true : false);

  if (Platform.OS === "web") {
    chart1 = <ReactECharts ref={chart1Ref} option={option1Init} />;
    chart2 = <ReactECharts ref={chart2Ref} option={option2Init} />;
    chart3 = <ReactECharts ref={chart3Ref} option={option3Init} />;
  } else {
    chart1 = (
      <ECharts
        ref={chart1Ref}
        option={option1Init}
        onLoadEnd={() => {
          setTimeout(() => {
            setShow1(true);
          }, 300);
        }}
      />
    );
    chart2 = (
      <ECharts
        canvas={true}
        ref={chart2Ref}
        option={option2Init}
        onLoadEnd={() => {
          setTimeout(() => {
            setShow2(true);
          }, 300);
        }}
      />
    );
    chart3 = (
      <ECharts
        canvas={true}
        ref={chart3Ref}
        option={option3Init}
        onLoadEnd={() => {
          setTimeout(() => {
            setShow3(true);
          }, 300);
        }}
      />
    );
  }

  return (
    <View style={styles.ljn_container}>
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
          <View
            style={StyleSheet.flatten([
              styles.ljn_currency_kline_area,
              { top: show1 ? 0 : 999, position: "relative" },
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
          <View
            style={StyleSheet.flatten([
              styles.ljn_currency_kline_area,
              { top: show2 ? 0 : 999, position: "relative" },
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
          <View
            style={StyleSheet.flatten([
              styles.ljn_currency_kline_area,
              { top: show3 ? 0 : 999, position: "relative" },
            ])}
          >
            {chart3}
          </View>
        </View>
      </View>
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
