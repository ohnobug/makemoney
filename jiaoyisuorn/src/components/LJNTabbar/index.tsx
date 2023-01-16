import { StyleSheet, Text, View, Image } from "react-native";
import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-native";
import { useAppSelector } from "../../hooks";
import {
  selectTabbarIndex,
  selectTheme,
  setTabbarIndex,
} from "../../store/SystemSlice";
import { useAppDispatch } from "../../hooks";
import { setTheme } from "./styles";

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

  const theme = useAppSelector(selectTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
  }, [theme]);

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
