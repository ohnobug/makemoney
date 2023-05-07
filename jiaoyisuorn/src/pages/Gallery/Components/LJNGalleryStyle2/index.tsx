import React, { useRef } from "react";
import { Image, View } from "react-native";
import Video from "react-native-video";
import { useStyles } from "../../../../hooks";
import { setTheme } from "./styles";

const noav = require("../../../../assets/noav.mp4");

type Props = {
  gallery: {
    image: string;
    url: string;
  }[];
};

const index = ({ gallery }: Props) => {
  const styles = useStyles(setTheme);

  const video = useRef(null);
  // const [status, setStatus] = useState<any>({});

  const handleLayout = (event: any) => {
    const { x, y, width, height } = event.nativeEvent.layout;
    console.log("视图布局发生变化：", { x, y, width, height });
  };

  return (
    <View style={styles.ljn_gallery_list} onLayout={handleLayout}>
      <View style={styles.ljn_gallery_list_left}>
        {/* <Image
          style={styles.ljn_gallery_list_left_image}
          source={{
            uri: gallery[0].image,
          }}
        /> */}

        <View
          style={styles.ljn_gallery_item}
          // onTouchEnd={() => {
          //   status.isPlaying
          //     ? video.current.pauseAsync()
          //     : video.current.playAsync();
          // }}
        >
          <Video
            // ref={(ref: any) => {
            //   video.current = ref;
            // }}
            // repeat
            // muted
            // resizeMode="cover"
            // style={styles.ljn_gallery_item_video}
            source={noav}
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
};

export default index;
