import React from "react";
import { View, Text, StyleSheet } from "react-native";
import Swiper from "react-native-web-swiper";
import { px2vw } from "../../../../utils/utils";

type Props = {};

const index = (props: Props) => {
  return (
    <View style={styles.container}>
      <Swiper
        controlsProps={{
          // prevTitle: "",
          // nextTitle: "",
          prevPos: false,
          nextPos: false,
        }}
      >
        <View style={styles.slide1}>
          <Text style={styles.text}>Hello Swiper</Text>
        </View>
        <View style={styles.slide2}>
          <Text style={styles.text}>Beautiful</Text>
        </View>
        <View style={styles.slide3}>
          <Text style={styles.text}>And simple</Text>
        </View>
      </Swiper>
    </View>
  );
};

export default index;

const styles = StyleSheet.create({
  container: {
    height: px2vw(160),
  },
  wrapper: {
    // height: px2vw(146),
  },
  slide1: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "#9DD6EB",
  },
  slide2: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "#97CAE5",
  },
  slide3: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "#92BBD9",
  },
  text: {
    color: "#fff",
    fontSize: px2vw(30),
    fontWeight: "bold",
  },
});
