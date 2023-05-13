import React, { useImperativeHandle, forwardRef, useState } from "react";
import { StyleSheet, Text, View, Image } from "react-native";
import { useStyles } from "../../../../hooks";
import { px2vw } from "../../../../utils/utils";
import { setTheme } from "./styles";
const boxempty = require("../../../../assets/images/boxempty.png");

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
        { display: show ? "flex" : "none" },
      ])}
    >
      {data ? (
        <View style={StyleSheet.flatten([styles.ljn_modal_box])}>
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
          <View style={styles.ljn_modal_title_box}>
            <Text style={styles.ljn_modal_title_inner}>恭喜发财</Text>
          </View>
        </View>
      ) : (
        <></>
      )}
    </View>
  );
};

export default forwardRef(index);
