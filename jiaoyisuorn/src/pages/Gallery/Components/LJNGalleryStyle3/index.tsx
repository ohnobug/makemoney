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
    }, 500);

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
            <View style={styles.ljn_gallery_list_left}>
              {gallery.slice(1).map((item, index) => {
                return (
                  <View style={styles.ljn_gallery_item} key={index}>
                    <Image
                      style={styles.ljn_gallery_item_image}
                      source={{
                        uri: state[`img${index + 1}`] ? item.image : item.image,
                      }}
                      onLoadEnd={() => {
                        stateDispatch({ payload: `img${index + 1}` });
                      }}
                    />
                  </View>
                );
              })}
            </View>

            <View style={styles.ljn_gallery_list_right}>
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
          </View>
        );
      }, [state, showVideo])}
    </>
  );
};

export default index;
