import {
  MaterialTopTabNavigationOptions,
  createMaterialTopTabNavigator,
} from "@react-navigation/material-top-tabs";
import { NavigationContainer } from "@react-navigation/native";
// import { createStackNavigator } from "@react-navigation/stack";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import AppStylesConfig from "AppStylesConfig";
import { useAppSelector } from "hooks";
import Gallery from "pages/Gallery";
import ChatMessage from "pages/ChatMessage";
import Login from "pages/Login";
import Setting from "pages/Setting";
import SlideAssets from "pages/SlideAssets";
import SlideChat from "pages/SlideChat";
import SlideHome from "pages/SlideHome";
import SlideUser from "pages/SlideUser";
import { Image } from "react-native";
import { selectAppTheme } from "store/SystemSlice";
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
  const screenOptions: MaterialTopTabNavigationOptions =
    AppStylesConfig.tabbarConfig(appTheme) as MaterialTopTabNavigationOptions;

  return (
    <Tab.Navigator
      backBehavior="none"
      initialLayout={{
        width: px2vw(375),
        height: AppStylesConfig.tabbarHeight,
      }}
      tabBarPosition="bottom"
      screenOptions={screenOptions}
    >
      <Tab.Screen
        name="chat"
        options={{
          title: "幂信",
          tabBarShowIcon: true,
          tabBarIcon: ({ focused, color }) => (
            <IconImg focused={focused} color={color} name="index" />
          ),
        }}
        component={SlideChat}
      />
      <Tab.Screen
        name="index"
        options={{
          title: "交易所",
          tabBarShowIcon: true,
          tabBarIcon: ({ focused, color }) => (
            <IconImg focused={focused} color={color} name="chat" />
          ),
        }}
        component={SlideHome}
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
  const screenOptions: MaterialTopTabNavigationOptions =
    AppStylesConfig.tabbarConfig(appTheme) as MaterialTopTabNavigationOptions;

  return (
    <Tab.Navigator
      initialLayout={{
        width: px2vw(375),
        height: AppStylesConfig.tabbarHeight,
      }}
      tabBarPosition="bottom"
      screenOptions={screenOptions}
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

export default () => {
  return (
    <NavigationContainer>
      <Stack.Navigator>
        {/* 聊天窗口 */}
        {/* <Stack.Screen
          name="chatMessage"
          component={ChatMessage}
          options={{ headerShown: false }}
        /> */}

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
  );
};
