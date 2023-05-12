import React, { useEffect, useMemo, useReducer, useState } from "react";
import { Image, StyleSheet, View } from "react-native";
import LJNVideoPlayer from "../../../../components/LJNVideoPlayer";
import { useStyles } from "../../../../hooks";
import { useActiveBox } from "../componentsHooks";
import { setTheme } from "./styles";

type Props = {
  gallery: {
    image: string;
    url: string;
  }[];
  offset: number;
  index: number;
  scrollPosition?: number;
  direction?: "UP" | "DOWN";
};

const index = ({
  gallery,
  offset,
  index,
  scrollPosition = 0,
  direction = "UP",
}: Props) => {
  const styles = useStyles(setTheme);

  // 显示视频
  const canPlay = useActiveBox(offset, scrollPosition, direction, index);
  const [showVideo, setShowVideo] = useState(false);
  useEffect(() => {
    // 加时钟的原因是为了避免快速滚动的过程中产生多个视频实例
    let timer = setTimeout(() => {
      setShowVideo(canPlay);
    }, 300);

    return () => {
      clearTimeout(timer);
    };
  }, [canPlay]);

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
                  source={{
                    uri: state.img1 ? gallery[1].image : gallery[1].image,
                  }}
                  onLoadEnd={() => {
                    stateDispatch({ payload: `img1` });
                  }}
                />
              </View>
              <View style={styles.ljn_gallery_item}>
                <Image
                  style={styles.ljn_gallery_item_image}
                  source={{
                    uri: state.img2 ? gallery[2].image : gallery[2].image,
                  }}
                  onLoadEnd={() => {
                    stateDispatch({ payload: `img2` });
                  }}
                />
              </View>
            </View>

            <View style={styles.ljn_gallery_list_middle}>
              {showVideo ? (
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
                source={{
                  uri: state.img0 ? gallery[0].image : gallery[0].image,
                }}
                onLoad={() => {
                  stateDispatch({ payload: "img0" });
                }}
              />
            </View>

            <View style={styles.ljn_gallery_list_side}>
              <View style={styles.ljn_gallery_item}>
                <Image
                  style={styles.ljn_gallery_item_image}
                  source={{
                    uri: state.img3 ? gallery[3].image : gallery[3].image,
                  }}
                  onLoad={() => {
                    stateDispatch({ payload: "img3" });
                  }}
                />
              </View>
              <View style={styles.ljn_gallery_item}>
                <Image
                  style={styles.ljn_gallery_item_image}
                  source={{
                    uri: state.img4 ? gallery[4].image : gallery[4].image,
                  }}
                  onLoad={() => {
                    stateDispatch({ payload: "img4" });
                  }}
                />
              </View>
            </View>
          </View>
        );
      }, [state, showVideo])}
    </>
  );
};

export default index;
