import { StyleSheet } from "react-native";
import { px2vw } from "../../../../utils/utils";
import cssConfig from "../cssConfig";

export function setTheme(name: string) {
  return StyleSheet.create({
    ljn_gallery_list: {
      display: "flex",
      // backgroundColor: "red",
      flexDirection: "row",
      justifyContent: "flex-start",
      flexWrap: "wrap",
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
    ljn_footer: {
      flex: 0,
      minHeight: px2vw(60),
    },
  });
}
