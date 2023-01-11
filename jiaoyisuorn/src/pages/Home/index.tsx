import React, { useEffect, useRef, useState } from "react";
import {
  View,
  StyleSheet,
  ScrollView,
  PanResponder,
  InteractionManager,
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

export default function index({}: Props) {
  const [scrollEnabled, setScrollEnabled] = useState(true);
  return (
    <View style={styles.container}>
      <ScrollView
        directionalLockEnabled={true}
        horizontal={false}
        style={styles.ljn_main}
        scrollEnabled={scrollEnabled}
      >
        {/* 轮播图 */}
        <LJNSwiper setScrollEnabled={setScrollEnabled} />

        {/* 热门信息 */}
        <LJNHotInfo />

        {/* 导航区 */}
        <LJNNav />

        {/* 功能区 */}
        <LJNFunctions />

        {/* 榜单 */}
        <LJNList setScrollEnabled={setScrollEnabled} />
      </ScrollView>

      <View style={styles.ljn_footer}>
        <LJNTabbar />
      </View>
    </View>
  );
}

const screen = Dimensions.get("screen");
const window = Dimensions.get("window");

const styles = StyleSheet.create({
  container: {
    position: "absolute",
    top: screen.height - window.height,
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
