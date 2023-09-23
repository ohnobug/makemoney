import {
  Text,
  View,
  StyleSheet,
  StyleProp,
  ViewStyle,
  TouchableOpacity,
  GestureResponderEvent,
} from "react-native";
import React, { useEffect, useState } from "react";
import { useAppSelector } from "hooks";
import { selectAppTheme } from "store/SystemSlice";
import { setTheme } from "./styles";

type Props = {
  title: string;
  size?: "small" | "middle" | "normal" | "big";
  block?: boolean;
  onPress?: (event: GestureResponderEvent) => void | undefined;
  style?: StyleProp<ViewStyle>;
};

const index = ({ title, size = "normal", onPress, style }: Props) => {
  const theme = useAppSelector(selectAppTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
  }, [theme]);

  return (
    <TouchableOpacity
      activeOpacity={0.6}
      style={StyleSheet.flatten([styles["ljn_" + size + "_button"], style])}
      onPress={onPress}
    >
      <Text style={styles["ljn_" + size + "_button_text"]}>{title}</Text>
    </TouchableOpacity>
  );
};

export default index;
