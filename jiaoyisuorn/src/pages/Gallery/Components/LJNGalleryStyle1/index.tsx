import React, { useMemo, useReducer } from "react";
import { Image, StyleSheet, View } from "react-native";
import { useStyles } from "../../../../hooks";
import { useActiveBox } from "../componentsHooks";
import { setTheme } from "./styles";
const boxempty = require("../../../../assets/images/boxempty.png");

type Props = {
  gallery: {
    image: string;
    url: string;
  }[];
  offset: number;
  index: number;
  scrollPosition?: number;
  direction?: "UP" | "DOWN";
  scrollState?: "handleScroll" | "autoScroll" | "scrollEnd";
};

const index = ({
  gallery,
  offset,
  index,
  scrollPosition = 0,
  direction = "UP",
  scrollState = "scrollEnd",
}: Props) => {
  const styles = useStyles(setTheme);

  useActiveBox(offset, scrollPosition, direction, index, scrollState);

  const [state, stateDispatch] = useReducer(
    (preState, action) => {
      preState[action.payload] = true;
      return { ...preState };
    },
    {
      img0: false,
      img1: false,
      img2: false,
      img3: false,
      img4: false,
      img5: false,
    }
  );

  return (
    <>
      {useMemo(() => {
        return (
          <View style={StyleSheet.flatten([styles.ljn_gallery_list])}>
            {gallery.map((item, index) => {
              return (
                <View style={styles.ljn_gallery_item} key={index}>
                  <Image
                    style={styles.ljn_gallery_item_image}
                    source={
                      state[`img${index}`]
                        ? {
                            uri: item.image,
                          }
                        : boxempty
                    }
                    onLoadEnd={() => {
                      stateDispatch({ payload: `img${index}` });
                    }}
                  />
                </View>
              );
            })}
          </View>
        );
      }, [state])}
    </>
  );
};

export default index;
