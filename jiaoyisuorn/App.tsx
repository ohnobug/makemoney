import { Provider } from "react-redux";
import store from "./src/store";
import router from "./src/router";
import React, { useEffect, useState } from "react";
import { SafeAreaView, StyleSheet } from "react-native";
import { StatusBar } from "react-native";
import emitter from "./src/bus";
import { enableExperimentalWebImplementation } from "react-native-gesture-handler";
import darkTheme from "./src/themes/default/styles";
import lightTheme from "./src/themes/light/styles";

enableExperimentalWebImplementation(true);

export default function App() {
  const [appTheme, setAppTheme] = useState("dark");
  useEffect(() => {
    emitter.on("setAppTheme", (val: string) => {
      console.log("tttt");
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
