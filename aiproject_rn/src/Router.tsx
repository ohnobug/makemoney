import {
  MaterialTopTabNavigationOptions,
  createMaterialTopTabNavigator,
} from "@react-navigation/material-top-tabs";
import { NavigationContainer } from "@react-navigation/native";
// import { createStackNavigator } from "@react-navigation/stack";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import AppStylesConfig from "AppStylesConfig";
import { useAppSelector } from "hooks";
import Services from "pages/Services"
import ChatMessage from "pages/ChatMessage";
import Gallery from "pages/Gallery";
import Login from "pages/Login";
import Setting from "pages/Setting";
import SlideAssets from "pages/SlideAssets";
import SlideChat from "pages/SlideChat";
import SlideHome from "pages/SlideHome";
import SlideUser from "pages/SlideUser";

import { useEffect, useState } from "react";
import {
  Animated,
  Image,
  StyleSheet,
  TouchableOpacity,
  View,
} from "react-native";
import { selectAppTheme } from "store/SystemSlice";
import { px2vw } from "utils/utils";
import { setTheme } from "./TabbarStyles";

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

  gallery: [
    require("assets/images/nav6icon.png"),
    require("assets/images/nav2icon.png"),
  ],
};

function MyTabBar({ state, descriptors, navigation, position }) {
  const theme = useAppSelector(selectAppTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
  }, [theme]);

  return (
    <View style={styles.ljn_tabbar}>
      {state.routes.map((route, index) => {
        const { options } = descriptors[route.key];
        const label =
          options.tabBarLabel !== undefined
            ? options.tabBarLabel
            : options.title !== undefined
            ? options.title
            : route.name;

        const isFocused = state.index === index;

        const onPress = () => {
          const event = navigation.emit({
            type: "tabPress",
            target: route.key,
            canPreventDefault: true,
          });

          if (!isFocused && !event.defaultPrevented) {
            // The `merge: true` option makes sure that the params inside the tab screen are preserved
            navigation.navigate({ name: route.name, merge: true });
          }
        };

        const onLongPress = () => {
          navigation.emit({
            type: "tabLongPress",
            target: route.key,
          });
        };

        // const inputRange = state.routes.map((_, i) => i);
        // const opacity = position.interpolate({
        //   inputRange,
        //   outputRange: inputRange.map((i) => (i === index ? 1 : 0.5)),
        // });

        // console.log(options);

        return (
          <TouchableOpacity
            key={index}
            accessibilityRole="button"
            accessibilityState={isFocused ? { selected: true } : {}}
            accessibilityLabel={options.tabBarAccessibilityLabel}
            testID={options.tabBarTestID}
            onPress={onPress}
            onLongPress={onLongPress}
            style={styles.ljn_tabbar_item}
          >
            <View style={styles.ljn_tabbar_item_img_area}>
              <Image
                source={
                  isFocused ? navIcons[route.name][0] : navIcons[route.name][1]
                }
                style={styles.ljn_tabbar_item_img}
              />
            </View>
            <View style={styles.ljn_tabbar_item_title_area}>
              <Animated.Text
                style={StyleSheet.flatten([
                  styles.ljn_tabbar_item_title,
                  isFocused ? styles.ljn_tabbar_item_title_active : {},
                ])}
              >
                {label}
              </Animated.Text>
            </View>
          </TouchableOpacity>
        );
      })}
    </View>
  );
}

// 首页屏幕
function IndexScreen() {
  const appTheme = useAppSelector(selectAppTheme);
  const screenOptions: MaterialTopTabNavigationOptions =
    AppStylesConfig.tabbarConfig(appTheme) as MaterialTopTabNavigationOptions;

  return (
    <Tab.Navigator
      tabBar={(props) => <MyTabBar {...props} />}
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
          title: "微信",
          tabBarShowIcon: true,
        }}
        component={SlideChat}
      />

      <Tab.Screen
        name="index"
        options={{
          title: "通讯录",
          tabBarShowIcon: true,
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
          title: "发现",
          tabBarShowIcon: true,
        }}
        component={SlideAssets}
      />
      <Tab.Screen
        name="user"
        options={{
          title: "我",
          tabBarShowIcon: true,
        }}
        component={SlideUser}
      />
    </Tab.Navigator>
  );
}

// 图墙屏幕
function GalleryScreen() {
  const appTheme = useAppSelector(selectAppTheme);
  const screenOptions: MaterialTopTabNavigationOptions =
    AppStylesConfig.tabbarConfig(appTheme) as MaterialTopTabNavigationOptions;

  return (
    <Tab.Navigator
      // initialLayout={{
      //   width: px2vw(375),
      //   height: AppStylesConfig.tabbarHeight,
      // }}
      // tabBarPosition="bottom"
      // screenOptions={screenOptions}

      tabBar={(props) => <MyTabBar {...props} />}
      backBehavior="none"
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
      <Stack.Navigator
        screenOptions={{
          animationTypeForReplace: "push",
          animation: "slide_from_right",
        }}
      >
        {/* 首页屏幕 */}
        <Stack.Screen
          name="home"
          component={IndexScreen}
          options={{ headerShown: false }}
        />

        {/* 聊天窗口 */}
        <Stack.Screen
          name="chatMessage"
          options={{ headerShown: false }}
          component={ChatMessage}
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

        {/* 服务 */}
        <Stack.Screen
          name="services"
          component={Services}
          options={{ headerShown: false }}
        />
      </Stack.Navigator>
    </NavigationContainer>
  );
};
