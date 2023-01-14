import { Provider } from "react-redux";
import store from "./src/store";
import router from "./src/router";
// import { Provider as PaperProvider } from "react-native-paper";
import React from "react";
import { View } from "react-native";
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

// 代码片段
// let _pan1 = useRef(
//   PanResponder.create({
//     onStartShouldSetPanResponderCapture(e, gesture) {
//       return false;
//     },
//     onStartShouldSetPanResponder(e, gesture) {
//       return false;
//     },
//     onMoveShouldSetPanResponderCapture(e, gesture) {
//       return false;
//     },
//     onMoveShouldSetPanResponder(e, gesture) {
//       return false;
//     },
//     onPanResponderTerminationRequest(e, gesture) {
//       return false;
//     },
//     onPanResponderGrant(e, gesture) {
//       console.log("scroll onPanResponderGrant");
//     },
//     onPanResponderStart(e, gesture) {
//       console.log("scroll onPanResponderStart");
//     },
//     onPanResponderMove(e, gesture) {
//       console.log("scroll onPanResponderMove");
//     },
//     onPanResponderEnd(e, gesture) {
//       console.log("scroll onPanResponderEnd");
//     },
//     onPanResponderReject(e, gesture) {
//       console.log("scroll onPanResponderReject");
//     },
//     onPanResponderTerminate(e, gesture) {
//       console.log("scroll onPanResponderTerminate");
//     },
//   })
// ).current;
