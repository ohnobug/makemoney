import { StyleSheet } from "react-native";
import { px2vw } from "../../../../utils/utils";
import darkTheme from "../../../../themes/default/styles";
import lightTheme from "../../../../themes/light/styles";

export function setTheme(name: string) {
  let theme: any;
  if (name === "dark") {
    theme = darkTheme;
  } else {
    theme = lightTheme;
  }

  return StyleSheet.create({
    container: {
      width: px2vw(375),
      height: px2vw(160),
      backgroundColor: theme.areaBackgroundColor,
    },
    slide1: {
      flex: 1,
      justifyContent: "center",
      alignItems: "center",
      backgroundColor: "#9DD6EB",
    },
    image: {
      width: "100%",
      height: "100%",
    },
  });
}
