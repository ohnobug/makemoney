import React, { useCallback } from "react";
import { View, Image, StyleSheet } from "react-native";
import Swiper from "../../../../library/react-native-web-swiper/src/index";
import { debounce, px2vw } from "../../../../utils/utils";
import emitter from "../../../../bus";

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

  return (
    <View style={styles.container}>
      <Swiper
        horizontal
        directionalLockEnabled
        loop={false}
        vertical={false}
        minDistanceToCapture={10}
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
    </View>
  );
};

export default index;

const styles = StyleSheet.create({
  container: {
    width: px2vw(375),
    height: px2vw(160),
  },
  slide1: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "#9DD6EB",
  },
  image: {
    width: "100%",
    height: "100%",
  },
});
