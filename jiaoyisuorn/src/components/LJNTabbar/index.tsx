import { StyleSheet, Text, View, Image } from "react-native";
import React, { useState } from "react";
import { px2vw } from "../../utils/utils";
import { useNavigate } from "react-router-native";
import { useAppSelector } from "../../../hooks";
import { selectTabbarIndex, setTabbarIndex } from "../../store/SystemSlice";
import { useAppDispatch } from "../../hooks";

type Props = {};

const index = (props: Props) => {
  const navigate = useNavigate();
  const [tabs, setTabs] = useState([
    {
      title: "首页",
      path: "/",
      icon: require("../../assets/images/nav1icon.png"),
    },
    {
      title: "行情",
      path: "/quotation",
      icon: require("../../assets/images/nav2icon.png"),
    },
    {
      title: "交易",
      path: "/trade",
      icon: require("../../assets/images/nav3icon.png"),
    },
    {
      title: "合约",
      path: "/contract",
      icon: require("../../assets/images/nav4icon.png"),
    },
    {
      title: "资产",
      path: "/assets",
      icon: require("../../assets/images/nav5icon.png"),
    },
    {
      title: "我的",
      path: "/user",
      icon: require("../../assets/images/nav6icon.png"),
    },
  ]);

  const dispatch = useAppDispatch();
  const tabbarIndex = useAppSelector(selectTabbarIndex);

  return (
    <View style={styles.ljn_tabbar}>
      {tabs.map((item, index) => {
        return (
          <View
            style={styles.ljn_tabbar_item}
            key={index}
            onStartShouldSetResponderCapture={() => true}
            onResponderGrant={() => {
              dispatch(setTabbarIndex(index));
              navigate(item.path);
            }}
          >
            <View style={styles.ljn_tabbar_item_img_area}>
              <Image style={styles.ljn_tabbar_item_img} source={item.icon} />
            </View>
            <View style={styles.ljn_tabbar_item_title_area}>
              <Text
                style={StyleSheet.flatten([
                  styles.ljn_tabbar_item_title,
                  index === tabbarIndex
                    ? styles.ljn_tabbar_item_title_active
                    : {},
                ])}
              >
                {item.title}
              </Text>
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
  ljn_tabbar_item_title_active: {
    color: "#3c8aff",
    fontWeight: "600",
  },
});
