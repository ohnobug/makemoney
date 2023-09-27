import { createMaterialTopTabNavigator } from "@react-navigation/material-top-tabs";
import { NavigationContainer } from "@react-navigation/native";
// import { createStackNavigator } from "@react-navigation/stack";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import AppStylesConfig from "AppStylesConfig";
import { useAppSelector } from "hooks";
import Gallery from "pages/Gallery";
import Login from "pages/Login";
import Setting from "pages/Setting";
import SlideAssets from "pages/SlideAssets";
import SlideChat from "pages/SlideChat";
import SlideHome from "pages/SlideHome";
import SlideUser from "pages/SlideUser";
import React from "react";
import { Image } from "react-native";
import { GestureHandlerRootView } from "react-native-gesture-handler";
import { selectAppTheme } from "store/SystemSlice";
import darkTheme from "themes/default/styles";
import lightTheme from "themes/light/styles";
import { px2vw } from "utils/utils";

const navIcons = {
  index: [
    require("assets/images/nav1icon.png"),
    require("assets/images/nav7icon.png"),
  ],
  chat: [
    require("assets/images/nav2icon.png"),
    require("assets/images/nav8icon.png"),
  ],
  contract: [
    require("assets/images/nav3icon.png"),
    require("assets/images/nav9icon.png"),
  ],
  transaction: [
    require("assets/images/nav4icon.png"),
    require("assets/images/nav10icon.png"),
  ],
  assets: [
    require("assets/images/nav5icon.png"),
    require("assets/images/nav1icon.png"),
  ],
  user: [
    require("assets/images/nav6icon.png"),
    require("assets/images/nav2icon.png"),
  ],
};

function IconImg({ focused, color, name }: any) {
  return (
    <Image
      source={focused ? navIcons[name][0] : navIcons[name][1]}
      style={{
        width: px2vw(26),
        height: px2vw(26),
        borderRadius: px2vw(26),
      }}
    />
  );
}

// 首页屏幕
function IndexScreen() {
  const appTheme = useAppSelector(selectAppTheme);

  return (
    <Tab.Navigator
      initialLayout={{
        width: px2vw(375),
        height: AppStylesConfig.tabbarHeight,
      }}
      tabBarPosition="bottom"
      screenOptions={{
        tabBarAndroidRipple: { borderless: false },
        tabBarStyle: {
          minHeight: AppStylesConfig.tabbarHeight,
          height: AppStylesConfig.tabbarHeight,
          maxHeight: AppStylesConfig.tabbarHeight,
          backgroundColor:
            appTheme === "dark"
              ? darkTheme.headerBackgroundColor
              : lightTheme.headerBackgroundColor,
        },
        tabBarActiveTintColor: lightTheme.primaryColor,
        tabBarInactiveTintColor:
          appTheme === "dark"
            ? darkTheme.reverseTextColor
            : lightTheme.reverseTextColor,

        tabBarIndicatorStyle: {
          display: "none",
        },
        tabBarLabelStyle: {
          fontSize: px2vw(10),
          marginTop: px2vw(-0.1),
        },
        tabBarIconStyle: {
          display: "flex",
          justifyContent: "center",
          alignItems: "center",
          marginTop: px2vw(-3),
        },
      }}
    >
      <Tab.Screen
        name="index"
        options={{
          title: "首页",
          tabBarShowIcon: true,
          tabBarIcon: ({ focused, color }) => (
            <IconImg focused={focused} color={color} name="index" />
          ),
        }}
        component={SlideHome}
      />
      <Tab.Screen
        name="chat"
        options={{
          title: "微信",
          tabBarShowIcon: true,
          tabBarIcon: ({ focused, color }) => (
            <IconImg focused={focused} color={color} name="chat" />
          ),
        }}
        component={SlideChat}
      />
      {/* <Tab.Screen
        name="transaction"
        options={{
          title: "交易",
          tabBarShowIcon: true,
          tabBarIcon: ({ focused, color }) => (
            <IconImg focused={focused} color={color} name="transaction" />
          ),
        }}
        component={SlideTransaction}
      /> */}
      <Tab.Screen
        name="assets"
        options={{
          title: "资产",
          tabBarShowIcon: true,
          tabBarIcon: ({ focused, color }) => (
            <IconImg focused={focused} color={color} name="assets" />
          ),
        }}
        component={SlideAssets}
      />
      <Tab.Screen
        name="user"
        options={{
          title: "我的",
          tabBarShowIcon: true,
          tabBarIcon: ({ focused, color }) => (
            <IconImg focused={focused} color={color} name="user" />
          ),
        }}
        component={SlideUser}
      />
    </Tab.Navigator>
  );
}

// 首页屏幕
function GalleryScreen() {
  const appTheme = useAppSelector(selectAppTheme);

  return (
    <Tab.Navigator
      initialLayout={{
        width: px2vw(375),
        height: AppStylesConfig.tabbarHeight,
      }}
      tabBarPosition="bottom"
      screenOptions={{
        tabBarStyle: {
          minHeight: AppStylesConfig.tabbarHeight,
          height: AppStylesConfig.tabbarHeight,
          maxHeight: AppStylesConfig.tabbarHeight,
          backgroundColor:
            appTheme === "dark"
              ? darkTheme.headerBackgroundColor
              : lightTheme.headerBackgroundColor,
        },
        tabBarActiveTintColor: lightTheme.primaryColor,
        tabBarInactiveTintColor:
          appTheme === "dark"
            ? darkTheme.reverseTextColor
            : lightTheme.reverseTextColor,
        tabBarLabelStyle: {
          fontSize: px2vw(10),
        },
        tabBarIndicatorStyle: {
          display: "none",
        },
      }}
    >
      <Tab.Screen
        name="gallery"
        options={{
          title: "图片墙",
          tabBarShowIcon: true,
          tabBarIcon: ({ focused, color }) => (
            <IconImg focused={focused} color={color} name="index" />
          ),
        }}
        component={Gallery}
      />
    </Tab.Navigator>
  );
}

const Stack = createNativeStackNavigator();
const Tab = createMaterialTopTabNavigator();
export default function AppInner() {
  return (
    <GestureHandlerRootView style={{ flex: 1 }}>
      <NavigationContainer>
        <Stack.Navigator>
          {/* 首页屏幕 */}
          <Stack.Screen
            name="home"
            component={IndexScreen}
            options={{ headerShown: false }}
          />

          {/* 图片墙 */}
          <Stack.Screen
            name="galleryScreen"
            component={GalleryScreen}
            options={{ headerShown: false }}
          />
          {/* 设置 */}
          <Stack.Screen
            name="setting"
            component={Setting}
            options={{ headerShown: false }}
          />
          {/* 登录 */}
          <Stack.Screen
            name="login"
            component={Login}
            options={{ headerShown: false }}
          />
        </Stack.Navigator>
      </NavigationContainer>
    </GestureHandlerRootView>
  );
}
