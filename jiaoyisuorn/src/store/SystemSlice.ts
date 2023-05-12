import { createSlice } from "@reduxjs/toolkit";
import { RootState } from ".";
import emitter from "../bus";

interface IinitialState {
  tabbarIndex: number;
  theme: string;
  galleryPlayIndex: number;
}

const initialState: IinitialState = {
  tabbarIndex: 0,
  theme: "dark",
  galleryPlayIndex: -1,
};

const SystemSlice = createSlice({
  name: "system",
  initialState,
  reducers: {
    setTabbarIndex(state, action) {
      state.tabbarIndex = action.payload;
    },
    setTheme(state, action) {
      state.theme = action.payload;
      emitter.emit("setTheme", action.payload);
    },
    setGalleryPlayIndex(state, action) {
      state.galleryPlayIndex = action.payload;
    },
  },
});

export const { setTabbarIndex, setTheme, setGalleryPlayIndex } =
  SystemSlice.actions;
export const selectTabbarIndex = (state: RootState) => state.system.tabbarIndex;
export const selectTheme = (state: RootState) => state.system.theme;
export const selectGalleryPlayIndex = (state: RootState) =>
  state.system.galleryPlayIndex;

export default SystemSlice.reducer;
