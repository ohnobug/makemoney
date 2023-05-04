import { StyleSheet, Dimensions } from "react-native";
import { px2vw } from "../../utils/utils";
import darkTheme from "../../themes/default/styles";
import lightTheme from "../../themes/light/styles";

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
      paddingBottom: px2vw(20),
      maxHeight: window.height - px2vw(60),
    },
    ljn_gallery_list: {
      display: "flex",
      // backgroundColor: "red",
      flexDirection: "row",
      justifyContent: "flex-start",
      flexWrap: "wrap",
    },
    ljn_gallery_item: {
      height: px2vw(123.66),
      padding: px2vw(1),
      flexBasis: px2vw(123.66),
    },
    ljn_gallery_item_image: {
      width: "100%",
      height: "100%",
    },
    ljn_footer: {
      minHeight: px2vw(60),
    },
  });
}
