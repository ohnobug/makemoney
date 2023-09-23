import AppStylesConfig from "AppStylesConfig";
import { Dimensions, StyleSheet } from "react-native";
import darkTheme from "themes/default/styles";
import lightTheme from "themes/light/styles";

export function setTheme(name: string) {
  let theme: ITheme;

  if (name === "dark") {
    theme = darkTheme;
  } else {
    theme = lightTheme;
  }

  const window = Dimensions.get("window");
  return StyleSheet.create({
    container: {
      flex: 1,
      display: "flex",
      flexDirection: "column",
      backgroundColor: theme.chatBackgroundColor,
    },
    ljn_main: {
      flex: 1,
      maxHeight:
        window.height -
        AppStylesConfig.tabbarHeight -
        AppStylesConfig.headerHeight,
    },
  });
}
