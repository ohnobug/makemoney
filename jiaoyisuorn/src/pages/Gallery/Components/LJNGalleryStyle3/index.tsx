import React, { useMemo } from "react";
import { Image, StyleSheet, View } from "react-native";
import VideoPlay from "../../../../components/LJNVideoPlayer";
import { useStyles } from "../../../../hooks";
import { useActiveBox } from "../componentsHooks";
import { setTheme } from "./styles";

type Props = {
  gallery: {
    image: string;
    url: string;
  }[];
  scrollPosition: number;
};

const index = ({ gallery, scrollPosition }: Props) => {
  const styles = useStyles(setTheme);
  const [apply, handleLayout] = useActiveBox(scrollPosition);

  return (
    <>
      {useMemo(() => {
        return (
          <View
            style={StyleSheet.flatten([
              styles.ljn_gallery_list,
              // {
              //   backgroundColor: apply ? "red" : "blue",
              // },
            ])}
            onLayout={handleLayout}
          >
            <View style={styles.ljn_gallery_list_left}>
              {gallery.slice(1).map((item, index) => {
                return (
                  <View style={styles.ljn_gallery_item} key={index}>
                    <Image
                      style={styles.ljn_gallery_item_image}
                      source={{
                        uri: item.image,
                      }}
                    />
                  </View>
                );
              })}
            </View>

            <View style={styles.ljn_gallery_list_right}>
              <VideoPlay
                style={styles.ljn_gallery_item_video}
                autoPlay={apply}
              />
            </View>
          </View>
        );
      }, [apply])}
    </>
  );
};

export default index;
