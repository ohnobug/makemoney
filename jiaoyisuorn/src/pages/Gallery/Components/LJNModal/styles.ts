import { StyleSheet } from "react-native";
import { px2vw } from "../../../../utils/utils";

export function setTheme(name: string) {
  return StyleSheet.create({
    ljn_modal_container: {
      flex: 1,
      backgroundColor: "#ffffff94",
      zIndex: 99999999999,
      position: "absolute",
      top: 0,
      left: 0,
      width: px2vw(375),
      height: "100%",
    },
    ljn_modal_box: {
      width: px2vw(320),
      height: px2vw(370),
      backgroundColor: "black",
      position: "absolute",
      zIndex: 99999,
      left: px2vw(375 / 2 - 320 / 2),
      top: px2vw(375 / 2 - 320 / 2),
      display: "flex",
      flexDirection: "column",
      justifyContent: "center",
      alignItems: "center",
      borderRadius: px2vw(5),
    },
    ljn_modal_photo_box: {
      flex: 1,
      // backgroundColor: "blue",
      display: "flex",
      justifyContent: "center",
      alignContent: "center",
    },
    ljn_modal_photo_box_photo: {
      width: px2vw(300),
      height: px2vw(300),
    },
    ljn_modal_title_box: {
      width: px2vw(300),
      flexBasis: px2vw(40),
      marginBottom: px2vw(10),
      // backgroundColor: "green",
      display: "flex",
      flexDirection: "row",
      justifyContent: "center",
      // alignContent: "center",
    },
    ljn_modal_title_inner: {
      color: "white",
      fontSize: px2vw(24),
    },
  });
}
