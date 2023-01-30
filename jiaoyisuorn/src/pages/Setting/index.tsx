import { View, Button, Text, Alert } from "react-native";
import React, { useEffect, useRef, useState } from "react";
import LJNHeader from "../../components/LJNHeader";
import LJNList from "../../components/LJNList";
import { setTheme } from "./styles";
import { useAppSelector } from "../../hooks";
import { selectTheme } from "../../store/SystemSlice";
import LJNScrollView from "../../components/LJNScrollView";
import LJNButton from "../../components/LJNButton";

type Props = {};

const listData1 = [
  { title: "安全设置", desc: "", url: "" },
  { title: "交易设置", desc: "", url: "" },
];

const listData2 = [
  { title: "通知管理", desc: "", url: "" },
  { title: "语言", desc: "简体中文", url: "" },
  { title: "计价方式", desc: "CNY", url: "" },
  { title: "涨跌颜色", desc: "绿涨红跌", url: "" },
  { title: "颜色模式", desc: "深色模式", url: "" },
  { title: "网络检测", desc: " ", url: "" },
  { title: "清空缓存", desc: " ", url: "" },
  { title: "关于我们", desc: "版本号 9.5.0", url: "" },
];

const index = (props: Props) => {
  const theme = useAppSelector(selectTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
  }, [theme]);

  return (
    <View style={styles.ljn_container}>
      <LJNHeader title={"设置"} />
      <LJNScrollView
        style={styles.ljn_main}
        horizontal={false}
        children={
          <>
            <LJNList list={listData1} />
            <LJNList list={listData2} />
          </>
        }
      />
      <View style={styles.ljn_logout_area}>
        <LJNButton
          style={styles.ljn_switch_account}
          onPress={() => {}}
          title="切换账号登录"
        />
        <Text style={styles.ljn_logout}>退出</Text>
      </View>
    </View>
  );
};

export default index;
