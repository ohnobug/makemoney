import { StyleSheet, Text, View, Image } from "react-native";
import React, { useEffect, useState } from "react";
import { useAppSelector } from "hooks";
import { selectAppTheme } from "store/SystemSlice";
import { setTheme } from "./styles";
import LJNButton from "../LJNButton";

type Props = {};

const index = (props: Props) => {
  const theme = useAppSelector(selectAppTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
  }, [theme]);

  return (
    <View style={styles.ljn_emptyblock}>
      <View style={styles.ljn_emptyblock_row1}>
        <Image
          style={styles.ljn_emptyblock_row1_img}
          source={require("../../assets/images/recharge.png")}
        />
      </View>
      <View style={styles.ljn_emptyblock_row2}>
        <Text style={styles.ljn_emptyblock_row2_text}>
          立即充值，开启您的数字货币之旅快速入金可领取高额奖励
        </Text>
      </View>
      <LJNButton
        size="middle"
        style={styles.ljn_emptyblock_row3}
        title={"去入金"}
        onPress={() => {}}
      />
    </View>
  );
};

export default index;

const styles = StyleSheet.create({});
