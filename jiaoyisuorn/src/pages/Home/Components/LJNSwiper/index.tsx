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
          horizontal
          directionalLockEnabled
          loop={false}
          vertical={false}
          minDistanceToCapture={3}
          minDistanceForAction={0.1}
          controlsProps={{
            prevPos: false,
            nextPos: false,
          }}
          onAnimationStart={() => {
            bigScrollView?.setNativeProps({
              scrollEnabled: false,
            });
          }}
          onAnimationEnd={() => {
            fd();
          }}
          onNotAllowScroll={() => {
            bigScrollView?.setNativeProps({
              scrollEnabled: true,
            });
          }}
        >
          {[
            require("../../../../assets/images/ad1.jpg"),
            require("../../../../assets/images/ad2.jpg"),
            require("../../../../assets/images/ad3.jpg"),
            require("../../../../assets/images/ad4.jpg"),
            require("../../../../assets/images/ad5.jpg"),
          ].map((item, index) => {
            return (
              <View style={styles.slide1} key={index}>
                <Image style={styles.image} source={item} />
              </View>
            );
          })}
        </Swiper>
      ) : (
        <LJNLoading />
        // <View style={styles.slide1}>
        //   <Image
        //     style={styles.image}
        //     source={require("../../../../assets/images/ad1.jpg")}
        //   />
        // </View>
      )}
    </View>
  );
};

export default index;
