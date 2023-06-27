import { StyleSheet } from "react-native";
import cssConfig from "../cssConfig";

export function setTheme(name: string) {
  return StyleSheet.create({
    ljn_gallery_list: {
      display: "flex",
      flexDirection: "row",
      justifyContent: "flex-start",
      flexWrap: "wrap",
      height: (cssConfig.boxSize + cssConfig.boxGap) * 2,
    },
    ljn_gallery_item: {
      height: cssConfig.boxSize,
      flexBasis: cssConfig.boxSize,
      marginLeft: cssConfig.boxGap,
      marginBottom: cssConfig.boxGap,
    },
    ljn_gallery_item_image: {
      width: cssConfig.boxSize,
      height: cssConfig.boxSize,
    },
  });
}
