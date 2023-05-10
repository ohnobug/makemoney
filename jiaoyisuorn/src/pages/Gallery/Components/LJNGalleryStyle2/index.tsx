import React, { useEffect, useMemo, useRef, useState } from "react";
import { Image, StyleSheet, View } from "react-native";
import { useStyles } from "../../../../hooks";
import { setTheme } from "./styles";
import { useActiveBox } from "../componentsHooks";
import cssConfig from "../cssConfig";
import LJNVideoPlayer from "../../../../components/LJNVideoPlayer";

type Props = {
  gallery: {
    image: string;
    url: string;
  }[];
  index: number;
  scrollPosition?: number;
};

const index = ({ gallery, index, scrollPosition = 0 }: Props) => {
  const styles = useStyles(setTheme);

  let componentY = useRef(index * ((cssConfig.boxSize + cssConfig.boxGap) * 2));
  const apply = useActiveBox(componentY.current, scrollPosition);

  // const [canPlay, setCanPlay] = useState(false);
  // const timer = useRef(null);
  // useEffect(() => {
  //   if (apply) {
  //     timer.current = setTimeout(() => {
  //       setCanPlay(true);
  //     }, 500);
  //   } else {
  //     setCanPlay(false);
  //     clearTimeout(timer.current);
  //   }
  // }, [apply]);

  return (
    <>
      <View
        style={StyleSheet.flatten([
          styles.ljn_gallery_list,
          // {
          //   backgroundColor: apply ? "red" : "yellow",
          // },
        ])}
      >
        <View style={styles.ljn_gallery_list_left}>
          <View style={styles.ljn_gallery_list_left_item}>
            {useMemo(() => {
              return (
                <LJNVideoPlayer
                  autoPlay={apply}
                  style={StyleSheet.flatten([styles.ljn_gallery_item_video])}
                />
              );
            }, [apply])}
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
    </>
  );
};

export default index;
