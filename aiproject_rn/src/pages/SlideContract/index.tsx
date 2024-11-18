import { useFocusEffect, useIsFocused } from "@react-navigation/native";
import LJNHeader from "components/LJNHeader";
import { useStyles } from "hooks";
import React, { useCallback, useEffect, useRef, useState } from "react";
import { Text, View } from "react-native";
import { setTheme } from "./styles";

type Props = any;
export default function SlideContract({ navigation }: Props) {
  const styles = useStyles(setTheme);

  console.log("qqqqqq");
  return (
    <View style={styles.container}>
      <LJNHeader title={"合约"}></LJNHeader>

      <View style={styles.ljn_main}>
        <Text>合约</Text>
      </View>
    </View>
  );
}
