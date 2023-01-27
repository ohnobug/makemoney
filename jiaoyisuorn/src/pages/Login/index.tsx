import { StyleSheet, Text, View } from "react-native";
import React, { useEffect, useState } from "react";
import { setTheme } from "./styles";
import { useAppSelector } from "../../hooks";
import { selectTheme } from "../../store/SystemSlice";

type Props = {};

const index = (props: Props) => {
  const theme = useAppSelector(selectTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
  }, [theme]);

  return (
    <View>
      <Text>index</Text>
    </View>
  );
};

export default index;
