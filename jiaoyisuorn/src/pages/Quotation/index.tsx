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
      <ScrollView
        directionalLockEnabled={true}
        horizontal={false}
        style={styles.ljn_main}
      >
        <Button
          onPress={() => {
            dispatch(setTheme("dark"));
          }}
          title="黑"
          color="#841584"
          accessibilityLabel="Learn more about this purple button"
        />
        <Button
          onPress={() => {
            dispatch(setTheme("light"));
          }}
          title="白"
          color="#841584"
          accessibilityLabel="Learn more about this purple button"
        />

        <View
          style={{
            backgroundColor: "red",
          }}
        >
          <Text style={{ color: "white" }}>{theme}</Text>
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
