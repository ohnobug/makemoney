import React, { useRef } from "react";
import { View, Image, StyleSheet, PanResponder } from "react-native";
import Swiper from "../../../../library/react-native-web-swiper/src/index";
import { px2vw } from "../../../../utils/utils";

type Props = {
  setScrollEnabled?: Function;
};

const index = (props: Props) => {
  return (
    <View style={styles.container}>
      <Swiper
        horizontal
        directionalLockEnabled
        loop={false}
        vertical={false}
        minDistanceToCapture={0}
        minDistanceForAction={0}
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
