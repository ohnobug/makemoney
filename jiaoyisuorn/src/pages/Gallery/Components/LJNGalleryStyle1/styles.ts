import { StyleSheet } from "react-native";
import { px2vw } from "../../../../utils/utils";

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
      height: px2vw(123.665),
      flexBasis: px2vw(123.665),
      marginLeft: px2vw(1),
      marginBottom: px2vw(1),
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
