import { createMaterialTopTabNavigator } from "@react-navigation/material-top-tabs";
import { NavigationContainer } from "@react-navigation/native";
import { createStackNavigator } from "@react-navigation/stack";
import Gallery from "pages/Gallery";
import Login from "pages/Login";
import Setting from "pages/Setting";
import SlideAssets from "pages/SlideAssets";
import SlideChat from "pages/SlideChat";
import SlideContract from "pages/SlideContract";
import SlideHome from "pages/SlideHome";
import SlideTransaction from "pages/SlideTransaction";
import SlideUser from "pages/SlideUser";
import React from "react";
import { GestureHandlerRootView } from "react-native-gesture-handler";

// 首页屏幕
function IndexScreen() {
  return (
    <Tab.Navigator tabBarPosition="bottom">
      <Tab.Screen
        name="index"
        options={{ title: "首页" }}
        component={SlideHome}
      />
      <Tab.Screen
        name="chat"
        options={{ title: "微信" }}
        component={SlideChat}
      />
      <Tab.Screen
        name="contract"
        options={{ title: "合约" }}
        component={SlideContract}
      />
      <Tab.Screen
        name="transaction"
        options={{ title: "交易" }}
        component={SlideTransaction}
      />
      <Tab.Screen
        name="assets"
        options={{ title: "资产" }}
        component={SlideAssets}
      />
      <Tab.Screen
        name="user"
        options={{ title: "我的" }}
        component={SlideUser}
      />
    </Tab.Navigator>
  );
}

const Stack = createStackNavigator();
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
            name="gallery"
            component={Gallery}
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
