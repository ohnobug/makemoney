"use strict";
exports.__esModule = true;
var react_router_native_1 = require("react-router-native");
var Home_1 = require("../pages/Home");
var AppInner_1 = require("../AppInner");
var User_1 = require("../pages/User");
var Assets_1 = require("../pages/Assets");
var Transaction_1 = require("../pages/Transaction");
var Contract_1 = require("../pages/Contract");
var Quotation_1 = require("../pages/Quotation");
var Setting_1 = require("../pages/Setting");
var Login_1 = require("../pages/Login");
var react_router_dom_1 = require("react-router-dom");
var Gallery_1 = require("../pages/Gallery");
var react_native_1 = require("react-native");
var webRouter = (React.createElement(react_router_dom_1.BrowserRouter, null,
    React.createElement(react_router_native_1.Routes, null,
        React.createElement(react_router_native_1.Route, { path: "/", element: React.createElement(AppInner_1["default"], null) },
            React.createElement(react_router_native_1.Route, { path: "/", element: React.createElement(Home_1["default"], null) }),
            React.createElement(react_router_native_1.Route, { path: "quotation", element: React.createElement(Quotation_1["default"], null) }),
            React.createElement(react_router_native_1.Route, { index: true, path: "transaction", element: React.createElement(Transaction_1["default"], null) }),
            React.createElement(react_router_native_1.Route, { path: "contract", element: React.createElement(Contract_1["default"], null) }),
            React.createElement(react_router_native_1.Route, { path: "assets", element: React.createElement(Assets_1["default"], null) }),
            React.createElement(react_router_native_1.Route, { path: "user", element: React.createElement(User_1["default"], null) }),
            React.createElement(react_router_native_1.Route, { path: "setting", element: React.createElement(Setting_1["default"], null) }),
            React.createElement(react_router_native_1.Route, { path: "login", element: React.createElement(Login_1["default"], null) }),
            React.createElement(react_router_native_1.Route, { path: "gallery", element: React.createElement(Gallery_1["default"], null) })))));
var nativeRouter = (React.createElement(react_router_native_1.NativeRouter, null,
    React.createElement(react_router_native_1.Routes, null,
        React.createElement(react_router_native_1.Route, { path: "/", element: React.createElement(AppInner_1["default"], null) },
            React.createElement(react_router_native_1.Route, { path: "/", element: React.createElement(Home_1["default"], null) }),
            React.createElement(react_router_native_1.Route, { path: "quotation", element: React.createElement(Quotation_1["default"], null) }),
            React.createElement(react_router_native_1.Route, { index: true, path: "transaction", element: React.createElement(Transaction_1["default"], null) }),
            React.createElement(react_router_native_1.Route, { path: "contract", element: React.createElement(Contract_1["default"], null) }),
            React.createElement(react_router_native_1.Route, { path: "assets", element: React.createElement(Assets_1["default"], null) }),
            React.createElement(react_router_native_1.Route, { path: "user", element: React.createElement(User_1["default"], null) }),
            React.createElement(react_router_native_1.Route, { path: "setting", element: React.createElement(Setting_1["default"], null) }),
            React.createElement(react_router_native_1.Route, { path: "login", element: React.createElement(Login_1["default"], null) }),
            React.createElement(react_router_native_1.Route, { path: "gallery", element: React.createElement(Gallery_1["default"], null) })))));
var Component = react_native_1.Platform.select({
    native: function () { return nativeRouter; },
    "default": function () { return webRouter; }
})();
exports["default"] = Component;
