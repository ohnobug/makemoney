import { Provider } from "react-redux";
import store from "./src/store";
import router from "./src/router";
import React, { useEffect, useState } from "react";
import { SafeAreaView, StyleSheet } from "react-native";
import { StatusBar } from "react-native";
import emitter from "./src/bus";

export default function App() {
  const [theme, setTheme] = useState("dark");
  useEffect(() => {
    emitter.on("setTheme", (val: string) => {
      setTheme(val);
    });
  }, []);

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar
        barStyle={theme === "dark" ? "light-content" : "dark-content"}
        hidden={false}
        animated={true}
        backgroundColor={theme === "dark" ? "#18202d" : "white"}
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
