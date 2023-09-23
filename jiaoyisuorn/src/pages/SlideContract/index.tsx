import LJNHeader from "components/LJNHeader";
import { useStyles } from "hooks";
import React from "react";
import { View, Text } from "react-native";
import { setTheme } from "./styles";

type Props = any;
export default function SlideContract({ navigation }: Props) {
  const styles = useStyles(setTheme);

  return (
    <View style={styles.container}>
      <LJNHeader title={"合约"}></LJNHeader>

      <View style={styles.ljn_main}>
        <Text>合约</Text>
      </View>
    </View>
  );
}
