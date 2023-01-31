import { Text, View, Image } from "react-native";
import React, { useEffect, useState } from "react";
import { setTheme } from "./styles";
import { useAppSelector } from "../../hooks";
import { selectTheme } from "../../store/SystemSlice";
import LJNIcon from "../LJNIcon";
import { useNavigate } from "react-router-native";

type Props = {
  title: string;
};

const index = (props: Props) => {
  const navigate = useNavigate();
  const theme = useAppSelector(selectTheme);
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
          <LJNIcon title={"xitongfanhui"} size={20} />
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
