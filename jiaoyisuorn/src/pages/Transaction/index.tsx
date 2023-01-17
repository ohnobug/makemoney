import React, { useState } from "react";
import {
  View,
  StyleSheet,
  ScrollView,
  Text,
  Animated,
  Button,
} from "react-native";
import LJNTabbar from "../../components/LJNTabbar";
import { px2vw } from "../../utils/utils";

type Props = {};

// let timer: any;
export default function index({}: Props) {
  const [count, setCount] = useState(0);

  const [arr, setArr] = useState<number[]>([1]);

  return (
    <View style={styles.container}>
      <ScrollView
        directionalLockEnabled={true}
        horizontal={false}
        style={styles.ljn_main}
        scrollEnabled={true}
      >
        <View style={styles.ljn_big_box}>
          <Text style={{ color: "red" }}>交易 {count}</Text>

          <Animated.View>
            <Text style={{ color: "red" }}>
              {arr.join(" + ")} ={" "}
              {arr.reduce((total, item) => (total += item), 0)}
            </Text>
            <Text style={{ color: "red" }}>交易 {count}</Text>
            <Button
              onPress={() => {
                setCount(count + 1);
                arr.push(arr.length + 1);

                setArr([...arr]);
              }}
              title="hello"
            />
          </Animated.View>
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
