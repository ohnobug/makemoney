import React, { useRef, useState } from "react";
import { Image, ScrollView, Text, View } from "react-native";
import LJNEmptyBlock from "../../components/LJNEmptyBlock";
import LJNIcon from "../../components/LJNIcon";
import LJNScrollView from "../../components/LJNScrollView";
import LJNTabbar from "../../components/LJNTabbar";
import { useStyles } from "../../hooks";
import { setTheme } from "./styles";

type Props = {};

export default function index({}: Props) {
  const styles = useStyles(setTheme);

  const [list, setList] = useState([
    {
      icon: require("../../assets/images/nav1icon.png"),
      title: "CNY买币",
      path: "/",
    },
    {
      icon: require("../../assets/images/nav2icon.png"),
      title: "交易机器人",
      path: "/",
    },
    {
      icon: require("../../assets/images/nav3icon.png"),
      title: "USDT合约",
      path: "/",
    },
    {
      icon: require("../../assets/images/nav4icon.png"),
      title: "理财",
      path: "/",
    },
    {
      icon: require("../../assets/images/nav5icon.png"),
      title: "跟单 ",
      path: "/",
    },
  ]);
  let bigScrollView = useRef<ScrollView>(null);

  return (
    <View style={styles.container}>
      <LJNScrollView
        style={styles.ljn_main}
        horizontal={false}
        ref={bigScrollView}
        children={
          <>
            {/* 资产区域 */}
            <View style={styles.ljn_assets_area}>
              <View style={styles.ljn_header}>
                <View style={styles.ljn_header_left}>
                  <View style={styles.ljn_header_left_1}>
                    <Text style={styles.ljn_header_left_1_text}>总资产</Text>
                  </View>
                  <View style={styles.ljn_header_left_2}>
                    <Text style={styles.ljn_header_left_2_text}>CNY</Text>
                    <LJNIcon title={"xiajiantou"} size={12} />
                  </View>
                  <View style={styles.ljn_header_left_3}>
                    <LJNIcon title={"eye"} size={16} />
                  </View>
                </View>
                <View style={styles.ljn_header_right}>
                  <LJNIcon title={"fenxiang_2"} size={20} />
                </View>
              </View>

              <View style={styles.ljn_assets_info}>
                <View style={styles.ljn_assets_amount_area}>
                  <View style={styles.ljn_assets_amount}>
                    <View style={styles.ljn_assets_value_icon}>
                      <LJNIcon title={"rmb"} size={20} color="white" />
                    </View>
                    <Text style={styles.ljn_assets_value_text}>0.00</Text>
                  </View>
                  <View style={styles.ljn_assets_chart}>
                    <View style={styles.ljn_assets_chart_icon}>
                      <LJNIcon
                        title={"jinyizhoushouyi"}
                        size={16}
                        color="white"
                      />
                    </View>
                    <Text style={styles.ljn_assets_chart_text}>盈亏日报</Text>
                  </View>
                </View>

                <View style={styles.ljn_assets_benefit_area}>
                  <View style={styles.ljn_assets_benefit_info1}>
                    <Text style={styles.ljn_assets_benefit_info1_title}>
                      今日收益
                    </Text>
                    <Text style={styles.ljn_assets_benefit_info1_value}>
                      --
                    </Text>
                  </View>
                  <View style={styles.ljn_assets_benefit_info2}>
                    <Text style={styles.ljn_assets_benefit_info2_title}>
                      今日收益率
                    </Text>
                    <Text style={styles.ljn_assets_benefit_info2_value}>
                      0.00%
                    </Text>
                  </View>
                  <View style={styles.ljn_assets_benefit_info3}>
                    <Text style={styles.ljn_assets_benefit_info3_title}>
                      累计收益
                    </Text>
                    <Text style={styles.ljn_assets_benefit_info3_value}>
                      --
                    </Text>
                  </View>
                </View>
              </View>

              {/* 功能列表 */}
              <View style={styles.ljn_list_area}>
                {list.map((item, index) => {
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
                })}
              </View>
            </View>

            <View style={styles.ljn_quick_recharge}>
              <LJNEmptyBlock />
            </View>
          </>
        }
      />

      <View style={styles.ljn_footer}>
        <LJNTabbar />
      </View>
    </View>
  );
}
