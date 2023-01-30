import { StyleSheet, Text, View, Image } from "react-native";
import React, { useEffect, useState } from "react";
import { useAppSelector } from "../../../../hooks";
import { selectTheme } from "../../../../store/SystemSlice";
import { setTheme } from "./styles";
import LJNIcon from "../../../../components/LJNIcon";
import LJNButton from "../../../../components/LJNButton";
import LJNLoading from "../../../../components/LJNLoading";

type Props = {};

const index = (props: Props) => {
  const theme = useAppSelector(selectTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));

  useEffect(() => {
    setStyles(setTheme(theme));
  }, [theme]);

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
                新手任务
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
                source={require("../../../../assets/images/nftimg.png")}
              />
            </View>
            <View style={styles.ljn_activation_row2}>
              <Text style={styles.ljn_activation_row2_text}>
                注册登录即可获得
              </Text>
            </View>
            <View style={styles.ljn_activation_row3}>
              <LJNButton
                style={styles.ljn_activation_row3_button}
                title={"去完成"}
                onPress={() => {}}
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
