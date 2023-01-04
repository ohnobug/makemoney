import { StyleSheet, Text, View, Image } from "react-native";
import React, { useState } from "react";
import { px2vw } from "../../../../utils/utils";
import { theme } from "../../../../themes/default/styles";
// import { Image } from "react-native-svg";

type Props = {};

const index = (props: Props) => {
  const [list, setList] = useState([
    {
      icon: require("../../../../assets/images/nav1icon.png"),
      title: "CNY买币",
      path: "/",
    },
    {
      icon: require("../../../../assets/images/nav2icon.png"),
      title: "交易机器人",
      path: "/",
    },
    {
      icon: require("../../../../assets/images/nav3icon.png"),
      title: "USDT合约",
      path: "/",
    },
    {
      icon: require("../../../../assets/images/nav4icon.png"),
      title: "理财",
      path: "/",
    },
    {
      icon: require("../../../../assets/images/nav5icon.png"),
      title: "跟单 ",
      path: "/",
    },
    {
      icon: require("../../../../assets/images/nav6icon.png"),
      title: "社区",
      path: "/",
    },
    {
      icon: require("../../../../assets/images/nav7icon.png"),
      title: "HT专区",
      path: "/",
    },
    {
      icon: require("../../../../assets/images/nav8icon.png"),
      title: "福利中心",
      path: "/",
    },
    {
      icon: require("../../../../assets/images/nav9icon.png"),
      title: "邀请返佣",
      path: "/",
    },
    {
      icon: require("../../../../assets/images/nav10icon.png"),
      title: "PI交易赛",
      path: "/",
    },
  ]);

  return (
    <View style={styles.ljn_list_area}>
      {list.map((item, index) => {
        return (
          <View style={styles.ljn_list_item} key={index}>
            <View style={styles.ljn_list_item_icon}>
              {/* <Text style={styles.ljn_list_item_icon_inner}>{item.icon}</Text> */}
              <Image style={styles.ljn_list_item_icon_img} source={item.icon} />
            </View>
            <View style={styles.ljn_list_item_title}>
              <Text style={styles.ljn_list_item_title_inner}>{item.title}</Text>
            </View>
          </View>
        );
      })}
    </View>
  );
};

export default index;

const styles = StyleSheet.create({
  ljn_list_area: {
    // height: px2vw(170),
    backgroundColor: theme.areaBackgroundColor,
    paddingTop: px2vw(12),
    paddingBottom: px2vw(8),
    paddingLeft: px2vw(0),
    paddingRight: px2vw(0),
    borderRadius: px2vw(10),
    marginBottom: px2vw(10),
    display: "flex",
    flexDirection: "row",
    flexWrap: "wrap",
  },
  ljn_list_item: {
    flexGrow: 1,
    flexBasis: px2vw(68.2),
    height: px2vw(65),
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
    flexDirection: "column",
    marginBottom: px2vw(10),
  },
  ljn_list_item_icon: {
    width: px2vw(35),
    height: px2vw(35),
    marginBottom: px2vw(8),
    // backgroundColor: "blue",
  },
  ljn_list_item_icon_img: {
    width: px2vw(35),
    height: px2vw(35),
  },
  ljn_list_item_title: {},
  ljn_list_item_title_inner: {
    color: "white",
    textAlign: "center",
    fontSize: px2vw(11),
  },
});
