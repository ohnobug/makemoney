import { StyleSheet } from "react-native";
import darkTheme from "themes/default/styles";
import lightTheme from "themes/light/styles";
import { px2vw } from "utils/utils";

export function setTheme(name: string) {
  let theme: ITheme;
  if (name === "dark") {
    theme = darkTheme;
  } else {
    theme = lightTheme;
  }

  return StyleSheet.create({
    ljn_emptyblock: {
      // backgroundColor: "red",
      width: px2vw(220),
      marginLeft: "auto",
      marginRight: "auto",
      display: "flex",
      marginTop: px2vw(50),
    },

    ljn_emptyblock_row1: {
      flexBasis: px2vw(85),
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
    },
    ljn_emptyblock_row1_img: {
      width: px2vw(80),
      height: px2vw(80),
    },
    ljn_emptyblock_row2: {
      flexBasis: px2vw(50),
    },
    ljn_emptyblock_row2_text: {
      textAlign: "center",
      color: theme.textColor,
    },
    ljn_emptyblock_row3: {
      flex: 1,
      width: px2vw(160),
      marginLeft: "auto",
      marginRight: "auto",
    },
  });
}
