import { StyleSheet } from "react-native";
import cssConfig from "../cssConfig";

export function setTheme(name: string) {
  return StyleSheet.create({
    ljn_gallery_list: {
      display: "flex",
      flexDirection: "row",
    },
    ljn_gallery_list_left: {
      marginLeft: cssConfig.boxGap,
      flexBasis: cssConfig.boxSize,
      height: cssConfig.boxSize * 2 + cssConfig.boxGap,
    },
    ljn_gallery_list_left_item: {
      height: cssConfig.boxSize * 2 + cssConfig.boxGap,
    },
    ljn_gallery_item_video: {
      width: cssConfig.boxSize,
      height: cssConfig.boxSize * 2 + cssConfig.boxGap,
      position: "relative",
      objectFit: "cover",
    },
    ljn_gallery_list_left_image: {
      width: "100%",
      height: "100%",
    },
    ljn_gallery_list_right: {
      flex: 1,
      display: "flex",
      flexWrap: "wrap",
      flexDirection: "row",
      justifyContent: "flex-start",
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
