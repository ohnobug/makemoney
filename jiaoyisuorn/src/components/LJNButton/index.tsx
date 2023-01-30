import { StyleSheetProperties, Text, View, StyleSheet } from "react-native";
import React, { useEffect, useState } from "react";
import { useAppSelector } from "../../hooks";
import { selectTheme } from "../../store/SystemSlice";
import { setTheme } from "./styles";

type Props = {
  title: string;
  onPress: Function;
  style?: StyleSheetProperties;
};

const index = ({ title, onPress, style }: Props) => {
  const theme = useAppSelector(selectTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
  }, []);

  return (
    <View
      style={StyleSheet.flatten([styles.ljn_button, style])}
      onTouchEnd={() => {
        onPress();
      }}
    >
      <Text style={styles.ljn_button_text}>{title}</Text>
    </View>
  );
};

export default index;
