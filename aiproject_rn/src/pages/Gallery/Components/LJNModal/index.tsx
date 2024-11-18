import React, { forwardRef, useImperativeHandle, useState } from "react";
import { Image, StyleSheet, View } from "react-native";
import { useStyles } from "hooks";
import { setTheme } from "./styles";
import LJNIcon from "components/LJNIcon";
const boxempty = require("assets/images/boxempty.png");
const likeicon = require("assets/images/likeicon.png");

type Props = {};

const index = ({}: Props, ref) => {
  const styles = useStyles(setTheme);

  const [loaded, setLoaded] = useState(false);

  const [show, setShow] = useState(false);
  const [data, setData] = useState<{
    image: string;
    url: string;
  }>();

  useImperativeHandle(ref, () => {
    return {
      display: (v: boolean, data: any) => {
        setShow(v);
        setData(data);
      },
    };
  });

  return (
    <View
      style={StyleSheet.flatten([
        styles.ljn_modal_container,
        { display: show ? "flex" : "none", userSelect: "none" },
      ])}
    >
      {data ? (
        <View style={StyleSheet.flatten([styles.ljn_modal_box])}>
          {/* 图片盒子 */}
          <View style={styles.ljn_modal_photo_box}>
            <Image
              style={styles.ljn_modal_photo_box_photo}
              source={
                loaded
                  ? {
                      uri: data.image,
                    }
                  : boxempty
              }
              onLoadEnd={() => {
                setLoaded(true);
              }}
            />
          </View>

          {/* 弹窗标题 */}
          <View style={styles.ljn_modal_title_box}>
            <View style={styles.ljn_modal_title_box_like_btn_box}>
              <LJNIcon title={"like"} size={17} />
            </View>
            <View style={styles.ljn_modal_title_box_like_btn_box}>
              <LJNIcon title={"like"} size={17} />
            </View>
            <View style={styles.ljn_modal_title_box_like_btn_box}>
              <LJNIcon title={"like"} size={17} />
            </View>
            <View style={styles.ljn_modal_title_box_like_btn_box}>
              <LJNIcon title={"like"} size={17} />
            </View>
          </View>
        </View>
      ) : (
        <></>
      )}
    </View>
  );
};

export default forwardRef(index);
