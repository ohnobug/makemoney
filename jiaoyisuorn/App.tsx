import React, { useEffect, useState } from "react";
import { SafeAreaView, StatusBar, StyleSheet } from "react-native";
import { enableExperimentalWebImplementation } from "react-native-gesture-handler";
import { Provider } from "react-redux";
import emitter from "./src/bus";
import router from "./src/router";
import store from "./src/store";
import darkTheme from "./src/themes/default/styles";
import lightTheme from "./src/themes/light/styles";

enableExperimentalWebImplementation(true);

export default function App() {
  const [appTheme, setAppTheme] = useState("dark");
  useEffect(() => {
    emitter.on("setAppTheme", (val: string) => {
      console.log("设置主题成功!", val);
      setAppTheme(val);
    });
  }, []);

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar
        barStyle={appTheme === "dark" ? "light-content" : "dark-content"}
        hidden={false}
        animated={true}
        backgroundColor={
          appTheme === "dark"
            ? darkTheme.headerBackgroundColor
            : lightTheme.headerBackgroundColor
        }
      />
      <Provider store={store}>{router}</Provider>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "black",
  },
});
