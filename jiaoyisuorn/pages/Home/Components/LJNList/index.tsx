import {
  StyleSheet,
  ScrollView,
  View,
  Text,
  Image,
  LayoutRectangle,
} from "react-native";
import React, { useLayoutEffect, useReducer, useRef, useState } from "react";
import { px2vw } from "../../../../utils/utils";
import { theme } from "../../../../themes/default/styles";

type Props = {};

interface IListItem {
  key: string;
  icon: any;
  name: JSX.Element;
  price: number;
  float: string;
}

type IInitState = Array<{
  title: string;
  layout?: LayoutRectangle | null;
}>;

const initState: IInitState = [
  { title: "自选", layout: null },
  { title: "热榜", layout: null },
  { title: "涨幅榜", layout: null },
  { title: "新币榜", layout: null },
  { title: "成交额榜", layout: null },
  { title: "跌幅榜", layout: null },
  { title: "自选", layout: null },
  { title: "热榜", layout: null },
  { title: "涨幅榜", layout: null },
  { title: "新币榜", layout: null },
  { title: "成交额榜", layout: null },
  { title: "跌幅榜", layout: null },
];

const tabsReducer = (
  preState: IInitState,
  action: { type: string; payload: any }
) => {
  switch (action.type) {
    case "updateX":
      preState[action.payload.index].layout = action.payload.layout;
      break;
  }

  return [...preState];
};

const index = (props: Props) => {
  // 当前点击的tab
  const [activeIndex, setActiveIndex] = useState(0);

  // tab滑动的话，不能触发点击时间
  const [canClick, setCanClick] = useState<boolean>();

  // tabs的信息
  const [tabs, dispatch] = useReducer(tabsReducer, initState);

  // 滚动对象
  let scroll = useRef<any>(null);

  const [list, setList] = useState<Array<IListItem>>([
    {
      key: "1",
      icon: require("../../../../assets/images/nav1icon.png"),
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
      icon: require("../../../../assets/images/nav1icon.png"),
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
      icon: require("../../../../assets/images/nav1icon.png"),
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
      icon: require("../../../../assets/images/nav1icon.png"),
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
      icon: require("../../../../assets/images/nav1icon.png"),
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
      icon: require("../../../../assets/images/nav1icon.png"),
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
      icon: require("../../../../assets/images/nav1icon.png"),
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
      icon: require("../../../../assets/images/nav1icon.png"),
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
      icon: require("../../../../assets/images/nav1icon.png"),
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
      icon: require("../../../../assets/images/nav1icon.png"),
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
  ]);

  useLayoutEffect(() => {
    setInterval(() => {
      let newList: Array<IListItem> = list.map((item) => {
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
      setList([...newList]);
    }, 1000);
  }, []);

  return (
    <View style={styles.ljn_container}>
      {/* tabs */}
      <View style={styles.ljn_tabs}>
        <ScrollView
          horizontal
          directionalLockEnabled
          showsHorizontalScrollIndicator={false}
          snapToAlignment="center"
          ref={scroll}
          onTouchMove={() => {
            setCanClick(false);
          }}
        >
          {tabs.map((item, index) => {
            return (
              <View
                onLayout={(event) => {
                  const layout: LayoutRectangle = event.nativeEvent.layout;
                  dispatch({
                    type: "updateX",
                    payload: {
                      index: index,
                      layout: layout,
                    },
                  });
                }}
                style={styles.ljn_tab}
                key={index}
                onTouchEnd={(e) => {
                  if (!canClick) {
                    setCanClick(true);
                    return;
                  }
                  setActiveIndex(index);
                  let value =
                    (item.layout as LayoutRectangle).x -
                    px2vw(375 / 2) +
                    (item.layout?.width as number) / 2;

                  if (value < 0) value = 0;
                  scroll.current.scrollTo({
                    x: value,
                    animated: true,
                  });
                }}
              >
                <View
                  style={Object.assign(
                    {},
                    styles.ljn_tab_item,
                    activeIndex === index ? styles.ljn_tab_item_active : null
                  )}
                >
                  <Text
                    style={Object.assign(
                      {},
                      styles.ljn_tab_text,
                      activeIndex === index ? styles.ljn_tab_text_active : null
                    )}
                  >
                    {item.title}
                  </Text>
                </View>
              </View>
            );
          })}
        </ScrollView>
      </View>

      {/* 列表区域 */}
      <View style={styles.ljn_list_area}>
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
        <View>
          {list.map((item, index) => {
            return (
              <View style={styles.ljn_list_item} key={index}>
                <View style={styles.ljn_list_item_column1}>
                  <Image style={styles.ljn_list_item_icon} source={item.icon} />
                  <Text>{item.name}</Text>
                </View>
                <View style={styles.ljn_list_item_column2}>
                  <Text style={styles.ljn_list_item_column2_text}>
                    {item.price}
                  </Text>
                </View>
                <View style={styles.ljn_list_item_column3}>
                  {index === 3 ? (
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
    </View>
  );
};

export default index;

const styles = StyleSheet.create({
  ljn_container: {
    height: px2vw(570),
    backgroundColor: theme.areaBackgroundColor,
    borderRadius: px2vw(10),
    marginBottom: px2vw(10),
    display: "flex",
    flexDirection: "column",
  },
  ljn_tabs: {
    width: px2vw(375),
    height: px2vw(40),
    borderBottomWidth: px2vw(1),
    borderBottomColor: "#272f3c",
  },
  ljn_tab: {
    // width: px2vw(62.5),
    paddingLeft: px2vw(10),
    paddingRight: px2vw(10),
  },
  ljn_tab_item: {
    height: px2vw(38),
    borderBottomWidth: px2vw(3),
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
    borderBottomColor: theme.areaBackgroundColor,
  },
  ljn_tab_item_active: {
    borderBottomColor: "#32a1fc",
  },
  ljn_tab_text: {
    color: "#5c6175",
    fontSize: px2vw(14),
    fontWeight: "600",
  },
  ljn_tab_text_active: {
    color: "#32a1fc",
  },

  // ----------------------------------列表 start
  ljn_list_area: {
    paddingLeft: px2vw(12),
    paddingRight: px2vw(12),
  },

  ljn_list_title_area: {
    display: "flex",
    flexDirection: "row",
    marginBottom: px2vw(5),
    height: px2vw(30),
    marginTop: px2vw(5),
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

  ljn_list_item: {
    // backgroundColor: "red",
    display: "flex",
    flexDirection: "row",
    height: px2vw(30),
    marginBottom: px2vw(15),
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
    fontSize: px2vw(12),
  },
  ljn_list_item_column3: {
    flex: 1,
    display: "flex",
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "flex-end",
    fontSize: px2vw(12),
  },
  ljn_list_item_icon: {
    width: px2vw(25),
    height: px2vw(25),
  },
  ljn_list_item_name: {
    display: "flex",
    flexDirection: "row",
    alignItems: "center",
    marginLeft: px2vw(5),
  },
  ljn_list_item_name1: {
    color: "white",
    fontSize: px2vw(12),
    fontWeight: "600",
  },
  ljn_list_item_name2: {
    color: "#434b58",
    fontSize: px2vw(10),
    marginLeft: px2vw(3),
  },
  ljn_list_item_name3: {
    color: "#434b58",
    fontSize: px2vw(10),
  },
  ljn_list_item_float_btn_up: {
    height: px2vw(30),
    width: px2vw(80),
    backgroundColor: "#11b394",
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
    borderRadius: px2vw(4),
  },
  ljn_list_item_float_btn_down: {
    height: px2vw(30),
    width: px2vw(80),
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
    display: "flex",
    flexDirection: "row",
    justifyContent: "center",
    alignItems: "center",
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
