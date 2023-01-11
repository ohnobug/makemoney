import React, { useEffect, useRef, useState } from "react";
import {
  View,
  StyleSheet,
  ScrollView,
  PanResponder,
  Dimensions,
} from "react-native";
import LJNSwiper from "./Components/LJNSwiper";
import LJNHotInfo from "./Components/LJNHotInfo";
import LJNNav from "./Components/LJNNav";
import LJNFunctions from "./Components/LJNFunctions";
import LJNList from "./Components/LJNList";
import LJNTabbar from "../../components/LJNTabbar";
import { px2vw } from "../../utils/utils";

type Props = {};

// let timer: any;
export default function index({}: Props) {
  const [scrollEnabled, setScrollEnabled] = useState(true);

  const mySetScrollEnabled = (value: boolean) => {
    if (scrollEnabled !== value) {
      setScrollEnabled(value);
    }
  };

  return (
    <View style={styles.container}>
      <ScrollView
        directionalLockEnabled={true}
        horizontal={false}
        style={styles.ljn_main}
        scrollEnabled={scrollEnabled}
      >
        {/* 轮播图 */}
        <LJNSwiper setScrollEnabled={mySetScrollEnabled} />

        {/* 热门信息 */}
        <LJNHotInfo />

        {/* 导航区 */}
        <LJNNav />

        {/* 功能区 */}
        <LJNFunctions />

        {/* 榜单 */}
        <LJNList setScrollEnabled={mySetScrollEnabled} />
      </ScrollView>

      <View style={styles.ljn_footer}>
        <LJNTabbar />
      </View>
    </View>
  );
}

// 考虑web端
// const screen = Dimensions.get("screen");
const window = Dimensions.get("window");

const styles = StyleSheet.create({
  container: {
    // position: "absolute",
    // top: screen.height - window.height,
    flex: 1,
    display: "flex",
    flexDirection: "column",
  },
  ljn_main: {
    flex: 1,
    maxHeight: window.height - px2vw(60),
    backgroundColor: "#0f131f",
    // #0f131f
  },
  ljn_footer: {
    flex: 0,
    minHeight: px2vw(60),
  },
});
