import { Text, View, Image } from "react-native";
import React, { useEffect, useState } from "react";
import { useAppSelector } from "../../../../hooks";
import { setTheme } from "./styles";
import { selectTheme } from "../../../../store/SystemSlice";
import LJNLoading from "../../../../components/LJNLoading";

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

  const theme = useAppSelector(selectTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
  }, [theme]);

  let [show, setShow] = useState(false);
  useEffect(() => {
    let timer = setTimeout(() => {
      setShow(true);
    }, 0);

    return () => {
      clearTimeout(timer);
    };
  }, []);

  return (
    <View style={styles.ljn_list_area}>
      {show ? (
        list.map((item, index) => {
          return (
            <View style={styles.ljn_list_item} key={index}>
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

export default index;
