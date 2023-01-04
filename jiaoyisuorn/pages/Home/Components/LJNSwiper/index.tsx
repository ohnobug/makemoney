import React from "react";
// import { useAppDispatch, useAppSelector } from "../../../../hooks";
// import { getCount } from "../../../../store/SystemSlice";
import { View, Text, StyleSheet } from "react-native";
import Swiper from "react-native-swiper/src";
import { px2vw } from "../../../../utils/utils";

type Props = {};

const index = (props: Props) => {
  return (
    <View style={styles.container}>
      <Swiper style={styles.wrapper} showsButtons={true}>
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
    height: px2vw(146),
  },
  wrapper: {
    height: px2vw(146),
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
