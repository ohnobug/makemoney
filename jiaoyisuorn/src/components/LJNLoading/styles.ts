import { StyleSheet, Dimensions } from "react-native";
import { px2vw } from "../../utils/utils";
import darkTheme from "../../themes/default/styles";
import lightTheme from "../../themes/light/styles";

export function setTheme(name: string) {
  let theme: any;
  if (name === "dark") {
    theme = darkTheme;
  } else {
    theme = lightTheme;
  }

  return StyleSheet.create({
    ljn_container: {
      flex: 1,
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
    },
    ljn_container_text: {
      color: theme.textColor,
    },
  });
}
