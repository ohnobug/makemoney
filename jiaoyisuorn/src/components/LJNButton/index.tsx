import { Text, View, StyleSheet, StyleProp, ViewStyle } from "react-native";
import React, { useEffect, useState } from "react";
import { useAppSelector } from "../../hooks";
import { selectTheme } from "../../store/SystemSlice";
import { setTheme } from "./styles";

type Props = {
  title: string;
  size?: "small" | "middle" | "normal" | "big";
  block?: boolean;
  onPress?: Function;
  style?: StyleProp<ViewStyle>;
};

const index = ({ title, size = "normal", onPress, style }: Props) => {
  const theme = useAppSelector(selectTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
  }, []);

  return (
    <View
      style={StyleSheet.flatten([styles["ljn_" + size + "_button"], style])}
      onTouchEnd={() => {
        onPress && onPress();
      }}
    >
      <Text style={styles["ljn_" + size + "_button_text"]}>{title}</Text>
    </View>
  );
};

export default index;
