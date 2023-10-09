import React from "react";
import { GestureHandlerRootView } from "react-native-gesture-handler";
import Router from "Router";

export default function AppInner() {
  return (
    <GestureHandlerRootView style={{ flex: 1 }}>
      <Router />
    </GestureHandlerRootView>
  );
}
