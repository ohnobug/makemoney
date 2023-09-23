import LJNButton from "components/LJNButton";
import LJNIcon from "components/LJNIcon";
import LJNLoading from "components/LJNLoading";
import { useStyles } from "hooks";
import React, { useEffect, useState } from "react";
import { Image, StyleSheet, Text, View } from "react-native";
import { setTheme } from "./styles";

type Props = {
  title: string;
  buttonText: string;
  onClick: Function;
};

const index = ({ title, buttonText, onClick }: Props) => {
  const styles = useStyles(setTheme);

  let [show, setShow] = useState(false);
  useEffect(() => {
    let timer = setTimeout(() => {
      setShow(true);
    }, 100);
    return () => {
      clearTimeout(timer);
    };
  }, []);

  return (
    <View style={styles.ljn_activation_box}>
      {show ? (
        <>
          <View style={styles.ljn_activation_header}>
            <View style={styles.ljn_activation_header_left}>
              <Text style={styles.ljn_activation_header_left_title}>
                {title}
              </Text>
            </View>
            <View style={styles.ljn_activation_header_right}>
              <LJNIcon title={"jinrujiantouxiao"} size={14} />
            </View>
          </View>
          <View style={styles.ljn_activation_main}>
            <View style={styles.ljn_activation_row1}>
              <Image
                style={styles.ljn_activation_row1_img}
                source={require("assets/images/nftimg.png")}
              />
            </View>
            <View style={styles.ljn_activation_row2}>
              <Text style={styles.ljn_activation_row2_text}>
                注册登录即可获得
              </Text>
            </View>
            <View style={styles.ljn_activation_row3}>
              <LJNButton
                size="small"
                title={buttonText}
                onPress={() => {
                  onClick && onClick();
                }}
              />
            </View>
          </View>
        </>
      ) : (
        <LJNLoading />
      )}
    </View>
  );
};

export default index;

const styles = StyleSheet.create({});
