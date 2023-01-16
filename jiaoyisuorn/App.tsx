import { Provider } from "react-redux";
import store from "./src/store";
import router from "./src/router";
import React from "react";
import { SafeAreaView, StyleSheet } from "react-native";
import { StatusBar } from "react-native";

export default function App() {
  return (
    <SafeAreaView style={styles.container}>
      <StatusBar
        barStyle="light-content"
        hidden={false}
        animated={true}
        backgroundColor={"#18202d"}
      />
      <Provider store={store}>{router}</Provider>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});
