import { Text, View, Image, StyleSheet, TouchableOpacity } from "react-native";
import React, { useEffect, useState } from "react";
import { useAppSelector } from "../../hooks";
import { selectTheme } from "../../store/SystemSlice";
import { setTheme } from "./styles";
import LJNIcon from "../LJNIcon";

type Props = {
  list: Array<{
    title: string;
    desc: string;
    url: string;
  }>;
};

const index = (props: Props) => {
  const theme = useAppSelector(selectTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
  }, []);

  return (
    <View style={styles.ljn_list}>
      {props.list.map((item, index) => {
        return (
          <View
            style={StyleSheet.flatten([
              styles.ljn_list_item,
              index === props.list.length - 1
                ? styles.ljn_list_item_last
                : null,
            ])}
            key={index}
          >
            <TouchableOpacity
              style={styles.ljn_list_item_inner}
              activeOpacity={0.6}
            >
              <View style={styles.ljn_list_item_title}>
                <Text style={styles.ljn_list_item_title_text}>
                  {item.title}
                </Text>
              </View>
              <View style={styles.ljn_list_item_desc}>
                {item.desc ? (
                  <Text style={styles.ljn_list_item_desc_text}>
                    {item.desc}
                  </Text>
                ) : null}
              </View>
              <View style={styles.ljn_list_item_icon}>
                {item.desc ? (
                  <View style={styles.ljn_list_item_icon_img}>
                    <LJNIcon title="jinrujiantouxiao" size={14} />
                  </View>
                ) : null}
              </View>
            </TouchableOpacity>
          </View>
        );
      })}
    </View>
  );
};

export default index;
