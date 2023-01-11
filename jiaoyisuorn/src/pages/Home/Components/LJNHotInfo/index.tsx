import { StyleSheet, Text, View, Image, Platform } from "react-native";
import React, { useLayoutEffect, useRef, useState } from "react";
import { px2vw } from "../../../../utils/utils";
import { theme } from "../../../../themes/default/styles";
// android/ios
import { ECharts } from "react-native-echarts-wrapper";
// web
import ReactECharts from "echarts-for-react";

type Props = {};

const option1Init = {
  // center: ["50%", "50%"],
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
    },
  ],
};

const option2Init = {
  // center: ["50%", "50%"],
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
    },
  ],
};

const option3Init = {
  // center: ["50%", "50%"],
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
    },
  ],
};

const index = (props: Props) => {
  // const [option1, setOption1] = useState<any>(option1Init);
  // const [option2, setOption2] = useState<any>(option2Init);
  // const [option3, setOption3] = useState<any>(option3Init);

  let chart1Ref = useRef<any>(null);
  let chart2Ref = useRef<any>(null);
  let chart3Ref = useRef<any>(null);

  useLayoutEffect(() => {
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
  }, []);

  let chart1: any, chart2: any, chart3: any;
  if (Platform.OS === "web") {
    chart1 = <ReactECharts ref={chart1Ref} option={option1Init} />;
    chart2 = <ReactECharts ref={chart2Ref} option={option2Init} />;
    chart3 = <ReactECharts ref={chart3Ref} option={option3Init} />;
  } else {
    chart1 = (
      <ECharts
        ref={chart1Ref}
        option={option1Init}
        backgroundColor="rgba(93, 169, 81, 0.3)"
      />
    );
    chart2 = (
      <ECharts
        ref={chart2Ref}
        option={option2Init}
        backgroundColor="rgba(93, 169, 81, 0.3)"
      />
    );
    chart3 = (
      <ECharts
        ref={chart3Ref}
        option={option3Init}
        backgroundColor="rgba(93, 169, 81, 0.3)"
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
          <View style={styles.ljn_currency_kline_area}>{chart1}</View>
        </View>
        <View style={styles.ljn_hotinfo}>
          <View style={styles.ljn_currency_name_area}>
            <Text style={styles.ljn_currency_name}>BTC/USDT</Text>
            <Text style={styles.ljn_currency_name_float}>-0.07%</Text>
          </View>
          <View style={styles.ljn_currency_price_area}>
            <Text style={styles.ljn_currency_price_title}>16,722.41</Text>
          </View>
          <View style={styles.ljn_currency_kline_area}>
            <View style={styles.ljn_currency_kline_area}>{chart2}</View>
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
          <View style={styles.ljn_currency_kline_area}>
            <View style={styles.ljn_currency_kline_area}>{chart3}</View>
          </View>
        </View>
      </View>
    </View>
  );
};

export default index;

const styles = StyleSheet.create({
  ljn_container: {
    height: px2vw(146),
    backgroundColor: theme.areaBackgroundColor,
    paddingTop: px2vw(5),
    paddingBottom: px2vw(12),
    // paddingLeft: px2vw(17),
    // paddingRight: px2vw(17),
    borderBottomLeftRadius: px2vw(10),
    borderBottomRightRadius: px2vw(10),
    marginBottom: px2vw(10),
  },

  // 标题区域 --------------------start
  ljn_title_area: {
    height: px2vw(30),
    display: "flex",
    justifyContent: "space-between",
    flexDirection: "row",
    borderBottomWidth: px2vw(1),
    borderBottomColor: "#272f3c",
    marginBottom: px2vw(8),
  },
  ljn_title_area_left: {
    flex: 3,
    display: "flex",
    flexDirection: "row",
    paddingLeft: px2vw(17),
  },
  ljn_title_area_left_title_before: {
    display: "flex",
    justifyContent: "center",
    marginRight: px2vw(6),
  },
  ljn_title_area_left_title_before_inner: {
    borderRadius: px2vw(3),
    color: "white",
    fontSize: px2vw(10),
    width: px2vw(30),
    height: px2vw(16),
    textAlign: "center",
    backgroundColor: "#0070e7",
  },
  ljn_title_area_left_title_after: {
    // height: px2vw(20),
    display: "flex",
    justifyContent: "center",
    // alignItems: "center",
  },
  ljn_title_area_left_title_after_inner: {
    color: "white",
    fontSize: px2vw(12),
  },
  ljn_title_area_right: {
    flex: 1,
    display: "flex",
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "flex-end",
    paddingRight: px2vw(17),
  },
  ljn_title_area_right_img: {
    width: px2vw(16),
    height: px2vw(16),
  },

  // --------------------------------------热门信息区域 start
  ljn_hotinfo_area: {
    display: "flex",
    flexDirection: "row",
    paddingLeft: px2vw(10),
    paddingRight: px2vw(10),
  },
  ljn_hotinfo: {
    flex: 1,
    paddingLeft: px2vw(3),
    paddingRight: px2vw(3),
  },
  ljn_currency_name_area: {
    // height: px2vw(14),
    fontSize: px2vw(12),
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
    flexDirection: "row",
    marginBottom: px2vw(8),
  },
  ljn_currency_name: {
    color: "#777f8c",
    marginRight: px2vw(3),
    fontSize: px2vw(12),
  },
  ljn_currency_name_float: {
    color: "#dc6d63",
    fontSize: px2vw(10),
  },
  ljn_currency_price_area: {
    height: px2vw(18),
    marginBottom: px2vw(8),
  },
  ljn_currency_price_title: {
    fontSize: px2vw(14),
    fontWeight: "600",
    color: "white",
    textAlign: "center",
  },
  ljn_currency_kline_area: {
    // width: px2vw(150),
    height: px2vw(30),
    textAlign: "center",
  },
  ljn_currency_kline: {
    color: "#f77f68",
    fontSize: px2vw(14),
  },
  // --------------------------------------热门信息区域 end
});
