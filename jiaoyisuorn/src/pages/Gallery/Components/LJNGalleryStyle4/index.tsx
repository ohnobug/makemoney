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
        <Image
          style={styles.ljn_gallery_list_middle_image}
          source={{
            uri: gallery[2].image,
          }}
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
};

export default index;
