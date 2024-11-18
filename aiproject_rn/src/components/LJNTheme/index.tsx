import { StyleSheet, Text, View } from "react-native";
import React, { useEffect, useState } from "react";
import { useAppSelector } from "hooks";
import { selectAppTheme, setTheme } from "store/SystemSlice";

type Props = {};

const index = (props: Props) => {
  const theme = useAppSelector(selectAppTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
  }, [theme]);

  return <>{props.children}</>;
};

export default index;
