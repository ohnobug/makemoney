import React, { useEffect, useMemo, useReducer, useRef, useState } from "react";
import { Image, StyleSheet, TouchableOpacity, View } from "react-native";
import LJNVideoPlayer from "../../../../components/LJNVideoPlayer";
import { useStyles } from "../../../../hooks";
import { useActiveBox } from "../componentsHooks";
import { setTheme } from "./styles";
import { Gesture, GestureDetector } from "react-native-gesture-handler";
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
  showModal?: any;
  childSetScrollEnabled?: any;
};

const index = ({
  gallery,
  offset,
  index,
  scrollPosition = 0,
  direction = "UP",
  scrollState = "scrollEnd",
  showModal,
  childSetScrollEnabled,
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

  const [lastClickItem, setLastClickItem] = useState(null);
  const [show, setShow] = useState(false);
  useEffect(() => {
    if (lastClickItem && show) {
      showModal(true, lastClickItem);
    }

    if (show === false) {
      showModal(false);
    }
  }, [lastClickItem, show]);

  const panGesture = Gesture.Pan()
    .activateAfterLongPress(200)
    .runOnJS(true)
    .onStart(() => {
      console.log("进来了");
      setShow(true);
      childSetScrollEnabled(false);
    })
    .onUpdate((e) => {
      console.log("移动");
    })
    .onEnd((e) => {
      console.log("出去了");
      setShow(false);
      childSetScrollEnabled(true);
    });

  return (
    <>
      {useMemo(() => {
        return (
          <View style={StyleSheet.flatten([styles.ljn_gallery_list])}>
            <View style={styles.ljn_gallery_list_side}>
              <TouchableOpacity
                style={styles.ljn_gallery_item}
                onPressIn={() => {
                  setLastClickItem(gallery[1]);
                }}
              >
                <GestureDetector gesture={panGesture}>
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
                </GestureDetector>
              </TouchableOpacity>

              <TouchableOpacity
                style={styles.ljn_gallery_item}
                onPressIn={() => {
                  setLastClickItem(gallery[2]);
                }}
              >
                <GestureDetector gesture={panGesture}>
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
                </GestureDetector>
              </TouchableOpacity>
            </View>

            <TouchableOpacity
              style={styles.ljn_gallery_list_middle}
              onPressIn={() => {
                setLastClickItem(gallery[0]);
              }}
            >
              {canPlay ? (
                <GestureDetector gesture={panGesture}>
                  <LJNVideoPlayer
                    autoPlay={true}
                    style={StyleSheet.flatten([
                      styles.ljn_gallery_item_video,
                      {
                        zIndex: 999,
                      },
                    ])}
                  />
                </GestureDetector>
              ) : null}

              <GestureDetector gesture={panGesture}>
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
              </GestureDetector>
            </TouchableOpacity>

            <View style={styles.ljn_gallery_list_side}>
              <TouchableOpacity
                style={styles.ljn_gallery_item}
                onPressIn={() => {
                  setLastClickItem(gallery[3]);
                }}
              >
                <GestureDetector gesture={panGesture}>
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
                </GestureDetector>
              </TouchableOpacity>

              <TouchableOpacity
                style={styles.ljn_gallery_item}
                onPressIn={() => {
                  setLastClickItem(gallery[4]);
                }}
              >
                <GestureDetector gesture={panGesture}>
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
                </GestureDetector>
              </TouchableOpacity>
            </View>
          </View>
        );
      }, [state, canPlay])}
    </>
  );
};

export default index;
