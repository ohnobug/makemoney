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
      {useMemo(() => {
        return (
          <View style={StyleSheet.flatten([styles.ljn_gallery_list])}>
            <View style={styles.ljn_gallery_list_side}>
              <View style={styles.ljn_gallery_item}>
                <Image
                  style={styles.ljn_gallery_item_image}
                  source={
                    state.img1
                      ? {
                          uri: gallery[1].image,
                        }
                      : boxempty
                  }
                  onLoadEnd={() => {
                    stateDispatch({ payload: `img1` });
                  }}
                />
              </View>

              <View style={styles.ljn_gallery_item}>
                <Image
                  style={styles.ljn_gallery_item_image}
                  source={
                    state.img2
                      ? {
                          uri: gallery[2].image,
                        }
                      : boxempty
                  }
                  onLoadEnd={() => {
                    stateDispatch({ payload: `img2` });
                  }}
                />
              </View>
            </View>

            <View style={styles.ljn_gallery_list_middle}>
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

            <View style={styles.ljn_gallery_list_side}>
              <View style={styles.ljn_gallery_item}>
                <Image
                  style={styles.ljn_gallery_item_image}
                  source={
                    state.img3
                      ? {
                          uri: gallery[3].image,
                        }
                      : boxempty
                  }
                  onLoad={() => {
                    stateDispatch({ payload: "img3" });
                  }}
                />
              </View>

              <View style={styles.ljn_gallery_item}>
                <Image
                  style={styles.ljn_gallery_item_image}
                  source={
                    state.img4
                      ? {
                          uri: gallery[4].image,
                        }
                      : boxempty
                  }
                  onLoad={() => {
                    stateDispatch({ payload: "img4" });
                  }}
                />
              </View>
            </View>
          </View>
        );
      }, [state, canPlay])}
    </>
  );
};

export default index;
