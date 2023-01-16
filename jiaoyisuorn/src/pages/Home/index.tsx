import React, { useEffect, useRef } from "react";
import { View, StyleSheet, Dimensions, ScrollView } from "react-native";
import LJNSwiper from "./Components/LJNSwiper";
import LJNHotInfo from "./Components/LJNHotInfo";
import LJNNav from "./Components/LJNNav";
import LJNFunctions from "./Components/LJNFunctions";
import LJNList from "./Components/LJNList";
import LJNTabbar from "../../components/LJNTabbar";
import { px2vw } from "../../utils/utils";
import emitter from "../../bus";
import LJNScrollView from "../../components/LJNScrollView";

type Props = {};
export default function index({}: Props) {
  let bigScrollView = useRef<ScrollView>(null);

  useEffect(() => {
    emitter.emit("getBigScrollView", bigScrollView.current);
  }, [bigScrollView]);

  return (
    <View style={styles.container}>
      <LJNScrollView
        style={styles.ljn_main}
        horizontal={false}
        ref={bigScrollView}
        children={
          <>
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
          </>
        }
      ></LJNScrollView>

      {/* 底部 */}
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
