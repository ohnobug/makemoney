import React from "react";
import { View } from "react-native";
import LJNScrollView from "../../components/LJNScrollView";
import LJNTabbar from "../../components/LJNTabbar";
import { useStyles } from "../../hooks";
import LJNActivation1 from "./Components/LJNActivation1";
import LJNUserInfo from "./Components/LJNUserInfo";
import { setTheme } from "./styles";

type Props = {};

export default function index({}: Props) {
  const styles = useStyles(setTheme);

  return (
    <View style={styles.container}>
      <LJNScrollView
        style={styles.ljn_main}
        horizontal={false}
        children={
          <>
            {/* 用户信息区域 */}
            <LJNUserInfo />

            {/* 其他信息 */}
            <View style={styles.ljn_activation_area}>
              <LJNActivation1 />
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
