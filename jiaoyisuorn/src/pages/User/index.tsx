import React, { useEffect, useState } from "react";
import { View } from "react-native";
import LJNTabbar from "../../components/LJNTabbar";
import LJNScrollView from "../../components/LJNScrollView";
import { useAppSelector } from "../../hooks";
import { selectTheme } from "../../store/SystemSlice";
import { setTheme } from "./styles";
import LJNActivation1 from "./Components/LJNActivation1";
import LJNUserInfo from "./Components/LJNUserInfo";

type Props = {};

export default function index({}: Props) {
  const theme = useAppSelector(selectTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
  }, [theme]);

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
