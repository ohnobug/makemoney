import { StyleSheet, Text, View } from "react-native";
import React from "react";
import { px2vw } from "../../../../utils/utils";
import { theme } from "../../../../themes/default/styles";

type Props = {};

const index = (props: Props) => {
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
          <Text style={styles.ljn_title_area_right_inner}>图标</Text>
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
          <View style={styles.ljn_currency_kline_area}>
            <Text style={styles.ljn_currency_kline}>图片</Text>
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
            <Text style={styles.ljn_currency_kline}>图片</Text>
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
            <Text style={styles.ljn_currency_kline}>图片</Text>
          </View>
        </View>
      </View>
    </View>
  );
};

export default index;

const styles = StyleSheet.create({
  ljn_container: {
    height: px2vw(130),
    backgroundColor: theme.areaBackgroundColor,
    padding: px2vw(17),
    borderRadius: px2vw(10),
    marginBottom: px2vw(10),
  },

  // 标题区域 --------------------start
  ljn_title_area: {
    height: px2vw(23),
    display: "flex",
    justifyContent: "space-between",
    flexDirection: "row",
    borderBottomWidth: px2vw(1),
    borderBottomColor: "#1f2734",
    marginBottom: px2vw(8),
  },
  ljn_title_area_left: {
    flex: 3,
    display: "flex",
    flexDirection: "row",
  },
  ljn_title_area_left_title_before: {
    width: px2vw(30),
    height: px2vw(16),
    backgroundColor: "#0070e7",
    borderRadius: px2vw(3),
    textAlign: "center",
    marginRight: px2vw(6),
  },
  ljn_title_area_left_title_before_inner: {
    color: "white",
    fontSize: px2vw(10),
  },
  ljn_title_area_left_title_after: {},
  ljn_title_area_left_title_after_inner: {
    color: "white",
  },
  ljn_title_area_right: {
    flex: 1,
  },
  ljn_title_area_right_inner: {
    color: "white",
    textAlign: "right",
  },

  // --------------------------------------热门信息区域 start
  ljn_hotinfo_area: {
    display: "flex",
    flexDirection: "row",
  },
  ljn_hotinfo: {
    flex: 1,
    // backgroundColor: "#f993da",
    height: px2vw(70),
  },
  ljn_currency_name_area: {
    height: px2vw(12),
    display: "flex",
    justifyContent: "center",
    flexDirection: "row",
    marginBottom: px2vw(11),
  },
  ljn_currency_name: {
    color: "#777f8c",
    marginRight: px2vw(3),
  },
  ljn_currency_name_float: {
    color: "#dc6d63",
  },
  ljn_currency_price_area: {
    height: px2vw(14),
    textAlign: "center",
    marginBottom: px2vw(8),
  },
  ljn_currency_price_title: {
    fontSize: px2vw(14),
    fontWeight: "600",
    color: "white",
  },
  ljn_currency_kline_area: {
    height: px2vw(25),
    textAlign: "center",
  },
  ljn_currency_kline: {
    color: "#f77f68",
  },
  // --------------------------------------热门信息区域 end
});
