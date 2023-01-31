import React, { useCallback, useEffect, useState } from "react";
import { View, Image, StyleSheet } from "react-native";
import Swiper from "../../../../library/react-native-web-swiper/src/index";
import { debounce, px2vw } from "../../../../utils/utils";
import emitter from "../../../../bus";
import LJNLoading from "../../../../components/LJNLoading";
import { useAppSelector } from "../../../../hooks";
import { selectTheme } from "../../../../store/SystemSlice";
import { setTheme } from "./styles";

// 接收父组件ref
let bigScrollView: any;
emitter.on("getBigScrollView", (e) => {
  bigScrollView = e;
});

type Props = {};
const index = (props: Props) => {
  const [list, setList] = useState([
    require("../../../../assets/images/ad1.jpg"),
    require("../../../../assets/images/ad2.jpg"),
    require("../../../../assets/images/ad3.jpg"),
    require("../../../../assets/images/ad4.jpg"),
    require("../../../../assets/images/ad5.jpg"),
  ]);

  const fd = useCallback(
    debounce(() => {
      bigScrollView?.setNativeProps({
        scrollEnabled: true,
      });
    }, 500),
    []
  );

  let [show, setShow] = useState(false);
  useEffect(() => {
    let timer = setTimeout(() => {
      setShow(true);
    }, 100);

    return () => {
      // 如果不加该行，可能会操作已经被销毁的View
      bigScrollView = null;
      clearTimeout(timer);
    };
  }, []);

  const theme = useAppSelector(selectTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
  }, [theme]);

  return (
    <View style={styles.container}>
      {show ? (
        <Swiper
          loop={false}
          vertical={false}
          minDistanceToCapture={10}
          minDistanceForAction={0.1}
          onAnimationStart={() => {
            bigScrollView?.setNativeProps({
              scrollEnabled: false,
            });
          }}
          onAnimationEnd={() => {
            fd();
          }}
          springConfig={{
            stiffness: 100,
            damping: 100,
            mass: 0.2,
          }}
          controlsEnabled={true}
          controlsProps={{
            prevPos: false,
            nextPos: false,
          }}
        >
          {list.map((item, index) => {
            return (
              <View style={styles.ljn_slide} key={index}>
                <Image style={styles.ljn_slide_image} source={item} />
              </View>
            );
          })}
        </Swiper>
      ) : (
        <View style={styles.ljn_slide}>
          <Image style={styles.ljn_slide_image} source={list[0]} />
        </View>
      )}
    </View>
  );
};

export default index;
