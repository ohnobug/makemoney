import { configureStore } from "@reduxjs/toolkit";
import SystemSlice from "./SystemSlice";

const store = configureStore({
  reducer: {
    system: SystemSlice,
  },
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;

export default store;
