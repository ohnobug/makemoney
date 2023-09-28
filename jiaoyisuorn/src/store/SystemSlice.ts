import { createSlice } from "@reduxjs/toolkit";
import { RootState } from ".";
import emitter from "../bus";

interface IinitialState {
  tabbarIndex: number;
  appTheme: string;
  galleryPlayIndex: number;
}

const initialState: IinitialState = {
  tabbarIndex: 0,
  appTheme: "light",
  galleryPlayIndex: -1,
};

const SystemSlice = createSlice({
  name: "system",
  initialState,
  reducers: {
    setTabbarIndex(state, action) {
      state.tabbarIndex = action.payload;
    },
    setAppTheme(state, action) {
      state.appTheme = action.payload;
      emitter.emit("setAppTheme", action.payload);
    },
    setGalleryPlayIndex(state, action) {
      state.galleryPlayIndex = action.payload;
    },
  },
});

export const { setTabbarIndex, setAppTheme, setGalleryPlayIndex } =
  SystemSlice.actions;
export const selectTabbarIndex = (state: RootState) => state.system.tabbarIndex;
export const selectAppTheme = (state: RootState) => state.system.appTheme;
export const selectGalleryPlayIndex = (state: RootState) =>
  state.system.galleryPlayIndex;

export default SystemSlice.reducer;
