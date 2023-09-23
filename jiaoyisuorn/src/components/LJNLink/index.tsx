import {
  GestureResponderEvent,
  StyleProp,
  StyleSheet,
  Text,
  TextProps,
  TouchableOpacity,
} from "react-native";
import React, { useEffect, useState } from "react";
import { useAppSelector } from "hooks";
import { setTheme } from "./styles";
import { selectAppTheme } from "store/SystemSlice";

type Props = {
  title: string;
  style?: StyleProp<TextProps>;
  onPress?: (event: GestureResponderEvent) => void | undefined;
};

const index = ({ title, style, onPress }: Props) => {
  const theme = useAppSelector(selectAppTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
  }, []);

  return (
    <TouchableOpacity activeOpacity={0.6} onPress={onPress}>
      <Text style={StyleSheet.flatten([styles.ljn_link, style])}>{title}</Text>
    </TouchableOpacity>
  );
};

export default index;
