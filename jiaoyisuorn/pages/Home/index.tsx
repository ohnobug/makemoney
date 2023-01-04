import React from "react";
import { View, StyleSheet, Dimensions } from "react-native";
import LJNSwiper from "./Components/LJNSwiper";
import LJNHotInfo from "./Components/LJNHotInfo";
import LJNNav from "./Components/LJNNav";
import LJNFunctions from "./Components/LJNFunctions";

type Props = {};

export default function index({}: Props) {
  return (
    <View style={styles.container}>
      {/* 轮播图 */}
      <LJNSwiper />

      {/* 热门信息 */}
      <LJNHotInfo />

      {/* 导航区 */}
      <LJNNav />

      {/* 功能区 */}
      <LJNFunctions />
    </View>
  );
}

const screen = Dimensions.get("screen");

const styles = StyleSheet.create({
  container: {
    backgroundColor: "#0f131f",
    height: screen.height,
    display: "flex",
  },
});
