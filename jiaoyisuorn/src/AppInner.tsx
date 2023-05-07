import { useEffect, useRef } from "react";
import { BackHandler, Platform } from "react-native";
import { Outlet, useLocation, useNavigate } from "react-router-native";

if (Platform.OS === "web") {
  window.onresize = () => {
    location.href = "/";
  };
}

let timer: string | number | NodeJS.Timeout | undefined;
export default function AppInner() {
  const navigate = useNavigate();
  const location = useLocation();
  let backCount = useRef(0).current;

  useEffect(() => {
    const backHandler = BackHandler.addEventListener(
      "hardwareBackPress",
      () => {
        backCount++;
        timer = setTimeout(() => {
          backCount = 0;
        }, 1500);

        if (backCount >= 3) {
          BackHandler.exitApp();
        } else if (backCount >= 2) {
          if (Platform.OS === "android") {
            // ToastAndroid.show("再按一次退出", 300);
          }
        } else {
          console.log("返回:", location.pathname);

          if (
            ![
              "/",
              "/quotation",
              "/transaction",
              "/contract",
              "/assets",
              "/user",
            ].includes(location.pathname)
          ) {
            navigate(-1);
          }
        }
        return true;
      }
    );

    return () => {
      clearTimeout(timer);
      backHandler.remove();
    };
  }, [location]);

  return (
    <>
      <Outlet />
    </>
  );
}
