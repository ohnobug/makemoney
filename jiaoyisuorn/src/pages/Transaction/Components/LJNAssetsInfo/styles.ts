import { Dimensions, StyleSheet } from "react-native";
import { px2vw } from "../../../../utils/utils";
import darkTheme from "../../../../themes/default/styles";
import lightTheme from "../../../../themes/light/styles";

const window = Dimensions.get("window");
export function setTheme(name: string) {
  let theme: ITheme;
  if (name === "dark") {
    theme = darkTheme;
  } else {
    theme = lightTheme;
  }

  return StyleSheet.create({
    ljn_container: {
      height: px2vw(350),
      backgroundColor: theme.areaBackgroundColor,
      display: "flex",
      flexDirection: "column",
    },
    // 资产、历史信息
    ljn_assets_history_info: {
      backgroundColor: theme.areaBackgroundColor,
    },
  });
}
