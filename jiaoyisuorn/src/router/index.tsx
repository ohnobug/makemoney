import { NativeRouter, Route, Routes } from "react-router-native";
import { BrowserRouter } from "react-router-dom";
import { Platform } from "react-native";
import AppInner from "../AppInner";
import Gallery from "../pages/Gallery";
import Chat from "../pages/Chat";
import Home from "../pages/Home";
import User from "../pages/User";
import Assets from "../pages/Assets";
import Transaction from "../pages/Transaction";
import Contract from "../pages/Contract";
import Quotation from "../pages/Quotation";
import Setting from "../pages/Setting";
import Login from "../pages/Login";
import Contacts from "../pages/Contacts";
import Recentcontacts from "../pages/Recentcontacts";

const AppRoutes = (
  <Routes>
    <Route path="/" element={<AppInner />}>
      {/* 首页 */}
      <Route path="/" element={<Home />}></Route>
      {/* 报价 */}
      <Route path="quotation" element={<Quotation />}></Route>
      {/* 交易 */}
      <Route path="transaction" element={<Transaction />}></Route>
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
      {/* 聊天窗口 */}
      <Route path="chat" element={<Chat />}></Route>
      {/* 最近联系人 */}
      <Route path="recentcontacts" element={<Recentcontacts />}></Route>
      {/* 联系人 */}
      <Route path="contacts" element={<Contacts />}></Route>
    </Route>
  </Routes>
);

const webRouter = <BrowserRouter>{AppRoutes}</BrowserRouter>;
const nativeRouter = <NativeRouter>{AppRoutes}</NativeRouter>;

const Component = Platform.select({
  native: () => nativeRouter,
  default: () => webRouter,
})();

export default Component;
