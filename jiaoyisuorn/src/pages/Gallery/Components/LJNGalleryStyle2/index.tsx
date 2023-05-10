import React, { useMemo } from "react";
import { Image, StyleSheet, View } from "react-native";
import { useStyles } from "../../../../hooks";
import { setTheme } from "./styles";
import VideoPlay from "../../../../components/LJNVideoPlayer";
import { useActiveBox } from "../componentsHooks";

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
              <View style={styles.ljn_gallery_list_left_item}>
                <VideoPlay
                  style={styles.ljn_gallery_item_video}
                  autoPlay={apply}
                />
              </View>
            </View>

            <View style={styles.ljn_gallery_list_right}>
              {gallery.slice(1).map((item, index) => (
                <View style={styles.ljn_gallery_item} key={index}>
                  <Image
                    style={styles.ljn_gallery_item_image}
                    source={{
                      uri: item.image,
                    }}
                  />
                </View>
              ))}
            </View>
          </View>
        );
      }, [apply])}
    </>
  );
};

export default index;
