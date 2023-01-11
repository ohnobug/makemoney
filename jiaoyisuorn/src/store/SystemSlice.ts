import { createSlice } from "@reduxjs/toolkit";
import { RootState } from ".";

interface IinitialState {
  tabbarIndex: number;
}

const initialState: IinitialState = {
  tabbarIndex: 0,
};

const SystemSlice = createSlice({
  name: "system",
  initialState,
  reducers: {
    setTabbarIndex(state, action) {
      state.tabbarIndex = action.payload;
    },
  },
});

export const { setTabbarIndex } = SystemSlice.actions;
export const selectTabbarIndex = (state: RootState) => state.system.tabbarIndex;

export default SystemSlice.reducer;
