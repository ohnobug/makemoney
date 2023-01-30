import { StyleSheet } from "react-native";
import { px2vw } from "../../../../utils/utils";
import darkTheme from "../../../../themes/default/styles";
import lightTheme from "../../../../themes/light/styles";

export function setTheme(name: string) {
  let theme: ITheme;
  if (name === "dark") {
    theme = darkTheme;
  } else {
    theme = lightTheme;
  }

  return StyleSheet.create({
    ljn_container: {
      display: "flex",
      flexDirection: "row",
      flexWrap: "wrap",
      backgroundColor: theme.areaBackgroundColor,
      height: px2vw(160),
      borderRadius: px2vw(10),
      marginBottom: px2vw(10),
    },
    ljn_container_area_1: {
      paddingTop: px2vw(10),
      paddingBottom: px2vw(13),
      paddingLeft: px2vw(17),
      paddingRight: px2vw(17),
      flex: 1,
      flexBasis: px2vw(186.5),
      height: px2vw(80),
      borderBottomWidth: px2vw(1),
      borderBottomColor: theme.borderColor,
      borderRightWidth: px2vw(1),
      borderRightColor: theme.borderColor,
      display: "flex",
      flexDirection: "row",
    },
    ljn_container_area_2: {
      paddingTop: px2vw(10),
      paddingBottom: px2vw(13),
      paddingLeft: px2vw(17),
      paddingRight: px2vw(17),
      flex: 1,
      flexBasis: px2vw(187.5),
      height: px2vw(80),
      borderBottomWidth: px2vw(1),
      borderBottomColor: theme.borderColor,
      display: "flex",
      flexDirection: "row",
    },
    ljn_container_area_3: {
      paddingTop: px2vw(10),
      paddingBottom: px2vw(13),
      paddingLeft: px2vw(17),
      paddingRight: px2vw(17),
      flex: 1,
      flexBasis: px2vw(186.5),
      height: px2vw(80),
      borderRightWidth: px2vw(1),
      borderRightColor: theme.borderColor,
      display: "flex",
      flexDirection: "row",
    },
    ljn_container_area_4: {
      paddingTop: px2vw(10),
      paddingBottom: px2vw(13),
      paddingLeft: px2vw(17),
      paddingRight: px2vw(17),
      flex: 1,
      flexBasis: px2vw(187.5),
      height: px2vw(80),
      display: "flex",
      flexDirection: "row",
      position: "relative",
    },

    ljn_function_left_area: {
      flex: 1,
    },
    ljn_function_area_title1: {
      marginBottom: px2vw(5),
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
    },
    ljn_function_area_title1_inner: {
      color: theme.titleTextColor,
      fontWeight: "600",
      fontSize: px2vw(12),
      // height: px2vw(14),
    },
    ljn_function_area_title1_inner2: {
      color: "#dc731a",
      marginLeft: px2vw(5),
      paddingTop: px2vw(2),
      paddingBottom: px2vw(2),
      paddingLeft: px2vw(8),
      paddingRight: px2vw(8),
      fontSize: px2vw(9),
      backgroundColor: "#232432",
      fontStyle: "italic",
      // top: px2vw(0),
      // position: "absolute",
      // left: px2vw(24),
      borderRadius: px2vw(2),
    },
    ljn_function_area_title2: {
      marginBottom: px2vw(5),
    },
    ljn_function_area_title2_inner: {
      color: theme.reverseTextColor,
      fontWeight: "600",
      fontSize: px2vw(14),
      height: px2vw(18),
    },
    ljn_function_area_title3: {
      // marginBottom: px2vw(5),
    },
    ljn_function_area_title3_inner: {
      color: theme.titleTextColor,
      fontSize: px2vw(10),
      height: px2vw(14),
    },

    ljn_function_right_area: {
      flex: 0,
      flexBasis: px2vw(45),
      // height: px2vw(45),
      display: "flex",
      flexDirection: "row",
      justifyContent: "flex-end",
      alignItems: "center",
    },
    ljn_function_right_area_img_inner: {
      width: px2vw(38),
      height: px2vw(38),
    },
  });
}
