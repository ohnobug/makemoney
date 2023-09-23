import { Platform } from "react-native";
import { BrowserRouter } from "react-router-dom";
import { NativeRouter, Route, Routes } from "react-router-native";
import AppInner from "../AppInner";
import Contacts from "../pages/Contacts";
import Gallery from "../pages/Gallery";
import Index from "../pages/Index";
import Login from "../pages/Login";
import Quotation from "../pages/Quotation";
import Recentcontacts from "../pages/Recentcontacts";
import Setting from "../pages/Setting";

const AppRoutes = (
  <Routes>
    <Route path="/" element={<AppInner />}>
      {/* 首页 */}
      <Route path="/" element={<Index />}></Route>
      {/* 报价 */}
      <Route path="quotation" element={<Quotation />}></Route>
      {/* 设置 */}
      <Route path="setting" element={<Setting />}></Route>
      {/* 登录 */}
      <Route path="login" element={<Login />}></Route>
      {/* 相册 */}
      <Route path="gallery" element={<Gallery />}></Route>
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
