import { StyleSheet } from "react-native";
import { px2vw } from "utils/utils";
import darkTheme from "themes/default/styles";
import lightTheme from "themes/light/styles";

export function setTheme(name: string) {
  let theme: ITheme;
  if (name === "dark") {
    theme = darkTheme;
  } else {
    theme = lightTheme;
  }

  return StyleSheet.create({
    container: {
      width: "100%",
      height: px2vw(160),
      backgroundColor: theme.areaBackgroundColor,
    },
    ljn_slide: {
      flex: 1,
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
    },
    ljn_slide_image: {
      width: "100%",
      height: "100%",
    },
  });
}
