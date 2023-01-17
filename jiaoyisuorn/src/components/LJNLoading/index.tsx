import { StyleSheet, Text, View } from "react-native";
import React, { useEffect, useState } from "react";
import { setTheme } from "./styles";
import { useAppSelector } from "../../hooks";
import { selectTheme } from "../../store/SystemSlice";
import { px2vw } from "../../utils/utils";

type Props = {
  size?: number;
};

let dotlength = 0;
const index = ({ size = 14 }: Props) => {
  const theme = useAppSelector(selectTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  const [dot, setDot] = useState("...");

  useEffect(() => {
    setStyles(setTheme(theme));

    let timer = setInterval(() => {
      dotlength += 1;
      if (dotlength > 3) dotlength = 0;
      setDot(".".repeat(dotlength));
    }, 300);

    return () => {
      clearInterval(timer);
    };
  }, []);

  return (
    <View style={styles.ljn_container}>
      <Text
        style={StyleSheet.flatten([
          styles.ljn_container_text,
          { fontSize: px2vw(size) },
        ])}
      >
        加载中{dot}
      </Text>
      {/* <Image
        style={{
          width: px2vw(375 / 2),
          height: px2vw(211 / 2),
        }}
        source={require("../../assets/images/abc.gif")}
      /> */}
    </View>
  );
};

export default index;
