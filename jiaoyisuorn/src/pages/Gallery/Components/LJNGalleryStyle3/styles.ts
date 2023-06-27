import { StyleSheet } from "react-native";
import cssConfig from "../cssConfig";

export function setTheme(name: string) {
  return StyleSheet.create({
    ljn_gallery_list: {
      display: "flex",
      flexDirection: "row",
      height: (cssConfig.boxSize + cssConfig.boxGap) * 2,
    },
    ljn_gallery_list_left: {
      flex: 1,
      display: "flex",
      flexWrap: "wrap",
      flexDirection: "row",
      justifyContent: "flex-start",
      height: cssConfig.boxSize * 2 + cssConfig.boxGap,
    },
    ljn_gallery_item_video: {
      width: cssConfig.boxSize,
      height: cssConfig.boxSize * 2 + cssConfig.boxGap,
      position: "absolute",
      objectFit: "cover",
    },
    ljn_gallery_list_right: {
      marginRight: cssConfig.boxGap,
      flexBasis: cssConfig.boxSize,
      height: cssConfig.boxSize * 2 + cssConfig.boxGap,
    },
    ljn_gallery_item: {
      height: cssConfig.boxSize,
      flexBasis: cssConfig.boxSize,
      marginLeft: cssConfig.boxGap,
      marginBottom: cssConfig.boxGap,
    },
    ljn_gallery_item_image: {
      width: cssConfig.boxSize,
      height: "100%",
    },
  });
}
