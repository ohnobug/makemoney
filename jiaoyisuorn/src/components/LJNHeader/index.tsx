import { useAppSelector } from "hooks";
import React, { useEffect, useState } from "react";
import { Text, View } from "react-native";
import { selectAppTheme } from "store/SystemSlice";
import LJNIcon from "../LJNIcon";
import { setTheme } from "./styles";

type Props = {
  title: string;
  onBack?: Function | undefined;
  onMore?: Function | undefined;
};

const LJNHeader = (props: Props) => {
  const { title, onBack, onMore } = props;
  const theme = useAppSelector(selectAppTheme);

  // console.log("头部主题");

  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
  }, [theme]);

  return (
    <View style={styles.ljn_header}>
      <View style={styles.ljn_header_left}>
        {onBack ? (
          <View
            style={styles.ljn_header_left_icon}
            onTouchEnd={() => {
              onBack();
            }}
          >
            <LJNIcon title={"fanhui"} size={20} />
          </View>
        ) : null}
      </View>
      <View style={styles.ljn_header_middle}>
        <Text style={styles.ljn_header_middle_title}>{title}</Text>
      </View>
      <View style={styles.ljn_header_right}>
        {onMore ? (
          <View
            style={styles.ljn_header_right_icon}
            onTouchEnd={() => {
              onMore();
            }}
          >
            <LJNIcon title={"gengduo1"} size={20} />
          </View>
        ) : null}
      </View>
    </View>
  );
};

export default LJNHeader;
