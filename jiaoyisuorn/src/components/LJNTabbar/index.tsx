import { StyleSheet, Text, View, Image } from "react-native";
import React, { useState } from "react";
import { px2vw } from "../../utils/utils";

type Props = {};

const index = (props: Props) => {
  const [tabs, setTabs] = useState([
    {
      title: "首页",
      path: "",
      icon: require("../../assets/images/nav1icon.png"),
    },
    {
      title: "行情",
      path: "",
      icon: require("../../assets/images/nav2icon.png"),
    },
    {
      title: "交易",
      path: "",
      icon: require("../../assets/images/nav3icon.png"),
    },
    {
      title: "合约",
      path: "",
      icon: require("../../assets/images/nav4icon.png"),
    },
    {
      title: "资产",
      path: "",
      icon: require("../../assets/images/nav5icon.png"),
    },
    {
      title: "我的",
      path: "",
      icon: require("../../assets/images/nav6icon.png"),
    },
  ]);

  return (
    <View style={styles.ljn_tabbar}>
      {tabs.map((item, index) => {
        return (
          <View style={styles.ljn_tabbar_item} key={index}>
            <View style={styles.ljn_tabbar_item_img_area}>
              <Image style={styles.ljn_tabbar_item_img} source={item.icon} />
            </View>
            <View style={styles.ljn_tabbar_item_title_area}>
              <Text style={styles.ljn_tabbar_item_title}>{item.title}</Text>
            </View>
          </View>
        );
      })}
    </View>
  );
};

export default index;

const styles = StyleSheet.create({
  ljn_tabbar: {
    height: px2vw(60),
    paddingTop: px2vw(5),
    paddingBottom: px2vw(5),
    display: "flex",
    flexDirection: "row",
    backgroundColor: "#18202d",
    borderTopWidth: px2vw(1),
    borderTopColor: "#272f3c",
  },
  ljn_tabbar_item: {
    // backgroundColor: "#0ff000",
    // height: px2vw(50),
    flex: 1,
    display: "flex",
    flexDirection: "column",
    // justifyContent: "center",
    alignItems: "center",
  },
  ljn_tabbar_item_img_area: {
    flex: 1,
    // backgroundColor: "#ff00dd",
    display: "flex",
    alignItems: "center",
    flexDirection: "row",
  },
  ljn_tabbar_item_img: {
    width: px2vw(27),
    height: px2vw(27),
  },
  ljn_tabbar_item_title_area: {
    flex: 0,
    minHeight: px2vw(15),
    width: "100%",
    // backgroundColor: "#ffccdd",
    display: "flex",
    justifyContent: "center",
    flexDirection: "row",
    alignItems: "center",
  },
  ljn_tabbar_item_title: {
    fontSize: px2vw(12),
    color: "#dae4f0",
  },
});
