import React, { useEffect, useRef } from "react";
import { ScrollView } from "react-native";
import emitter from "bus";
import LJNScrollView from "components/LJNScrollView";
import { useStyles } from "hooks";
import LJNFunctions from "./Components/LJNFunctions";
import LJNHotInfo from "./Components/LJNHotInfo";
import LJNList from "./Components/LJNList";
import LJNNav from "./Components/LJNNav";
import LJNSwiper from "./Components/LJNSwiper";
import { setTheme } from "./styles";

type Props = {};
export default function index({}: Props) {
  let bigScrollView = useRef<ScrollView>(null);

  useEffect(() => {
    emitter.emit("getBigScrollView", bigScrollView.current);
  }, [bigScrollView]);

  const styles = useStyles(setTheme);

  return (
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
  );
}
