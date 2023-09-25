import React, { useContext, useEffect, useState } from "react";
import { Image, Text, View } from "react-native";
import LJNLoading from "components/LJNLoading";
import { useStyles } from "hooks";
import { setTheme } from "./styles";
import context from "pages/SlideHome/context";

type Props = {};

const LJNNav = ({}: Props) => {
  const [list, setList] = useState([
    {
      icon: require("assets/images/nav1icon.png"),
      title: "CNY买币",
      screen: "home",
      path: "index",
    },
    {
      icon: require("assets/images/nav2icon.png"),
      title: "交易机器人",
      screen: "home",
      path: "index",
    },
    {
      icon: require("assets/images/nav3icon.png"),
      title: "USDT合约",
      screen: "home",
      path: "index",
    },
    {
      icon: require("assets/images/nav4icon.png"),
      title: "理财",
      screen: "home",
      path: "index",
    },
    {
      icon: require("assets/images/nav5icon.png"),
      title: "跟单",
      screen: "home",
      path: "index",
    },
    {
      icon: require("assets/images/nav6icon.png"),
      title: "图片墙",
      screen: "galleryScreen",
      path: "gallery",
    },
    {
      icon: require("assets/images/nav7icon.png"),
      title: "HT专区",
      screen: "home",
      path: "index",
    },
    {
      icon: require("assets/images/nav8icon.png"),
      title: "福利中心",
      screen: "home",
      path: "index",
    },
    {
      icon: require("assets/images/nav9icon.png"),
      title: "邀请返佣",
      screen: "home",
      path: "index",
    },
    {
      icon: require("assets/images/nav10icon.png"),
      title: "PI交易赛",
      screen: "home",
      path: "index",
    },
  ]);

  const styles = useStyles(setTheme);

  let [show, setShow] = useState(true);
  useEffect(() => {
    let timer = setTimeout(() => {
      setShow(true);
    }, 0);

    return () => {
      clearTimeout(timer);
    };
  }, []);

  const ctx = useContext<any>(context);
  const navigate = ctx.navigate;

  return (
    <View style={styles.ljn_list_area}>
      {show ? (
        list.map((item, index) => {
          return (
            <View
              style={styles.ljn_list_item}
              key={index}
              onTouchEnd={() => {
                console.log("跳转到", item.path);
                navigate(item.screen, { screen: item.path });
              }}
            >
              <View style={styles.ljn_list_item_icon}>
                <Image
                  style={styles.ljn_list_item_icon_img}
                  source={item.icon}
                />
              </View>
              <View style={styles.ljn_list_item_title}>
                <Text style={styles.ljn_list_item_title_inner}>
                  {item.title}
                </Text>
              </View>
            </View>
          );
        })
      ) : (
        <LJNLoading />
      )}
    </View>
  );
};

export default LJNNav;
