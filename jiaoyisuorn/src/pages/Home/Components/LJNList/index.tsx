/// <reference path="../../index.d.ts" />

import { StyleSheet, View, Text, Image } from "react-native";
import React, { useCallback, useEffect, useRef, useState } from "react";
import { debounce, px2vw } from "../../../../utils/utils";
import { theme } from "../../../../themes/default/styles";
import Swiper from "../../../../library/react-native-web-swiper/src/index";
import LJNHeaderScroll from "./Components/LJNHeaderScroll";
import emitter from "../../../../bus";

// 接收父组件ref
let bigScrollView: any;
emitter.on("getBigScrollView", (e) => {
  bigScrollView = e;
});

type Props = {};
const index = (props: Props) => {
  const [list, setList] = useState(initData2);

  // 滑动列表
  let myswiper = useRef<any>(null);

  // 顶部滑动
  let myswiperHeader = useRef<any>(null);

  useEffect(() => {
    setInterval(() => {
      let newList = list.map((titem) => {
        let nlist = titem.list.map((item) => {
          item.price =
            Math.round(
              (Math.trunc(Math.random() * 1000) +
                Math.trunc(Math.random() * 10000) / 10000) *
                10000
            ) / 10000;
          let float: number = Math.random() * 100;
          let sign = Math.random() > 0.5;
          if (sign) {
            item.float = "-" + float.toFixed(2) + "%";
          } else {
            item.float = "+" + float.toFixed(2) + "%";
          }
          return item;
        });

        titem.list = [...nlist];
        return titem;
      });
      setList([...newList]);
    }, 2000);
  }, []);

  const fd = useCallback(
    debounce(() => {
      console.log("允许大屏幕滚动");
      bigScrollView?.setNativeProps({
        scrollEnabled: true,
      });
    }, 500),
    []
  );

  return (
    <View style={styles.ljn_container}>
      {/* tabs */}
      <LJNHeaderScroll
        ref={myswiperHeader}
        list={list.map((item) => item.tabname)}
        onChange={(n: number) => {
          myswiper.current.goTo(n);
        }}
      />

      {/* 列表区域 可以左右滑动 */}
      <View style={styles.ljn_list_area}>
        <Swiper
          ref={myswiper}
          loop={false}
          vertical={false}
          minDistanceToCapture={10}
          minDistanceForAction={0.1}
          onAnimationStart={() => {
            bigScrollView?.setNativeProps({
              scrollEnabled: false,
            });
          }}
          onAnimationEnd={() => {
            fd();
          }}
          onIndexChanged={(n: number) => {
            myswiperHeader.current.goTo(n);
          }}
          springConfig={{
            stiffness: 100,
            damping: 100,
            mass: 0.3,
          }}
          controlsEnabled={false}
          controlsProps={{
            prevPos: false,
            nextPos: false,
          }}
        >
          {list.map((item1, index1) => {
            return <SwiperSlice key={index1} list={item1.list} />;
          })}
        </Swiper>
      </View>
    </View>
  );
};

export default index;

interface ISwiperSliceProps {
  index?: number;
  activeIndex?: number;
  list?: IListItem[];
}
const SwiperSlice = ({ list = [] }: ISwiperSliceProps) => {
  return (
    <View style={styles.ljn_list}>
      {/* 列表标题 */}
      <View style={styles.ljn_list_title_area}>
        <View style={styles.ljn_list_title1}>
          <Text style={styles.ljn_list_title_inner}>名称</Text>
        </View>
        <View style={styles.ljn_list_title2}>
          <Text style={styles.ljn_list_title_inner}>最新价格</Text>
        </View>
        <View style={styles.ljn_list_title3}>
          <Text style={styles.ljn_list_title_inner}>涨跌幅</Text>
        </View>
      </View>

      {/* 列表 */}
      <View style={styles.ljn_list_inner}>
        {list.map((item, index) => {
          return (
            <View style={styles.ljn_list_item} key={index}>
              <View style={styles.ljn_list_item_column1}>
                <Image style={styles.ljn_list_item_icon} source={item.icon} />
                {item.name}
              </View>
              <View style={styles.ljn_list_item_column2}>
                <Text style={styles.ljn_list_item_column2_text}>
                  {item.price}
                </Text>
              </View>
              <View style={styles.ljn_list_item_column3}>
                {item.float.indexOf("-") === 0 ? (
                  <View style={styles.ljn_list_item_float_btn_down}>
                    <Text style={styles.ljn_list_item_float_btn_text}>
                      {item.float}
                    </Text>
                  </View>
                ) : (
                  <View style={styles.ljn_list_item_float_btn_up}>
                    <Text style={styles.ljn_list_item_float_btn_text}>
                      {item.float}
                    </Text>
                  </View>
                )}
              </View>
            </View>
          );
        })}
      </View>

      {/* 查看更多 */}
      <View style={styles.ljn_showmore}>
        <Text style={styles.ljn_showmore_text}>查看更多</Text>
        <Image
          style={styles.ljn_showmore_icon}
          source={require("../../../../assets/images/arrow_right.png")}
        />
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  ljn_container: {
    height: px2vw(570),
    backgroundColor: theme.areaBackgroundColor,
    borderRadius: px2vw(10),
    marginBottom: px2vw(10),
    display: "flex",
    flexDirection: "column",
  },

  // ----------------------------------列表 start
  ljn_list_area: {
    display: "flex",
    flex: 1,
    // backgroundColor: "blue",
  },

  // -------------------- 标题 start
  ljn_list_title_area: {
    display: "flex",
    flexDirection: "row",
    marginBottom: px2vw(5),
    minHeight: px2vw(30),
    marginTop: px2vw(5),
    // backgroundColor: "blue",
    flex: 0,
  },
  ljn_list_title1: {
    flex: 1.5,
    display: "flex",
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "flex-start",
  },
  ljn_list_title2: {
    flex: 1,
    display: "flex",
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
  },
  ljn_list_title3: {
    flex: 1,
    display: "flex",
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "flex-end",
  },
  ljn_list_title_inner: {
    fontSize: px2vw(14),
    color: "#707589",
  },
  // -------------------- 标题 end

  ljn_list: {
    display: "flex",
    flex: 1,
    flexDirection: "column",
    paddingLeft: px2vw(12),
    paddingRight: px2vw(12),
    // backgroundColor: "red",
  },
  ljn_list_inner: {
    flex: 1,
  },

  ljn_list_item: {
    display: "flex",
    flexDirection: "row",
    height: px2vw(30),
    marginBottom: px2vw(15),
    backgroundColor: "#18202d",
  },
  ljn_list_item_column1: {
    flex: 1.5,
    display: "flex",
    flexDirection: "row",
    justifyContent: "flex-start",
    alignItems: "center",
  },
  ljn_list_item_column2: {
    flex: 1,
    display: "flex",
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "flex-end",
    paddingRight: px2vw(32),
  },
  ljn_list_item_column2_text: {
    color: "white",
    fontSize: px2vw(14),
  },
  ljn_list_item_column3: {
    flex: 1,
    display: "flex",
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "flex-end",
    // backgroundColor: "yellow",
  },
  ljn_list_item_icon: {
    width: px2vw(25),
    height: px2vw(25),
  },
  ljn_list_item_name: {
    display: "flex",
    flexDirection: "row",
    alignItems: "center",
    marginLeft: px2vw(6),
  },
  ljn_list_item_name1: {
    color: "white",
    fontSize: px2vw(14),
    fontWeight: "600",
  },
  ljn_list_item_name2: {
    color: "#434b58",
    fontSize: px2vw(12),
    marginLeft: px2vw(3),
  },
  ljn_list_item_name3: {
    color: "#434b58",
    fontSize: px2vw(10),
  },
  ljn_list_item_float_btn_up: {
    height: px2vw(30),
    width: px2vw(70),
    backgroundColor: "#11b394",
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
    borderRadius: px2vw(4),
  },
  ljn_list_item_float_btn_down: {
    height: px2vw(30),
    width: px2vw(70),
    backgroundColor: "#dc291b",
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
    borderRadius: px2vw(4),
  },
  ljn_list_item_float_btn_text: {
    color: "white",
  },
  // ---------------------------------- 列表end

  ljn_showmore: {
    flex: 1,
    maxHeight: px2vw(50),
    display: "flex",
    flexDirection: "row",
    justifyContent: "center",
    alignItems: "center",
    // backgroundColor: "red",
  },
  ljn_showmore_text: {
    color: "#707589",
    fontSize: px2vw(12),
  },
  ljn_showmore_icon: {
    marginLeft: px2vw(5),
    width: px2vw(15),
    height: px2vw(15),
  },
});

const img = require("../../../../assets/images/nav1icon.png");

const initData = [
  {
    key: "1",
    icon: img,
    name: (
      <View style={styles.ljn_list_item_name}>
        <Text style={styles.ljn_list_item_name1}>HT</Text>
        <Text style={styles.ljn_list_item_name2}>/</Text>
        <Text style={styles.ljn_list_item_name3}>USDT</Text>
      </View>
    ),
    price: 5.3251,
    float: "+0.91%",
  },
  {
    key: "2",
    icon: img,
    name: (
      <View style={styles.ljn_list_item_name}>
        <Text style={styles.ljn_list_item_name1}>TRX</Text>
        <Text style={styles.ljn_list_item_name2}>/</Text>
        <Text style={styles.ljn_list_item_name3}>USDT</Text>
      </View>
    ),
    price: 0.055375,
    float: "+0.04%",
  },
  {
    key: "3",
    icon: img,
    name: (
      <View style={styles.ljn_list_item_name}>
        <Text style={styles.ljn_list_item_name1}>PI</Text>
        <Text style={styles.ljn_list_item_name2}>/</Text>
        <Text style={styles.ljn_list_item_name3}>USDT</Text>
      </View>
    ),
    price: 79.498777,
    float: "-20.89%",
  },
  {
    key: "4",
    icon: img,
    name: (
      <View style={styles.ljn_list_item_name}>
        <Text style={styles.ljn_list_item_name1}>FIL</Text>
        <Text style={styles.ljn_list_item_name2}>/</Text>
        <Text style={styles.ljn_list_item_name3}>USDT</Text>
      </View>
    ),
    price: 3.2908,
    float: "+4.92%",
  },
  {
    key: "5",
    icon: img,
    name: (
      <View style={styles.ljn_list_item_name}>
        <Text style={styles.ljn_list_item_name1}>ETH</Text>
        <Text style={styles.ljn_list_item_name2}>/</Text>
        <Text style={styles.ljn_list_item_name3}>USDT</Text>
      </View>
    ),
    price: 1248.23,
    float: "+3.00%",
  },
  {
    key: "6",
    icon: img,
    name: (
      <View style={styles.ljn_list_item_name}>
        <Text style={styles.ljn_list_item_name1}>SOL</Text>
        <Text style={styles.ljn_list_item_name2}>/</Text>
        <Text style={styles.ljn_list_item_name3}>USDT</Text>
      </View>
    ),
    price: 13.7589,
    float: "+5.20%",
  },
  {
    key: "7",
    icon: img,
    name: (
      <View style={styles.ljn_list_item_name}>
        <Text style={styles.ljn_list_item_name1}>BTC</Text>
        <Text style={styles.ljn_list_item_name2}>/</Text>
        <Text style={styles.ljn_list_item_name3}>USDT</Text>
      </View>
    ),
    price: 16854.3,
    float: "+1.06%",
  },
  {
    key: "8",
    icon: img,
    name: (
      <View style={styles.ljn_list_item_name}>
        <Text style={styles.ljn_list_item_name1}>ETC</Text>
        <Text style={styles.ljn_list_item_name2}>/</Text>
        <Text style={styles.ljn_list_item_name3}>USDT</Text>
      </View>
    ),
    price: 17.619,
    float: "+10.70%",
  },
  {
    key: "9",
    icon: img,
    name: (
      <View style={styles.ljn_list_item_name}>
        <Text style={styles.ljn_list_item_name1}>LTC</Text>
        <Text style={styles.ljn_list_item_name2}>/</Text>
        <Text style={styles.ljn_list_item_name3}>USDT</Text>
      </View>
    ),
    price: 76.62,
    float: "+2.62%",
  },
  {
    key: "10",
    icon: img,
    name: (
      <View style={styles.ljn_list_item_name}>
        <Text style={styles.ljn_list_item_name1}>OP</Text>
        <Text style={styles.ljn_list_item_name2}>/</Text>
        <Text style={styles.ljn_list_item_name3}>USDT</Text>
      </View>
    ),
    price: 1.0177,
    float: "+4.60%",
  },
];

const initData2: Array<IList> = [
  { tabname: "自选", list: initData },
  { tabname: "热榜", list: initData },
  { tabname: "涨幅榜", list: initData },
  { tabname: "新币榜", list: initData },
  { tabname: "成交额榜", list: initData },
  // { tabname: "跌幅榜", list: initData },
  // { tabname: "自选", list: initData },
  // { tabname: "热榜", list: initData },
  // { tabname: "涨幅榜", list: initData },
  // { tabname: "新币榜", list: initData },
  // { tabname: "成交额榜", list: initData },
  // { tabname: "跌幅榜", list: initData },
];
