import React from "react";
import { View, StyleSheet, Dimensions, ScrollView } from "react-native";
import LJNSwiper from "./Components/LJNSwiper";
import LJNHotInfo from "./Components/LJNHotInfo";
import LJNNav from "./Components/LJNNav";
import LJNFunctions from "./Components/LJNFunctions";
import LJNList from "./Components/LJNList";

type Props = {};

export default function index({}: Props) {
  return (
    <ScrollView style={styles.container}>
      {/* 轮播图 */}
      <LJNSwiper />

      {/* 热门信息 */}
      <LJNHotInfo />

      {/* 导航区 */}
      <LJNNav />

      {/* 功能区 */}
      <LJNFunctions />

      {/* 榜单 */}
      <LJNList />
    </ScrollView>
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
