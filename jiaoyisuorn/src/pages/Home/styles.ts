import { StyleSheet, Dimensions } from "react-native";
import { px2vw } from "../../utils/utils";
import darkTheme from "../../themes/default/styles";
import lightTheme from "../../themes/light/styles";
import AppStylesConfig from "../../AppStylesConfig";

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
      flex: 0,
      minHeight: px2vw(AppStylesConfig.tabbarHeight),
    },
  });
}
