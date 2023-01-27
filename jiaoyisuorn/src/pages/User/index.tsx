import React, { useEffect, useState } from "react";
import { View, Image, Text } from "react-native";
import LJNTabbar from "../../components/LJNTabbar";
import LJNScrollView from "../../components/LJNScrollView";
import { useAppSelector } from "../../hooks";
import { selectTheme } from "../../store/SystemSlice";
import { setTheme } from "./styles";

type Props = {};

export default function index({}: Props) {
  const theme = useAppSelector(selectTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
  }, [theme]);

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

  return (
    <View style={styles.container}>
      <LJNScrollView
        style={styles.ljn_main}
        horizontal={false}
        children={
          <>
            {/* 用户信息区域 */}
            <View style={styles.ljn_header_area}>
              {/* 顶部功能区域 */}
              <View style={styles.ljn_header_function}>
                <Image
                  style={styles.ljn_header_function_btn}
                  source={require("../../assets/images/nav3icon.png")}
                />
                <Image
                  style={styles.ljn_header_function_btn}
                  source={require("../../assets/images/nav3icon.png")}
                />
                <Image
                  style={styles.ljn_header_function_btn}
                  source={require("../../assets/images/nav3icon.png")}
                />
              </View>

              {/* 用户信息 */}
              <View style={styles.ljn_userinfo_area}>
                <View style={styles.ljn_userinfo_avatar_area}>
                  <Image
                    style={styles.ljn_userinfo_avatar_area_img}
                    source={require("../../assets/images/ad2.jpg")}
                  />
                </View>
                <View style={styles.ljn_userinfo}>
                  <View style={styles.ljn_userinfo_username}>
                    <Text style={styles.ljn_userinfo_username_text}>
                      228****@qq.com
                    </Text>
                  </View>
                  <View style={styles.ljn_userinfo_uid}>
                    <Text style={styles.ljn_userinfo_uid_text}>
                      UID 427678500
                    </Text>
                  </View>
                  <View style={styles.ljn_userinfo_about}>
                    <View style={styles.ljn_userinfo_about_inner}>
                      <Text style={styles.ljn_userinfo_about_inner_val}>0</Text>
                      <Text style={styles.ljn_userinfo_about_inner_title}>
                        关注
                      </Text>
                    </View>
                    <View style={styles.ljn_userinfo_about_inner}>
                      <Text style={styles.ljn_userinfo_about_inner_val}>0</Text>
                      <Text style={styles.ljn_userinfo_about_inner_title}>
                        粉丝
                      </Text>
                    </View>
                    <View style={styles.ljn_userinfo_about_inner}>
                      <Text style={styles.ljn_userinfo_about_inner_val}>0</Text>
                      <Text style={styles.ljn_userinfo_about_inner_title}>
                        动态
                      </Text>
                    </View>
                  </View>
                </View>
                <View style={styles.ljn_userinfo_auth_area}>
                  <View style={styles.ljn_userinfo_auth_btn1}>
                    <Text style={styles.ljn_userinfo_auth_btn1_text}>DMC</Text>
                  </View>
                  <View style={styles.ljn_userinfo_auth_btn2}>
                    <Text style={styles.ljn_userinfo_auth_btn1_text}>
                      待认证
                    </Text>
                  </View>
                </View>
              </View>

              {/* 用户等级 */}
              <View style={styles.ljn_userinfo_level_area}>
                <View style={styles.ljn_userinfo_level_row1}>
                  <View style={styles.ljn_userinfo_level_row1_left}>
                    <Text style={styles.ljn_userinfo_level_row1_left_text1}>
                      Prime 0
                    </Text>
                  </View>
                  <View style={styles.ljn_userinfo_level_row1_right}>
                    <Text style={styles.ljn_userinfo_level_row1_right_text1}>
                      升级还需要现货交易
                    </Text>
                    <Text style={styles.ljn_userinfo_level_row1_right_text2}>
                      10000.00U
                    </Text>
                  </View>
                </View>
                <View style={styles.ljn_userinfo_level_row2}>
                  <Text style={styles.ljn_userinfo_level_row2_text}>
                    HT抵扣75折•HT持币提速
                  </Text>
                </View>
              </View>

              {/* 功能区1 */}
              <View style={styles.ljn_userinfo_detail_func1}>
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

              {/* 功能区2 */}
              <View style={styles.ljn_userinfo_detail_func2}>
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
            </View>

            {/* 其他信息 */}
            <View style={styles.ljn_activation_area}>
              <View style={styles.ljn_activation_box}>
                <Text style={styles.ljn_activation_box_text}>111</Text>
              </View>
              <View style={styles.ljn_activation_box}>
                <Text style={styles.ljn_activation_box_text}>111</Text>
              </View>
              <View style={styles.ljn_activation_box}>
                <Text style={styles.ljn_activation_box_text}>111</Text>
              </View>
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
