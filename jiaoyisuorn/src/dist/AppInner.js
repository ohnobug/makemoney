"use strict";
exports.__esModule = true;
var react_1 = require("react");
var react_native_1 = require("react-native");
var react_router_native_1 = require("react-router-native");
if (react_native_1.Platform.OS === "web") {
    window.onresize = function () {
        location.href = "/";
    };
}
var timer;
function AppInner() {
    var navigate = react_router_native_1.useNavigate();
    var location = react_router_native_1.useLocation();
    var backCount = react_1.useRef(0).current;
    react_1.useEffect(function () {
        var backHandler = react_native_1.BackHandler.addEventListener("hardwareBackPress", function () {
            backCount++;
            timer = setTimeout(function () {
                backCount = 0;
            }, 1500);
            if (backCount >= 3) {
                react_native_1.BackHandler.exitApp();
            }
            else if (backCount >= 2) {
                if (react_native_1.Platform.OS === "android") {
                    react_native_1.ToastAndroid.show("再按一次退出", 300);
                }
            }
            else {
                console.log("返回:", location.pathname);
                if (![
                    "/",
                    "/quotation",
                    "/transaction",
                    "/contract",
                    "/assets",
                    "/user",
                ].includes(location.pathname)) {
                    navigate(-1);
                }
            }
            return true;
        });
        return function () {
            clearTimeout(timer);
            backHandler.remove();
        };
    }, [location]);
    return (React.createElement(React.Fragment, null,
        React.createElement(react_router_native_1.Outlet, null)));
}
exports["default"] = AppInner;
