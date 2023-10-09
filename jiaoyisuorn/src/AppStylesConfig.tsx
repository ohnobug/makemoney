import { Text, View } from "react-native";
import darkTheme from "themes/default/styles";
import lightTheme from "themes/light/styles";
import { px2vw } from "./utils/utils";
import { MaterialTopTabNavigationOptions } from "@react-navigation/material-top-tabs";

const TABBARHEIGHT = px2vw(50);

export default {
  // 顶部的高度
  headerHeight: px2vw(42),
  // tabbar高度
  tabbarHeight: TABBARHEIGHT,

  // tabbar配置
  tabbarConfig: (appTheme: string): MaterialTopTabNavigationOptions => {
    return {
      lazyPlaceholder: () => {
        return (
          <View
            style={{
              display: "flex",
              flex: 1,
              justifyContent: "center",
              alignItems: "center",
            }}
          >
            <Text
              style={{
                color:
                  appTheme === "dark"
                    ? darkTheme.textColor
                    : lightTheme.textColor,
              }}
            >
              加载中...
            </Text>
          </View>
        );
      },
      lazy: true,
      tabBarAndroidRipple: { borderless: false },
      tabBarStyle: {
        minHeight: TABBARHEIGHT,
        height: TABBARHEIGHT,
        maxHeight: TABBARHEIGHT,
        borderTopWidth: px2vw(0.5),
        borderTopColor:
          appTheme === "dark"
            ? darkTheme.headerBorderBottomColor
            : lightTheme.headerBorderBottomColor,
        backgroundColor:
          appTheme === "dark"
            ? darkTheme.tabbarBackgroundColor
            : lightTheme.tabbarBackgroundColor,
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
        marginTop: px2vw(-0.3),
      },
      tabBarIconStyle: {
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
        marginTop: px2vw(-8),
      },
    };
  },
};
