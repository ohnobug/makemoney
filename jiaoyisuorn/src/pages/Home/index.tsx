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
    <View
      style={{
        // display: "flex",
        flex: 1,
      }}
    >
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
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#0f131f",
    // height: screen.height,
    display: "flex",
  },
});
