import LJNScrollView from "components/LJNScrollView";
import { useStyles } from "hooks";
import React, { useRef } from "react";
import { ScrollView, View } from "react-native";
import LJNAssetsInfo from "./Components/LJNAssetsInfo";
import LJNTradeOperation from "./Components/LJNTradeOperation";
import context from "context";
import { setTheme } from "./styles";

const { Provider } = context;

type Props = any;
export default function SlideTransaction({ navigation }: Props) {
  const styles = useStyles(setTheme);

  let bigScrollView = useRef<ScrollView>(null);

  return (
    <LJNScrollView
      style={styles.ljn_main}
      horizontal={false}
      ref={bigScrollView}
      children={
        <Provider
          value={{
            navigate: navigation.navigate,
          }}
        >
          {/* 资产区域 */}
          <View style={styles.container}>
            {/* 买卖操作 */}
            <LJNTradeOperation />

            {/* 资产信息 */}
            <LJNAssetsInfo />
          </View>
        </Provider>
      }
    />
  );
}
