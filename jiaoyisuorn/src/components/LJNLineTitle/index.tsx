import { StyleSheet, Text, View } from "react-native";
import React, { useEffect, useState } from "react";
import { setTheme } from "./styles";
import { useAppSelector } from "hooks";
import { selectAppTheme } from "store/SystemSlice";

type Props = {
  title: string;
};

const index = ({ title }: Props) => {
  const theme = useAppSelector(selectAppTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
  }, []);

  return (
    <View style={styles.ljn_line_title}>
      <Text style={styles.ljn_title}>{title}</Text>
      <View style={styles.ljn_line}></View>
    </View>
  );
};

export default index;
