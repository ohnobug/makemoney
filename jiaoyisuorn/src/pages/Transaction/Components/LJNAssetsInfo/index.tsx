import { View } from "react-native";
import React, { useEffect, useRef, useState } from "react";
import LJNHeaderScroll from "../../../../components/LJNHeaderScroll";
import { useAppSelector } from "../../../../hooks";
import { selectTheme } from "../../../../store/SystemSlice";
import LJNEmptyBlock from "../../../../components/LJNEmptyBlock";
import { px2vw } from "../../../../utils/utils";
import { setTheme } from "./styles";
import LJNLoading from "../../../../components/LJNLoading";

type Props = {};

const index = (props: Props) => {
  const theme = useAppSelector(selectTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
  }, [theme]);

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
