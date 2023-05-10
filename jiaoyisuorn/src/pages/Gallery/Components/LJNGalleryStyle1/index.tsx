import React, { useMemo } from "react";
import { Image, StyleSheet, View } from "react-native";
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
            {gallery.map((item, index) => {
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
        );
      }, [apply])}
    </>
  );
};

export default index;
