import React from "react";
import { View, StyleSheet, ScrollView, Text, Button } from "react-native";
import LJNTabbar from "../../components/LJNTabbar";
import { px2vw } from "../../utils/utils";
import { useAppDispatch, useAppSelector } from "../../hooks";
import { selectTheme, setTheme } from "../../store/SystemSlice";

type Props = {};

// let timer: any;
export default function index({}: Props) {
  const dispatch = useAppDispatch();
  const theme = useAppSelector(selectTheme);

  return (
    <View style={styles.container}>
      <View
        style={{
          flex: 1,
          backgroundColor: "#333333",
          display: "flex",
          justifyContent: "center",
          alignItems: "center",
        }}
      >
        <Text style={{ fontSize: px2vw(50), color: "red" }}>
          当前主题{theme}
        </Text>
      </View>
      <View style={styles.ljn_main}>
        <View
          style={{
            flex: 1,
            backgroundColor: "black",
            display: "flex",
            justifyContent: "center",
            alignItems: "center",
          }}
          onTouchStart={() => {
            dispatch(setTheme("dark"));
          }}
        >
          <Text style={{ fontSize: px2vw(30), color: "red" }}>黑色主题</Text>
        </View>
        <View
          style={{
            flex: 1,
            backgroundColor: "white",
            display: "flex",
            justifyContent: "center",
            alignItems: "center",
          }}
          onTouchStart={() => {
            dispatch(setTheme("light"));
          }}
        >
          <Text style={{ fontSize: px2vw(30), color: "red" }}>白色主题</Text>
        </View>
      </View>

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
    flex: 3,
    backgroundColor: "#0f131f",
    display: "flex",
    flexDirection: "row",
  },
  ljn_footer: {
    flex: 0,
    minHeight: px2vw(60),
  },
});
