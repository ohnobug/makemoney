import React from "react";
import { Image, View } from "react-native";
import { useStyles } from "../../../../hooks";
import { setTheme } from "./styles";

type Props = {
  gallery: {
    image: string;
    url: string;
  }[];
};

const index = ({ gallery }: Props) => {
  const styles = useStyles(setTheme);

  return (
    <View style={styles.ljn_gallery_list}>
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
        <Image
          style={styles.ljn_gallery_list_right_image}
          source={{
            uri: gallery[0].image,
          }}
        />
      </View>
    </View>
  );
};

export default index;
