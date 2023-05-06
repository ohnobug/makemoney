import { StyleSheet } from "react-native";
import { px2vw } from "../../../../utils/utils";
import cssConfig from "../cssConfig";
import AppStylesConfig from "../../../../AppStylesConfig";

export function setTheme(name: string) {
  return StyleSheet.create({
    ljn_gallery_list: {
      display: "flex",
      flexDirection: "row",
    },

    ljn_gallery_list_left: {
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
      width: "100%",
      height: "100%",
    },

    ljn_gallery_list_right: {
      flexBasis: cssConfig.boxSize,
      height: cssConfig.boxSize * 2 + cssConfig.boxGap,
      marginRight: cssConfig.boxGap,
    },
    ljn_gallery_list_right_image: {
      width: "100%",
      height: "100%",
    },
    ljn_footer: {
      flex: 0,
      minHeight: AppStylesConfig.tabbarHeight,
    },
  });
}
