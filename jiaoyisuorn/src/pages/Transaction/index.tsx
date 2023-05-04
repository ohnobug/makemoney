import React, { useRef } from "react";
import { ScrollView, View } from "react-native";
import LJNScrollView from "../../components/LJNScrollView";
import LJNTabbar from "../../components/LJNTabbar";
import { useStyles } from "../../hooks";
import LJNAssetsInfo from "./Components/LJNAssetsInfo";
import LJNTradeOperation from "./Components/LJNTradeOperation";
import { setTheme } from "./styles";

type Props = {};

export default function index({}: Props) {
  const styles = useStyles(setTheme);

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
