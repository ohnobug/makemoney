import React, { useEffect, useMemo, useReducer, useRef, useState } from "react";
import { Image, StyleSheet, View } from "react-native";
import { useStyles } from "../../../../hooks";
import { useActiveBox } from "../componentsHooks";
import { setTheme } from "./styles";
import cssConfig from "../cssConfig";
import { checkTap } from "../../../../utils/utils";

const boxempty = require("../../../../assets/images/boxempty.png");

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
  showModal?: any;
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
  showModal,
}: Props) => {
  const styles = useStyles(setTheme);

  useActiveBox(offset, scrollPosition, direction, index, scrollState);

  const [state, stateDispatch] = useReducer(
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
      img5: false,
    }
  );

  const boxPosition = useRef([
    // 第一行第一个
    {
      x1: cssConfig.boxGap,
      y1: 0,
      x2: cssConfig.boxGap + cssConfig.boxSize,
      y2: cssConfig.boxSize,
    },
    // 第一行第二个
    {
      x1: cssConfig.boxGap + cssConfig.boxSize + cssConfig.boxGap,
      y1: 0,
      x2:
        cssConfig.boxGap +
        cssConfig.boxSize +
        cssConfig.boxGap +
        cssConfig.boxSize,
      y2: cssConfig.boxSize,
    },
    // 第一行第三个
    {
      x1:
        cssConfig.boxGap +
        cssConfig.boxSize +
        cssConfig.boxGap +
        cssConfig.boxSize +
        cssConfig.boxGap,
      y1: 0,
      x2:
        cssConfig.boxGap +
        cssConfig.boxSize +
        cssConfig.boxGap +
        cssConfig.boxSize +
        cssConfig.boxGap +
        cssConfig.boxSize,
      y2: cssConfig.boxSize,
    },

    // 第二行第一个
    {
      x1: cssConfig.boxGap,
      y1: cssConfig.boxSize + cssConfig.boxGap,
      x2: cssConfig.boxGap + cssConfig.boxSize,
      y2: cssConfig.boxSize + cssConfig.boxGap + cssConfig.boxSize,
    },
    // 第二行第二个
    {
      x1: cssConfig.boxGap + cssConfig.boxSize + cssConfig.boxGap,
      y1: cssConfig.boxSize + cssConfig.boxGap,
      x2:
        cssConfig.boxGap +
        cssConfig.boxSize +
        cssConfig.boxGap +
        cssConfig.boxSize,
      y2: cssConfig.boxSize + cssConfig.boxGap + cssConfig.boxSize,
    },
    // 第二行第三个
    {
      x1:
        cssConfig.boxGap +
        cssConfig.boxSize +
        cssConfig.boxGap +
        cssConfig.boxSize +
        cssConfig.boxGap,
      y1: cssConfig.boxSize + cssConfig.boxGap,
      x2:
        cssConfig.boxGap +
        cssConfig.boxSize +
        cssConfig.boxGap +
        cssConfig.boxSize +
        cssConfig.boxGap +
        cssConfig.boxSize,
      y2: cssConfig.boxSize + cssConfig.boxGap + cssConfig.boxSize,
    },
  ]).current;

  // 长按处理
  const [longTabTarget, setLongTabTarget] = useState(-1);
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
          longTapPosition
        )
      ) {
        console.log("你在", i, "中长按");
        showModal(gallery[i]);
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
        setTabTarget(i);
        break;
      } else {
        setTabTarget(-1);
      }
    }
  }, [tapPosition, scrollPosition]);

  return (
    <>
      {useMemo(() => {
        return (
          <View style={StyleSheet.flatten([styles.ljn_gallery_list])}>
            {gallery.map((item, index) => {
              return (
                <View
                  style={StyleSheet.flatten([
                    styles.ljn_gallery_item,
                    {
                      backgroundColor: longTabTarget === index ? "red" : "blue",
                    },
                  ])}
                  key={index}
                >
                  {longTabTarget === index ? null : (
                    <Image
                      style={styles.ljn_gallery_item_image}
                      source={
                        state[`img${index}`]
                          ? {
                              uri: item.image,
                            }
                          : boxempty
                      }
                      onLoadEnd={() => {
                        stateDispatch({ payload: `img${index}` });
                      }}
                    />
                  )}
                </View>
              );
            })}
          </View>
        );
      }, [state, longTabTarget])}
    </>
  );
};

export default index;
