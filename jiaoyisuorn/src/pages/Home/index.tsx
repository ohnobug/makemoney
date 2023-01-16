import React, { useEffect, useRef, useState } from "react";
import { View, Text, ScrollView, Button } from "react-native";
import LJNSwiper from "./Components/LJNSwiper";
import LJNHotInfo from "./Components/LJNHotInfo";
import LJNNav from "./Components/LJNNav";
import LJNFunctions from "./Components/LJNFunctions";
import LJNList from "./Components/LJNList";
import LJNTabbar from "../../components/LJNTabbar";
import emitter from "../../bus";
import LJNScrollView from "../../components/LJNScrollView";
import { useAppDispatch, useAppSelector } from "../../hooks";
import { selectTheme } from "../../store/SystemSlice";
import { setTheme } from "./styles";
import { setTheme as reduxSetTheme } from "../../store/SystemSlice";

type Props = {};
export default function index({}: Props) {
  let bigScrollView = useRef<ScrollView>(null);

  useEffect(() => {
    emitter.emit("getBigScrollView", bigScrollView.current);
  }, [bigScrollView]);

  const theme = useAppSelector(selectTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
  }, [theme]);

  const dispatch = useAppDispatch();

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
