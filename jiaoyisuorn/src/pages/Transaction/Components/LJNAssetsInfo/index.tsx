import React, { useEffect, useRef, useState } from "react";
import { View } from "react-native";
import LJNEmptyBlock from "../../../../components/LJNEmptyBlock";
import LJNHeaderScroll from "../../../../components/LJNHeaderScroll";
import LJNLoading from "../../../../components/LJNLoading";
import { useStyles } from "../../../../hooks";
import { setTheme } from "./styles";

type Props = {};

const index = (props: Props) => {
  const styles = useStyles(setTheme);

  // 顶部滑动
  let myswiperHeader = useRef<any>(null);

  let [show, setShow] = useState(true);
  useEffect(() => {
    let timer = setTimeout(() => {
      setShow(true);
    }, 100);

    return () => {
      clearTimeout(timer);
    };
  }, []);

  return (
    <View style={styles.ljn_container}>
      {show ? (
        <View style={styles.ljn_assets_history_info}>
          {/* tabs */}
          <LJNHeaderScroll
            ref={myswiperHeader}
            list={["资产", "当前委托", "历史成交"]}
            onChange={(n: number) => {}}
          />
          <View>
            <LJNEmptyBlock />
          </View>
        </View>
      ) : (
        <LJNLoading />
      )}
    </View>
  );
};

export default index;
