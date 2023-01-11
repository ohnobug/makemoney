import React, { useRef } from "react";
import { View, Image, StyleSheet, PanResponder } from "react-native";
import Swiper from "../../../../library/react-native-web-swiper/src/index";
import { px2vw } from "../../../../utils/utils";

type Props = {
  setScrollEnabled: Function;
};

let timer: any;
const index = (props: Props) => {
  const swiperRef = useRef<any>();

  const _swiperPan = {
    onPanResponderGrant: () => {
      props.setScrollEnabled(false);
      console.log("onPanResponderGrant");
    },
    onPanResponderMove: () => {
      props.setScrollEnabled(false);
      console.log("onPanResponderMove");
    },
    onPanResponderRelease: () => {
      console.log("onPanResponderRelease");

      if (timer) {
        console.log("清理时钟");
        clearTimeout(timer);
      }
      timer = setTimeout(() => {
        console.log("释放了");
        props.setScrollEnabled(true);
      }, 500);
    },
    // onAnimationEnd: () => {
    //   console.log("动画播放完成释放");
    //   props.setScrollEnabled(true);
    // },
    onPanResponderTerminate: () => {
      console.log("onPanResponderTerminate");
      if (timer) {
        console.log("清理时钟");
        clearTimeout(timer);
      }

      timer = setTimeout(() => {
        console.log("释放了");
        props.setScrollEnabled(true);
      }, 500);
    },
  };

  return (
    <View style={styles.container}>
      <Swiper
        {..._swiperPan}
        ref={swiperRef}
        horizontal
        directionalLockEnabled
        loop={false}
        vertical={false}
        minDistanceToCapture={10}
        minDistanceForAction={0}
        // controlsEnabled={false}
        controlsProps={{
          prevPos: false,
          nextPos: false,
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
