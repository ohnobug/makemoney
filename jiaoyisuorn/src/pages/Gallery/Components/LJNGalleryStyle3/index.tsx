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
          </View>
        );
      }, [apply])}
    </>
  );
};

export default index;
