import { StyleSheet, Dimensions } from "react-native";
import { px2vw } from "utils/utils";
import darkTheme from "themes/default/styles";
import lightTheme from "themes/light/styles";
import AppStylesConfig from "AppStylesConfig";

const window = Dimensions.get("window");
export function setTheme(name: string) {
  let theme: ITheme;
  if (name === "dark") {
    theme = darkTheme;
  } else {
    theme = lightTheme;
  }

  return StyleSheet.create({
    // container: {
    //   flex: 1,
    //   display: "flex",
    //   flexDirection: "column",
    // },
    ljn_main: {
      flex: 1,
      backgroundColor: theme.backgroundColor,
      maxHeight: window.height - AppStylesConfig.tabbarHeight,
    },
    ljn_footer: {
      flex: 0,
      minHeight: AppStylesConfig.tabbarHeight,
    },
  });
}
