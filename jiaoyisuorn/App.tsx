import { Provider } from "react-redux";
import store from "./store";
import router from "./router";
import { RouterProvider } from "react-router-dom";
import { Provider as PaperProvider } from "react-native-paper";

export default function App() {
  return (
    <Provider store={store}>
      <PaperProvider>
        <RouterProvider router={router} />
      </PaperProvider>
    </Provider>
  );
}
