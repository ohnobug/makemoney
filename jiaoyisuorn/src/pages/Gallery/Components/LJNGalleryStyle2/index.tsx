import React, {
  useEffect,
  useLayoutEffect,
  useReducer,
  useRef,
  useState,
} from "react";
import { Image, StyleSheet, View } from "react-native";
import LJNVideoPlayer from "../../../../components/LJNVideoPlayer";
import { useStyles } from "../../../../hooks";
import { useActiveBox } from "../componentsHooks";
import cssConfig from "../cssConfig";
import { setTheme } from "./styles";

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

  const [showVideo, setShowVideo] = useState(false);
  useEffect(() => {
    let timer = setTimeout(() => {
      setShowVideo(apply);
    }, 300);

    return () => {
      clearTimeout(timer);
    };
  }, [apply]);

  const [state, dispatch] = useReducer(
    (preState, action) => {
      preState[action.payload] = true;
      return { ...preState };
    },
    {
      img0: false,
      img1: false,
      img2: false,
      img3: false,
      img4: false,
    }
  );

  return (
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
          {showVideo ? (
            <LJNVideoPlayer
              autoPlay={apply}
              style={StyleSheet.flatten([
                styles.ljn_gallery_item_video,
                {
                  zIndex: 999,
                },
              ])}
            />
          ) : (
            <></>
          )}

          <Image
            style={styles.ljn_gallery_item_video}
            source={{
              uri: state.img0 ? gallery[0].image : gallery[0].image,
            }}
            onLoad={() => {
              dispatch({ payload: "img0" });
            }}
          />
        </View>
      </View>

      <View style={styles.ljn_gallery_list_right}>
        {gallery.slice(1).map((item, index) => (
          <View style={styles.ljn_gallery_item} key={index}>
            <Image
              style={styles.ljn_gallery_item_image}
              source={{
                uri: state[`img${index}`] ? item.image : item.image,
              }}
              onLoadEnd={() => {
                dispatch({ payload: `img${index}` });
              }}
            />
          </View>
        ))}
      </View>
    </View>
  );
};

export default index;
