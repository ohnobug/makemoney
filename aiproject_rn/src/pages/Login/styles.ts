import { StyleSheet } from "react-native";
import { px2vw } from "utils/utils";
import darkTheme from "themes/default/styles";
import lightTheme from "themes/light/styles";

export function setTheme(name: string) {
  let theme: ITheme;
  if (name === "dark") {
    theme = darkTheme;
  } else {
    theme = lightTheme;
  }

  return StyleSheet.create({
    ljn_container: {
      flex: 1,
      display: "flex",
      flexDirection: "column",
      backgroundColor: theme.backgroundColor,
    },
    ljn_main: {
      paddingRight: px2vw(17),
      paddingBottom: px2vw(17),
      paddingLeft: px2vw(17),
    },
    ljn_login_title: {
      height: px2vw(95),
      display: "flex",
      alignItems: "flex-start",
      justifyContent: "center",
    },
    ljn_login_title_text: {
      fontSize: px2vw(28),
      fontWeight: "600",
      color: theme.textColor,
    },

    ljn_login_form_area: {},
    ljn_login_form: {
      display: "flex",
      height: px2vw(200),
      marginBottom: px2vw(50),
    },
    ljn_login_form_row1: {
      flexBasis: px2vw(80),
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
    },
    ljn_login_form_row1_input: {
      backgroundColor: theme.areaBackgroundColor,
      height: px2vw(47),
      borderRadius: px2vw(5),
      flex: 1,
      paddingLeft: px2vw(25),
      paddingRight: px2vw(25),
      color: theme.textColor,
      fontSize: px2vw(16),
      fontWeight: "600",
    },
    ljn_login_form_row2: {
      flex: 1,
      display: "flex",
      alignItems: "center",
      justifyContent: "center",
    },
    ljn_login_form_row3: {
      flex: 1,
      display: "flex",
      alignItems: "center",
      justifyContent: "center",
    },
    ljn_login_form_row3_text: {
      // color: theme.primaryColor,
    },

    ljn_other_login_style: {
      marginTop: px2vw(20),
      display: "flex",
      flexDirection: "row",
      justifyContent: "space-around",
      marginBottom: px2vw(20),
    },
    ljn_other_login_style_item: {
      height: px2vw(80),
    },
    ljn_other_login_logo: {
      flexBasis: px2vw(50),
      display: "flex",
      alignItems: "center",
      justifyContent: "center",
    },
    ljn_other_login_logo_img: {
      width: px2vw(40),
      height: px2vw(40),
    },
    ljn_other_login_title: {
      flex: 1,
      display: "flex",
      alignItems: "center",
      justifyContent: "center",
    },
    ljn_other_login_title_text: {
      color: theme.textColor,
    },

    ljn_tips_text: {
      display: "flex",
      flexDirection: "row",
      justifyContent: "center",
    },
    ljn_user_tips_text: {
      color: theme.titleTextColor,
      fontSize: px2vw(12),
    },
    ljn_user_agreement: {
      fontSize: px2vw(12),
    },
  });
}
