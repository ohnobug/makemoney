import React, { useEffect, useState } from "react";
import { Text, View } from "react-native";
import { useNavigate } from "react-router-native";
import { useAppSelector } from "../../hooks";
import { selectAppTheme } from "../../store/SystemSlice";
import LJNIcon from "../LJNIcon";
import { setTheme } from "./styles";

type Props = {
  title: string;
};

const index = (props: Props) => {
  const navigate = useNavigate();
  const theme = useAppSelector(selectAppTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
  }, []);

  return (
    <View style={styles.ljn_header}>
      <View style={styles.ljn_header_left}>
        <View
          style={styles.ljn_header_left_icon}
          onTouchEnd={() => {
            navigate(-1);
          }}
        >
          <LJNIcon title={"xitongfanhui"} size={17} />
        </View>
      </View>
      <View style={styles.ljn_header_middle}>
        <Text style={styles.ljn_header_middle_title}>{props.title}</Text>
      </View>
      <View style={styles.ljn_header_right}></View>
    </View>
  );
};

export default index;
