import React, { useEffect, useRef, useState } from "react";
import { View, ScrollView, Text, StyleSheet } from "react-native";
import LJNTabbar from "../../components/LJNTabbar";
import { useAppSelector } from "../../hooks";
import { selectTheme } from "../../store/SystemSlice";
import { setTheme } from "./styles";
import LJNScrollView from "../../components/LJNScrollView";
import { px2vw } from "../../utils/utils";
import LJNHeaderScroll from "../../components/LJNHeaderScroll";
import LJNEmptyBlock from "../../components/LJNEmptyBlock";
import LJNTradeOperation from "./Components/LJNTradeOperation";
import LJNAssetsInfo from "./Components/LJNAssetsInfo";

type Props = {};

export default function index({}: Props) {
  const theme = useAppSelector(selectTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
  }, [theme]);

  let bigScrollView = useRef<ScrollView>(null);

  return (
    <View style={styles.container}>
      <LJNScrollView
        style={styles.ljn_main}
        horizontal={false}
        ref={bigScrollView}
        children={
          <>
            {/* 资产区域 */}
            <View style={styles.container}>
              {/* 买卖操作 */}
              <LJNTradeOperation />

              {/* 资产信息 */}
              <LJNAssetsInfo />
            </View>
          </>
        }
      />

      <View style={styles.ljn_footer}>
        <LJNTabbar />
      </View>
    </View>
  );
}
