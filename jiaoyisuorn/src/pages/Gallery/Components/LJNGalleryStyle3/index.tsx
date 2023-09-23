import LJNImage from "components/LJNImage";
import LJNVideoPlayer from "components/LJNVideoPlayer";
import { useStyles } from "hooks";
import React, { useEffect, useMemo, useRef, useState } from "react";
import { StyleSheet, View } from "react-native";
import { checkTap } from "utils/utils";
import { useActiveBox } from "../componentsHooks";
import cssConfig from "../cssConfig";
import { setTheme } from "./styles";

// 长短按判断
function componentCheckTap(
  longTapPosition,
  tapPosition,
  offset,
  scrollPosition,
  list,
  longTap,
  tap
) {
  const boxPosition = useRef([
    // 第一列
    {
      x1: cssConfig.boxGap,
      y1: 0,
      x2: cssConfig.boxGap + cssConfig.boxSize,
      y2: (cssConfig.boxSize + cssConfig.boxGap) * 2,
    },
    // 第一行第二个
    {
      x1: cssConfig.boxGap + cssConfig.boxSize + cssConfig.boxGap,
      y1: 0,
      x2: (cssConfig.boxGap + cssConfig.boxSize) * 2,
      y2: cssConfig.boxSize,
    },
    // 第一行第三个
    {
      x1: (cssConfig.boxGap + cssConfig.boxSize) * 2 + cssConfig.boxGap,
      y1: 0,
      x2: (cssConfig.boxGap + cssConfig.boxSize) * 3,
      y2: cssConfig.boxSize,
    },
    // 第二行第二个
    {
      x1: cssConfig.boxGap + cssConfig.boxSize + cssConfig.boxGap,
      y1: cssConfig.boxSize + cssConfig.boxGap,
      x2: (cssConfig.boxGap + cssConfig.boxSize) * 2,
      y2: cssConfig.boxSize + cssConfig.boxGap + cssConfig.boxSize,
    },
    // 第二行第三个
    {
      x1: (cssConfig.boxGap + cssConfig.boxSize) * 2 + cssConfig.boxGap,
      y1: cssConfig.boxSize + cssConfig.boxGap,
      x2: (cssConfig.boxGap + cssConfig.boxSize) * 3,
      y2: cssConfig.boxSize + cssConfig.boxGap + cssConfig.boxSize,
    },
  ]).current;

  // 长按处理
  const [longTabTarget, setLongTabTarget] = useState(-1);
  useEffect(() => {
    for (let i = 0; i < boxPosition.length; i++) {
      const rantagle = {
        x1: boxPosition[i].x1,
        y1: boxPosition[i].y1 + (offset - scrollPosition),
        x2: boxPosition[i].x2,
        y2: boxPosition[i].y2 + (offset - scrollPosition),
      };

      if (checkTap(rantagle, longTapPosition)) {
        console.log("你在", i, "中长按");
        longTap && longTap(list[i]);
        setLongTabTarget(i);
        break;
      } else {
        setLongTabTarget(-1);
      }
    }
  }, [longTapPosition, scrollPosition]);

  // 短按
  const [tabTarget, setTabTarget] = useState(-1);
  useEffect(() => {
    for (let i = 0; i < boxPosition.length; i++) {
      if (
        checkTap(
          {
            x1: boxPosition[i].x1,
            y1: boxPosition[i].y1 + (offset - scrollPosition),
            x2: boxPosition[i].x2,
            y2: boxPosition[i].y2 + (offset - scrollPosition),
          },
          tapPosition
        )
      ) {
        console.log("你在", i, "中短按");
        tap && tap(list[i]);
        setTabTarget(i);
        break;
      } else {
        setTabTarget(-1);
      }
    }
  }, [tapPosition, scrollPosition]);

  return [longTabTarget, tabTarget];
}

type Props = {
  gallery: {
    image: string;
    url: string;
  }[];
  offset: number;
  index: number;
  scrollPosition?: number;
  direction?: "UP" | "DOWN";
  scrollState?: "handleScroll" | "autoScroll" | "scrollEnd";
  longTapPosition?: { x: number; y: number };
  tapPosition?: { x: number; y: number };
  longTap?: any;
  tap?: any;
};

const index = ({
  gallery,
  offset,
  index,
  scrollPosition = 0,
  direction = "UP",
  scrollState = "scrollEnd",
  longTapPosition = { x: 0, y: 0 },
  tapPosition = { x: 0, y: 0 },
  longTap,
  tap,
}: Props) => {
  const styles = useStyles(setTheme);

  // 显示视频
  const canPlay = useActiveBox(
    offset,
    scrollPosition,
    direction,
    index,
    scrollState
  );

  const [longTabTarget, tabTarget] = componentCheckTap(
    longTapPosition,
    tapPosition,
    offset,
    scrollPosition,
    gallery,
    longTap,
    tap
  );

  return (
    <>
      {useMemo(
        () => (
          <View style={StyleSheet.flatten([styles.ljn_gallery_list])}>
            <View style={styles.ljn_gallery_list_left}>
              {gallery.slice(1).map((item, index) => (
                <View style={styles.ljn_gallery_item} key={index}>
                  <LJNImage
                    style={styles.ljn_gallery_item_image}
                    img={item.image}
                  />
                </View>
              ))}
            </View>

            <View style={styles.ljn_gallery_list_right} key={index}>
              {canPlay ? (
                <LJNVideoPlayer
                  autoPlay={true}
                  style={StyleSheet.flatten([
                    styles.ljn_gallery_item_video,
                    {
                      zIndex: 999,
                    },
                  ])}
                />
              ) : null}

              <LJNImage
                style={styles.ljn_gallery_item_video}
                img={gallery[0].image}
              />
            </View>
          </View>
        ),
        [canPlay]
      )}
    </>
  );
};

export default index;
