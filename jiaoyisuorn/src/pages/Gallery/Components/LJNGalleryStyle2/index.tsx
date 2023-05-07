import React from "react";
import { Image, View } from "react-native";
import { useStyles } from "../../../../hooks";
import { setTheme } from "./styles";

import VideoPlay from "../../../../components/LJNVideoPlayer";

type Props = {
  gallery: {
    image: string;
    url: string;
  }[];
};

const index = ({ gallery }: Props) => {
  const styles = useStyles(setTheme);

  const handleLayout = (event: any) => {
    const { x, y, width, height } = event.nativeEvent.layout;
    console.log("视图布局发生变化：", { x, y, width, height });
  };

  return (
    <View style={styles.ljn_gallery_list} onLayout={handleLayout}>
      <View style={styles.ljn_gallery_list_left}>
        <View style={styles.ljn_gallery_item}>
          <VideoPlay style={styles.ljn_gallery_item_video} />
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
};

export default index;
