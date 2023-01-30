import { NativeRouter, Route, Routes } from "react-router-native";
import Home from "../pages/Home";
import AppInner from "../AppInner";
import User from "../pages/User";
import Assets from "../pages/Assets";
import Transaction from "../pages/Transaction";
import Contract from "../pages/Contract";
import Quotation from "../pages/Quotation";

const router = (
  <NativeRouter>
    <Routes>
      <Route path="/" element={<AppInner />}>
        <Route index={true} element={<Home />}></Route>
        <Route path="quotation" element={<Quotation />}></Route>
        <Route path="transaction" element={<Transaction />}></Route>
        <Route path="contract" element={<Contract />}></Route>
        <Route path="assets" element={<Assets />}></Route>
        <Route path="user" element={<User />}></Route>
      </Route>
    </Routes>
  </NativeRouter>
);

export default router;
