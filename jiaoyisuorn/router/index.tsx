import Home from "../pages/Home";
import AppInner from "../AppInner";
import User from "../pages/User";
import Assets from "../pages/Assets";
import Trade from "../pages/Trade";
import { NativeRouter, Route, Routes } from "react-router-native";

// const router = createHashRouter([
//   {
//     path: "/",
//     element: <AppInner />,
//     children: [
//       {
//         index: true,
//         element: <Home />,
//       },
//       {
//         path: "assets",
//         element: <Assets />,
//       },
//       {
//         path: "trade",
//         element: <Trade />,
//       },
//       {
//         path: "user",
//         element: <User />,
//       },
//     ],
//   },
// ]);

const router = (
  <NativeRouter>
    <Routes>
      <Route path="/" element={<AppInner />}>
        <Route index={true} element={<Home />}></Route>
        <Route path="assets" element={<Assets />}></Route>
        <Route path="trade" element={<Trade />}></Route>
        <Route path="user" element={<User />}></Route>
      </Route>
    </Routes>
  </NativeRouter>
);

export default router;
