import React, { useMemo, useRef } from "react";
import { Image, StyleSheet, View } from "react-native";
import LJNVideoPlayer from "../../../../components/LJNVideoPlayer";
import { useStyles } from "../../../../hooks";
import { useActiveBox } from "../componentsHooks";
import { setTheme } from "./styles";
import cssConfig from "../cssConfig";

type Props = {
  gallery: {
    image: string;
    url: string;
  }[];
  index: number;
  scrollPosition: number;
};

const index = ({ gallery, index, scrollPosition }: Props) => {
  const styles = useStyles(setTheme);

  let componentY = useRef(index * ((cssConfig.boxSize + cssConfig.boxGap) * 2));
  const apply = useActiveBox(componentY.current, scrollPosition);

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
              {apply ? (
                <LJNVideoPlayer
                  autoPlay={apply}
                  style={StyleSheet.flatten([styles.ljn_gallery_item_video])}
                />
              ) : (
                <Image
                  style={styles.ljn_gallery_item_video}
                  source={{
                    uri: gallery[0].image,
                  }}
                />
              )}
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
