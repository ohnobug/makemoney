import { Provider } from "react-redux";
import store from "./src/store";
import router from "./src/router";
// import { Provider as PaperProvider } from "react-native-paper";
import React from "react";
import { View, Text } from "react-native";
import { StatusBar } from "react-native";

export default function App() {
  return (
    <>
      <StatusBar
        barStyle="light-content"
        hidden={false}
        animated={true}
        backgroundColor={"#18202d"}
      />
      <View style={{ height: "100%", width: "100%", backgroundColor: "black" }}>
        <Provider store={store}>{router}</Provider>
      </View>
    </>
  );
}
