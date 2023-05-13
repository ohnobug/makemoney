import React, { useMemo, useReducer } from "react";
import { Image, StyleSheet, View } from "react-native";
import LJNVideoPlayer from "../../../../components/LJNVideoPlayer";
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

  // 显示视频
  const canPlay = useActiveBox(
    offset,
    scrollPosition,
    direction,
    index,
    scrollState
  );

  // console.log("index", index, "canPlay", canPlay);

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
    }
  );

  return (
    <>
      {useMemo(
        () => (
          <View style={StyleSheet.flatten([styles.ljn_gallery_list])}>
            <View style={styles.ljn_gallery_list_left}>
              {canPlay ? (
                <LJNVideoPlayer
                  autoPlay={true}
                  style={StyleSheet.flatten([
                    styles.ljn_gallery_item_video,
                    {
                      zIndex: 999,
                    },
                  ])}
                />
              ) : null}

              <Image
                style={styles.ljn_gallery_item_video}
                source={
                  state.img0
                    ? {
                        uri: gallery[0].image,
                      }
                    : boxempty
                }
                onLoad={() => {
                  stateDispatch({ payload: "img0" });
                }}
              />
            </View>

            <View style={styles.ljn_gallery_list_right}>
              {gallery.slice(1).map((item, index) => (
                <View style={styles.ljn_gallery_item} key={index}>
                  <Image
                    style={styles.ljn_gallery_item_image}
                    source={
                      state[`img${index + 1}`]
                        ? {
                            uri: item.image,
                          }
                        : boxempty
                    }
                    onLoadEnd={() => {
                      stateDispatch({ payload: `img${index + 1}` });
                    }}
                  />
                </View>
              ))}
            </View>
          </View>
        ),
        [state, canPlay]
      )}
    </>
  );
};

export default index;
