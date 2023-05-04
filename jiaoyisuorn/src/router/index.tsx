import { NativeRouter, Route, Routes } from "react-router-native";
import Home from "../pages/Home";
import AppInner from "../AppInner";
import User from "../pages/User";
import Assets from "../pages/Assets";
import Transaction from "../pages/Transaction";
import Contract from "../pages/Contract";
import Quotation from "../pages/Quotation";
import Setting from "../pages/Setting";
import Login from "../pages/Login";
import { BrowserRouter } from "react-router-dom";
import Gallery from "../pages/Gallery";
import { Platform } from "react-native";

const webRouter = (
  <BrowserRouter>
    <Routes>
      <Route path="/" element={<AppInner />}>
        {/* 首页 */}
        <Route path="/" element={<Home />}></Route>
        {/* 报价 */}
        <Route path="quotation" element={<Quotation />}></Route>
        {/* 交易 */}
        <Route index path="transaction" element={<Transaction />}></Route>
        {/* 合约 */}
        <Route path="contract" element={<Contract />}></Route>
        {/* 资源 */}
        <Route path="assets" element={<Assets />}></Route>
        {/* 用户中心 */}
        <Route path="user" element={<User />}></Route>
        {/* 设置 */}
        <Route path="setting" element={<Setting />}></Route>
        {/* 登录 */}
        <Route path="login" element={<Login />}></Route>
        {/* 相册 */}
        <Route path="gallery" element={<Gallery />}></Route>
      </Route>
    </Routes>
  </BrowserRouter>
);

const nativeRouter = (
  <NativeRouter>
    <Routes>
      <Route path="/" element={<AppInner />}>
        {/* 首页 */}
        <Route path="/" element={<Home />}></Route>
        {/* 报价 */}
        <Route path="quotation" element={<Quotation />}></Route>
        {/* 交易 */}
        <Route index path="transaction" element={<Transaction />}></Route>
        {/* 合约 */}
        <Route path="contract" element={<Contract />}></Route>
        {/* 资源 */}
        <Route path="assets" element={<Assets />}></Route>
        {/* 用户中心 */}
        <Route path="user" element={<User />}></Route>
        {/* 设置 */}
        <Route path="setting" element={<Setting />}></Route>
        {/* 登录 */}
        <Route path="login" element={<Login />}></Route>
        {/* 相册 */}
        <Route path="gallery" element={<Gallery />}></Route>
      </Route>
    </Routes>
  </NativeRouter>
);

const Component = Platform.select({
  native: () => nativeRouter,
  default: () => webRouter,
})();

export default Component;
