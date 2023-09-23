import { Dimensions, StyleSheet } from "react-native";
import AppStylesConfig from "../../AppStylesConfig";
import darkTheme from "themes/default/styles";
import lightTheme from "themes/light/styles";
import { px2vw } from "utils/utils";

const window = Dimensions.get("window");
export function setTheme(name: string) {
  let theme: ITheme;
  if (name === "dark") {
    theme = darkTheme;
  } else {
    theme = lightTheme;
  }

  return StyleSheet.create({
    container: {
      flex: 1,
      display: "flex",
      flexDirection: "column",
      backgroundColor: theme.backgroundColor,
    },
    ljn_main: {
      flex: 1,
      maxHeight: window.height - px2vw(AppStylesConfig.tabbarHeight),
    },
    ljn_footer: {
      minHeight: px2vw(AppStylesConfig.tabbarHeight),
    },
  });
}
