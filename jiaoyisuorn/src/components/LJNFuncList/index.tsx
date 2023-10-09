import React from "react";
import { View, Image, Text, TouchableOpacity } from "react-native";
import { setTheme } from "./styles";
import { useAppSelector, useStyles } from "hooks";
import LJNIcon from "components/LJNIcon";
import { selectAppTheme } from "store/SystemSlice";
import darkTheme from "themes/default/styles";
import lightTheme from "themes/light/styles";

type Props = {
  list: any;
};
export default function index({ list }: Props) {
  const styles = useStyles(setTheme);
  const theme = useAppSelector(selectAppTheme);

  return (
    <View style={styles.ljn_func_list}>
      {list.map((item, index) => {
        return (
          <TouchableOpacity
            key={index}
            style={{
              backgroundColor: "black",
            }}
            activeOpacity={0.8}
          >
            <View style={styles.ljn_list_item}>
              {/* 头像 */}
              <View style={styles.ljn_list_avatar_box}>
                <Image style={styles.ljn_list_avatar} source={item.avatar} />
              </View>

              {/* 名字和聊天信息 */}
              <View
                style={
                  index == list.length - 1
                    ? styles.ljn_list_message_info_no_underline
                    : styles.ljn_list_message_info
                }
              >
                <View style={styles.ljn_list_friend_name_box}>
                  <Text style={styles.ljn_list_friend_name} numberOfLines={1}>
                    {item.name}
                  </Text>
                </View>
                <View style={styles.ljn_list_date_box}>
                  <LJNIcon
                    title={"jinrujiantouxiao"}
                    size={13}
                    color={
                      theme === "dark"
                        ? darkTheme.chatMessageColor
                        : lightTheme.chatMessageColor
                    }
                  />
                </View>
              </View>
            </View>
          </TouchableOpacity>
        );
      })}
    </View>
  );
}
