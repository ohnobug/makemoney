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
      height: px2vw(488),
      backgroundColor: theme.areaBackgroundColor,
      marginBottom: px2vw(10),
    },
    ljn_header: {
      height: px2vw(50),
      display: "flex",
      flexDirection: "row",
      paddingTop: px2vw(17),
      paddingLeft: px2vw(17),
      paddingRight: px2vw(17),
      paddingBottom: px2vw(0),
      // backgroundColor: theme.areaBackgroundColor,
      // backgroundColor: "red",
      color: theme.textColor,
    },
    ljn_header_left: {
      flex: 1,
      display: "flex",
      flexDirection: "row",
      justifyContent: "flex-start",
    },
    ljn_header_left_1: {
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      marginRight: px2vw(17),
    },
    ljn_header_left_1_text_active: {
      color: theme.textColor,
    },
    ljn_header_left_1_text: {
      fontSize: px2vw(16),
      // fontWeight: "600",
      color: name === "dark" ? "#999" : "black",
    },
    ljn_header_right: {
      flex: 1,
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "flex-end",
    },

    // 买卖操作
    ljn_trade_operation: {
      height: px2vw(438),
      display: "flex",
      flexDirection: "row",
      backgroundColor: theme.areaBackgroundColor,
    },
    ljn_trade_operation_left: {
      flexBasis: px2vw(230),
      // backgroundColor: "red",
      paddingLeft: px2vw(17),
      paddingRight: px2vw(17),
    },

    ljn_trade_operation_left_title_area: {
      height: px2vw(45),
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
    },
    ljn_trade_operation_left_title_area_icon: {
      marginRight: px2vw(5),
    },
    ljn_trade_operation_left_title_area_text1: {
      fontSize: px2vw(20),
      color: theme.textColor,
      marginRight: px2vw(10),
    },
    ljn_trade_operation_left_title_area_text2: {
      fontSize: px2vw(12),
      color: "red",
    },

    ljn_trade_operation_buysell_buttons: {
      display: "flex",
      flexDirection: "row",
      height: px2vw(36),
      marginBottom: px2vw(10),
    },
    ljn_trade_operation_buysell_buy: {
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      flex: 1,
      backgroundColor: "#12b298",
      borderTopLeftRadius: px2vw(3),
      borderBottomLeftRadius: px2vw(3),
    },
    ljn_trade_operation_buysell_buy_text: {
      color: theme.textColor,
      fontSize: px2vw(14),
      fontWeight: "600",
    },
    ljn_trade_operation_buysell_sell: {
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      flex: 1,
      backgroundColor: theme.areaBackgroundColor,
      borderTopRightRadius: px2vw(3),
      borderBottomRightRadius: px2vw(3),
    },
    ljn_trade_operation_buysell_sell_text: {
      color: theme.textColor,
      fontSize: px2vw(14),
      fontWeight: "600",
    },

    // 近似值
    ljn_trade_operation_about_value: {
      marginBottom: px2vw(10),
    },
    ljn_trade_operation_about_value_text: {
      color: theme.titleTextColor,
      fontSize: px2vw(12),
    },

    // 快速选择
    ljn_trade_operation_percentage_selector: {
      display: "flex",
      flexDirection: "row",
      justifyContent: "space-around",
      marginBottom: px2vw(10),
    },
    ljn_trade_operation_percentage_selector_button: {
      paddingTop: px2vw(3),
      paddingBottom: px2vw(3),
      paddingLeft: px2vw(10),
      paddingRight: px2vw(10),
      backgroundColor: theme.backgroundColor,
      borderRadius: px2vw(3),
    },
    ljn_trade_operation_percentage_selector_button_text: {
      color: theme.textColor,
      fontSize: px2vw(12),
      transform: [{ scale: 0.9 }],
    },

    // 操作输入框
    ljn_trade_operation_input: {
      backgroundColor: theme.backgroundColor,
      height: px2vw(42),
      borderRadius: px2vw(5),
      paddingLeft: px2vw(10),
      paddingRight: px2vw(10),
      color: theme.textColor,
      fontSize: px2vw(14),
      fontWeight: "600",
      marginBottom: px2vw(10),
    },

    // 可用
    ljn_trade_balance_area: {
      display: "flex",
      flexDirection: "row",
      justifyContent: "space-between",
      height: px2vw(28),
      alignItems: "center",
      marginBottom: px2vw(10),
    },
    ljn_trade_balance_area_title: {
      color: theme.titleTextColor,
      borderBottomColor: theme.titleTextColor,
      borderBottomWidth: px2vw(1),
      borderStyle: "dashed",
    },
    ljn_trade_balance_area_value: {
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "flex-end",
    },
    ljn_trade_balance_area_value_text1: {
      color: theme.textColor,
      marginRight: px2vw(5),
    },
    ljn_trade_balance_area_value_text2: {
      color: theme.textColor,
      marginRight: px2vw(5),
    },

    // 倍速与标题
    ljn_trade_operation_right: {
      flex: 1,
      // backgroundColor: "yellow",
    },

    // 倍速
    ljn_trade_operation_right_title_area: {
      height: px2vw(45),
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "space-around",
    },
    ljn_trade_operation_right_title_button: {
      width: px2vw(57),
      height: px2vw(25),
      display: "flex",
      alignItems: "center",
      justifyContent: "center",
      backgroundColor: theme.areaBackgroundColor,
      borderRadius: px2vw(3),
    },
    ljn_trade_operation_right_title_button_text: {
      color: theme.textColor,
      fontSize: px2vw(12),
    },

    // 标题
    ljn_trade_operation_right_float_title_area: {
      display: "flex",
      flexDirection: "row",
      justifyContent: "space-between",
      height: px2vw(30),
      alignItems: "center",
    },
    ljn_trade_operation_right_float_title: {
      flex: 1,
      textAlign: "center",
    },
    ljn_trade_operation_right_float_title_text: {
      color: theme.titleTextColor,
    },

    // 浮动数据
    ljn_trade_operation_right_float_data_area: {
      display: "flex",
      flexDirection: "row",
      justifyContent: "space-between",
      height: px2vw(25),
      alignItems: "center",
      position: "relative",
    },
    ljn_trade_operation_right_float_data_background: {
      height: px2vw(25),
      position: "absolute",
      right: 0,
    },
    ljn_trade_operation_right_float_data: {
      flex: 1,
      textAlign: "left",
    },
    ljn_trade_operation_right_float_data_text1: {
      color: "#df5e52",
    },
    ljn_trade_operation_right_float_data_text2: {
      color: theme.titleTextColor,
      textAlign: "center",
    },

    // 当前价格
    ljn_trade_operation_current_price: {
      height: px2vw(65),
      paddingTop: px2vw(3),
    },
    ljn_trade_operation_current_price_text1: {
      fontSize: px2vw(28),
      fontWeight: "600",
      color: "#df5e52",
    },
    ljn_trade_operation_current_price_text2: {
      color: theme.titleTextColor,
      fontSize: px2vw(12),
    },

    // 调整精度
    ljn_trade_operation_accuracy: {
      display: "flex",
      height: px2vw(30),
      flexDirection: "row",
      justifyContent: "space-between",
      marginTop: px2vw(6),
    },
    ljn_trade_operation_accuracy_selector_area: {
      flexBasis: px2vw(100),
      height: px2vw(30),
    },
    ljn_trade_operation_accuracy_selector: {
      backgroundColor: theme.backgroundColor,
      height: px2vw(30),
      borderRadius: px2vw(5),
      paddingLeft: px2vw(10),
      paddingRight: px2vw(10),
      color: theme.textColor,
      fontSize: px2vw(14),
      fontWeight: "600",
    },
    ljn_trade_operation_accuracy_icon: {
      flex: 1,
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
    },
    ljn_trade_operation_accuracy_icon_box: {
      width: px2vw(30),
      height: px2vw(30),
      backgroundColor: theme.areaBackgroundColor,
      borderRadius: px2vw(3),
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
    },
  });
}
