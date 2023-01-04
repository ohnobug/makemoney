import { Provider } from "react-redux";
import store from "./src/store";
import router from "./src/router";
import { Provider as PaperProvider } from "react-native-paper";
import React from "react";

export default function App() {
  return (
    <Provider store={store}>
      <PaperProvider>{router}</PaperProvider>
    </Provider>
  );
}
