"use strict";
var _a;
exports.__esModule = true;
exports.selectAppTheme =
  exports.selectTabbarIndex =
  exports.setTheme =
  exports.setTabbarIndex =
    void 0;
var toolkit_1 = require("@reduxjs/toolkit");
var bus_1 = require("../bus");
var initialState = {
  tabbarIndex: 0,
  theme: "dark",
};
var SystemSlice = toolkit_1.createSlice({
  name: "system",
  initialState: initialState,
  reducers: {
    setTabbarIndex: function (state, action) {
      state.tabbarIndex = action.payload;
    },
    setTheme: function (state, action) {
      state.theme = action.payload;
      bus_1["default"].emit("setTheme", action.payload);
    },
  },
});
(exports.setTabbarIndex = ((_a = SystemSlice.actions), _a.setTabbarIndex)),
  (exports.setTheme = _a.setTheme);
exports.selectTabbarIndex = function (state) {
  return state.system.tabbarIndex;
};
exports.selectAppTheme = function (state) {
  return state.system.theme;
};
exports["default"] = SystemSlice.reducer;
