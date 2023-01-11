import React, { useState } from "react";
import { View, StyleSheet, ScrollView, Text } from "react-native";
import LJNTabbar from "../../components/LJNTabbar";
import { px2vw } from "../../utils/utils";

type Props = {};

// let timer: any;
export default function index({}: Props) {
  const [scrollEnabled, setScrollEnabled] = useState(true);

  const mySetScrollEnabled = (value: boolean) => {
    if (scrollEnabled !== value) {
      setScrollEnabled(value);
    }
  };

  return (
    <View style={styles.container}>
      <ScrollView
        directionalLockEnabled={true}
        horizontal={false}
        style={styles.ljn_main}
        scrollEnabled={scrollEnabled}
      >
        <View style={styles.ljn_big_box}>
          <Text
            style={{
              fontSize: px2vw(50),
              color: "white",
            }}
          >
            交易
          </Text>
        </View>
      </ScrollView>

      <View style={styles.ljn_footer}>
        <LJNTabbar />
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    // position: "absolute",
    // top: screen.height - window.height,
    flex: 1,
    display: "flex",
    flexDirection: "column",
  },
  ljn_main: {
    flex: 1,
    // maxHeight: window.height - px2vw(60),
    backgroundColor: "#0f131f",
    // #0f131f
  },
  ljn_big_box: {
    height: px2vw(500),
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
  },
  ljn_footer: {
    flex: 0,
    minHeight: px2vw(60),
  },
});
