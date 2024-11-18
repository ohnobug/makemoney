import { Dimensions, StyleSheet } from "react-native";
import darkTheme from "themes/default/styles";
import lightTheme from "themes/light/styles";

const window = Dimensions.get("window");
export function setTheme(name: string) {
  let theme: ITheme;
  if (name === "dark") {
    theme = darkTheme;
  } else {
    theme = lightTheme;
  }

  return StyleSheet.create({
    ljn_main: {
      flex: 1,
      backgroundColor: theme.backgroundColor,
      maxHeight: window.height,
    },
  });
}
