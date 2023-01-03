import { createHashRouter } from "react-router-dom";
import Home from "../pages/Home";
import AppInner from "../AppInner";
import User from "../pages/User";
import Assets from "../pages/Assets";
import Trade from "../pages/Trade";

const router = createHashRouter([
  {
    path: "/",
    element: <AppInner />,
    children: [
      {
        index: true,
        element: <Home />,
      },
      {
        path: "assets",
        element: <Assets />,
      },
      {
        path: "trade",
        element: <Trade />,
      },
      {
        path: "user",
        element: <User />,
      },
    ],
  },
]);

export default router;
