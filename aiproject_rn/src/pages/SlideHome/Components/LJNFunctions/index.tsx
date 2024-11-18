import React, { useEffect, useState } from "react";
import { Image, Text, View } from "react-native";
import LJNLoading from "components/LJNLoading";
import { useStyles } from "hooks";
import { setTheme } from "./styles";

type Props = {};
const index = (props: Props) => {
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

  return (
    <View style={styles.ljn_container}>
      {show ? (
        <>
          <View style={styles.ljn_container_area_1}>
            <View style={styles.ljn_function_left_area}>
              <View style={styles.ljn_function_area_title1}>
                <Text style={styles.ljn_function_area_title1_inner}>
                  新币专区
                </Text>
              </View>
              <View style={styles.ljn_function_area_title2}>
                <Text
                  style={styles.ljn_function_area_title2_inner}
                  numberOfLines={10}
                >
                  免费空投天天领
                </Text>
              </View>
              <View style={styles.ljn_function_area_title3}>
                <Text
                  style={styles.ljn_function_area_title3_inner}
                  numberOfLines={11}
                >
                  500U锦鲤大奖等你拿
                </Text>
              </View>
            </View>
            <View style={styles.ljn_function_right_area}>
              <Image
                style={styles.ljn_function_right_area_img_inner}
                source={require("assets/images/function1icon.png")}
              />
            </View>
          </View>
          <View style={styles.ljn_container_area_2}>
            <View style={styles.ljn_function_left_area}>
              <View style={styles.ljn_function_area_title1}>
                <Text style={styles.ljn_function_area_title1_inner}>
                  快捷买币
                </Text>
              </View>
              <View style={styles.ljn_function_area_title2}>
                <Text
                  style={styles.ljn_function_area_title2_inner}
                  numberOfLines={10}
                >
                  充币/C2C
                </Text>
              </View>
              <View style={styles.ljn_function_area_title3}>
                <Text
                  style={styles.ljn_function_area_title3_inner}
                  numberOfLines={11}
                >
                  1.00 CNY/USDT
                </Text>
              </View>
            </View>
            <View style={styles.ljn_function_right_area}>
              <Image
                style={styles.ljn_function_right_area_img_inner}
                source={require("assets/images/function2icon.png")}
              />
            </View>
          </View>
          <View style={styles.ljn_container_area_3}>
            <View style={styles.ljn_function_left_area}>
              <View style={styles.ljn_function_area_title1}>
                <Text style={styles.ljn_function_area_title1_inner}>
                  果果理财
                </Text>
              </View>
              <View style={styles.ljn_function_area_title2}>
                <Text
                  style={styles.ljn_function_area_title2_inner}
                  numberOfLines={10}
                >
                  USDD 18%年利率
                </Text>
              </View>
              <View style={styles.ljn_function_area_title3}>
                <Text
                  style={styles.ljn_function_area_title3_inner}
                  numberOfLines={11}
                >
                  轻松保本稳健赚
                </Text>
              </View>
            </View>
            <View style={styles.ljn_function_right_area}>
              <Image
                style={styles.ljn_function_right_area_img_inner}
                source={require("assets/images/function3icon.png")}
              />
            </View>
          </View>
          <View style={styles.ljn_container_area_4}>
            <View style={styles.ljn_function_left_area}>
              <View style={styles.ljn_function_area_title1}>
                <Text style={styles.ljn_function_area_title1_inner}>直播</Text>
                <Text style={styles.ljn_function_area_title1_inner2}>
                  正在直播
                </Text>
              </View>
              <View style={styles.ljn_function_area_title2}>
                <Text
                  style={styles.ljn_function_area_title2_inner}
                  numberOfLines={10}
                >
                  多投获利, 市场广大
                </Text>
              </View>
              <View style={styles.ljn_function_area_title3}>
                <Text
                  style={styles.ljn_function_area_title3_inner}
                  numberOfLines={11}
                >
                  观看：410
                </Text>
              </View>
            </View>
            <View style={styles.ljn_function_right_area}>
              <Image
                style={styles.ljn_function_right_area_img_inner}
                source={require("assets/images/function4icon.png")}
              />
            </View>
          </View>
        </>
      ) : (
        <LJNLoading />
      )}
    </View>
  );
};

export default index;
