import { createSlice } from "@reduxjs/toolkit";
import { RootState } from ".";

interface IinitialState {
  count: number;
}

const initialState: IinitialState = {
  count: 100,
};

const SystemSlice = createSlice({
  name: "system",
  initialState,
  reducers: {
    add(state) {
      state.count++;
    },
    reduce(state) {
      state.count--;
    },
  },
});

export const { add, reduce } = SystemSlice.actions;
export const getCount = (state: RootState) => state.system.count;

export default SystemSlice.reducer;
