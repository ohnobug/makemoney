import { StyleSheet } from "react-native";
import darkTheme from "../../themes/default/styles";
import lightTheme from "../../themes/light/styles";
import { px2vw } from "../../utils/utils";

export function setTheme(name: string) {
  let theme: ITheme;
  if (name === "dark") {
    theme = darkTheme;
  } else {
    theme = lightTheme;
  }

  return StyleSheet.create({
    ljn_button: {
      flex: 0,
      width: "100%",
      minHeight: px2vw(47),
      backgroundColor: "#0094ff",
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      borderRadius: px2vw(5),
    },
    ljn_button_text: {
      color: "white",
      fontSize: px2vw(16),
    },
  });
}
