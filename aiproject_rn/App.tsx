import * as SplashScreen from "expo-splash-screen";
import React, { useCallback, useEffect, useState } from "react";
import { StatusBar, StyleSheet } from "react-native";
import { enableExperimentalWebImplementation } from "react-native-gesture-handler";
import { SafeAreaView } from "react-native-safe-area-context";
import { Provider } from "react-redux";
import AppInner from "./src/AppInner";
import emitter from "./src/bus";
import store from "./src/store";
import darkTheme from "./src/themes/default/styles";
import lightTheme from "./src/themes/light/styles";

// Prevent native splash screen from autohiding before App component declaration
SplashScreen.preventAutoHideAsync()
  .then((result) =>
    console.log(`SplashScreen.preventAutoHideAsync() succeeded: ${result}`)
  )
  .catch(console.warn); // it's good to explicitly catch and inspect any error

enableExperimentalWebImplementation(true);

export default function App() {
  const [appTheme, setAppTheme] = useState("light");
  useEffect(() => {
    emitter.on("setAppTheme", (val: string) => {
      console.log("设置主题成功!", val);
      setAppTheme(val);
    });
  }, []);

  const [appIsReady, setAppIsReady] = useState(false);

  useEffect(() => {
    async function prepare() {
      try {
        await new Promise((resolve) => setTimeout(resolve, 0));
        console.log("成功进入app");
      } catch (e) {
        console.warn(e);
      } finally {
        setAppIsReady(true);
      }
    }

    prepare();
  }, []);

  const onLayoutRootView = useCallback(async () => {
    if (appIsReady) {
      await SplashScreen.hideAsync();
    }
  }, [appIsReady]);

  if (!appIsReady) {
    return null;
  }

  return (
    <SafeAreaView style={styles.container} onLayout={onLayoutRootView}>
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
