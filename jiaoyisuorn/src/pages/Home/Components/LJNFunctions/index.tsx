import { StyleSheet, Text, View, Image } from "react-native";
import React from "react";
import { px2vw } from "../../../../utils/utils";
import { theme } from "../../../../themes/default/styles";

type Props = {};

const index = (props: Props) => {
  return (
    <View style={styles.ljn_container}>
      <View style={styles.ljn_container_area_1}>
        <View style={styles.ljn_function_left_area}>
          <View style={styles.ljn_function_area_title1}>
            <Text style={styles.ljn_function_area_title1_inner}>新币专区</Text>
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
            source={require("../../../../assets/images/function1icon.png")}
          />
        </View>
      </View>
      <View style={styles.ljn_container_area_2}>
        <View style={styles.ljn_function_left_area}>
          <View style={styles.ljn_function_area_title1}>
            <Text style={styles.ljn_function_area_title1_inner}>快捷买币</Text>
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
            source={require("../../../../assets/images/function2icon.png")}
          />
        </View>
      </View>
      <View style={styles.ljn_container_area_3}>
        <View style={styles.ljn_function_left_area}>
          <View style={styles.ljn_function_area_title1}>
            <Text style={styles.ljn_function_area_title1_inner}>果果理财</Text>
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
            source={require("../../../../assets/images/function3icon.png")}
          />
        </View>
      </View>
      <View style={styles.ljn_container_area_4}>
        <View style={styles.ljn_function_left_area}>
          <View style={styles.ljn_function_area_title1}>
            <Text style={styles.ljn_function_area_title1_inner}>直播</Text>
            <Text style={styles.ljn_function_area_title1_inner2}>正在直播</Text>
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
            source={require("../../../../assets/images/function4icon.png")}
          />
        </View>
      </View>
    </View>
  );
};

export default index;

const styles = StyleSheet.create({
  ljn_container: {
    display: "flex",
    flexDirection: "row",
    flexWrap: "wrap",
    backgroundColor: theme.areaBackgroundColor,
    height: px2vw(160),
    borderRadius: px2vw(10),
    marginBottom: px2vw(10),
  },
  ljn_container_area_1: {
    paddingTop: px2vw(10),
    paddingBottom: px2vw(13),
    paddingLeft: px2vw(17),
    paddingRight: px2vw(17),
    flex: 1,
    flexBasis: px2vw(186.5),
    height: px2vw(80),
    borderBottomWidth: px2vw(1),
    borderBottomColor: "#272f3c",
    borderRightWidth: px2vw(1),
    borderRightColor: "#272f3c",
    display: "flex",
    flexDirection: "row",
  },
  ljn_container_area_2: {
    paddingTop: px2vw(10),
    paddingBottom: px2vw(13),
    paddingLeft: px2vw(17),
    paddingRight: px2vw(17),
    flex: 1,
    flexBasis: px2vw(187.5),
    height: px2vw(80),
    borderBottomWidth: px2vw(1),
    borderBottomColor: "#272f3c",
    display: "flex",
    flexDirection: "row",
  },
  ljn_container_area_3: {
    paddingTop: px2vw(10),
    paddingBottom: px2vw(13),
    paddingLeft: px2vw(17),
    paddingRight: px2vw(17),
    flex: 1,
    flexBasis: px2vw(186.5),
    height: px2vw(80),
    borderRightWidth: px2vw(1),
    borderRightColor: "#272f3c",
    display: "flex",
    flexDirection: "row",
  },
  ljn_container_area_4: {
    paddingTop: px2vw(10),
    paddingBottom: px2vw(13),
    paddingLeft: px2vw(17),
    paddingRight: px2vw(17),
    flex: 1,
    flexBasis: px2vw(187.5),
    height: px2vw(80),
    display: "flex",
    flexDirection: "row",
    position: "relative",
  },

  ljn_function_left_area: {
    flex: 1,
  },
  ljn_function_area_title1: {
    marginBottom: px2vw(5),
    display: "flex",
    flexDirection: "row",
    alignItems: "center",
  },
  ljn_function_area_title1_inner: {
    color: "#787e8c",
    fontWeight: "600",
    fontSize: px2vw(12),
    // height: px2vw(14),
  },
  ljn_function_area_title1_inner2: {
    color: "#dc731a",
    marginLeft: px2vw(5),
    paddingTop: px2vw(2),
    paddingBottom: px2vw(2),
    paddingLeft: px2vw(8),
    paddingRight: px2vw(8),
    fontSize: px2vw(9),
    backgroundColor: "#232432",
    fontStyle: "italic",
    // top: px2vw(0),
    // position: "absolute",
    // left: px2vw(24),
    borderRadius: px2vw(2),
  },
  ljn_function_area_title2: {
    marginBottom: px2vw(5),
  },
  ljn_function_area_title2_inner: {
    color: "white",
    fontWeight: "600",
    fontSize: px2vw(14),
    height: px2vw(18),
  },
  ljn_function_area_title3: {
    // marginBottom: px2vw(5),
  },
  ljn_function_area_title3_inner: {
    color: "#787e8c",
    fontSize: px2vw(10),
    height: px2vw(14),
  },

  ljn_function_right_area: {
    flex: 0,
    flexBasis: px2vw(45),
    // height: px2vw(45),
    display: "flex",
    flexDirection: "row",
    justifyContent: "flex-end",
    alignItems: "center",
  },
  ljn_function_right_area_img_inner: {
    width: px2vw(38),
    height: px2vw(38),
  },
});
