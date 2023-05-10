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
            <View style={styles.ljn_gallery_list_side}>
              <View style={styles.ljn_gallery_item}>
                <Image
                  style={styles.ljn_gallery_item_image}
                  source={{
                    uri: gallery[0].image,
                  }}
                />
              </View>
              <View style={styles.ljn_gallery_item}>
                <Image
                  style={styles.ljn_gallery_item_image}
                  source={{
                    uri: gallery[1].image,
                  }}
                />
              </View>
            </View>

            <View style={styles.ljn_gallery_list_middle}>
              <VideoPlay
                style={styles.ljn_gallery_item_video}
                autoPlay={apply}
              />
            </View>

            <View style={styles.ljn_gallery_list_side}>
              <View style={styles.ljn_gallery_item}>
                <Image
                  style={styles.ljn_gallery_item_image}
                  source={{
                    uri: gallery[3].image,
                  }}
                />
              </View>
              <View style={styles.ljn_gallery_item}>
                <Image
                  style={styles.ljn_gallery_item_image}
                  source={{
                    uri: gallery[4].image,
                  }}
                />
              </View>
            </View>
          </View>
        );
      }, [apply])}
    </>
  );
};

export default index;
