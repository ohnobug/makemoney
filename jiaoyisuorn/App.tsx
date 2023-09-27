import * as SplashScreen from "expo-splash-screen";
import React, { useEffect, useState } from "react";
import { StatusBar, StyleSheet } from "react-native";
import { enableExperimentalWebImplementation } from "react-native-gesture-handler";
import { SafeAreaView } from "react-native-safe-area-context";
import { Provider } from "react-redux";
import AppInner from "./src/AppInner";
import emitter from "./src/bus";
import store from "./src/store";
import darkTheme from "./src/themes/default/styles";
import lightTheme from "./src/themes/light/styles";

// Keep the splash screen visible while we fetch resources
SplashScreen.preventAutoHideAsync();

enableExperimentalWebImplementation(true);

export default function App() {
  const [appTheme, setAppTheme] = useState("dark");
  useEffect(() => {
    emitter.on("setAppTheme", (val: string) => {
      console.log("设置主题成功!", val);
      setAppTheme(val);
    });
  }, []);

  useEffect(() => {
    async function prepare() {
      // await new Promise((resolve) => setTimeout(resolve, 0));
      await SplashScreen.hideAsync();
    }

    prepare();
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
      <Provider store={store}>
        <AppInner />
      </Provider>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "black",
  },
});
