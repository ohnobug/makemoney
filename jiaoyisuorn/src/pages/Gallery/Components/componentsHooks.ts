import { useLayoutEffect, useState } from "react";
import { useAppDispatch, useAppSelector } from "../../../hooks";
import {
  selectGalleryPlayIndex,
  setGalleryPlayIndex,
} from "../../../store/SystemSlice";
import cssConfig from "./cssConfig";

const BOXHEIGHT = (cssConfig.boxSize + cssConfig.boxGap) * 2;
export function useActiveBox(
  componentOffset: number, // 组件位置
  scrollPosition: number, // 滚动位置
  direction: "UP" | "DOWN", // 滚动方向
  index: number, // 索引
  scrollState?: "handleScroll" | "autoScroll" | "scrollEnd" // 滚动状态
): boolean {
  const [play, setPlay] = useState(false);
  const dispatch = useAppDispatch();

  useLayoutEffect(() => {
    return () => {
      if (play) {
        // console.log("销毁释放", index);
        setPlay(false);
        dispatch(setGalleryPlayIndex(-1));
      }
    };
  }, [play]);

  const galleryPlayIndex = useAppSelector(selectGalleryPlayIndex);
  useLayoutEffect(() => {
    // console.group();
    // console.table({
    //   scrollPosition: scrollPosition,
    //   direction: direction,
    //   galleryPlayIndex: galleryPlayIndex,
    //   scrollState: scrollState,
    // });
    // console.groupEnd();

    // 如果手动滚动，或者滚动结束，则进入判断状态
    if (["handleScroll", "scrollEnd"].includes(scrollState)) {
      if (galleryPlayIndex === -1) {
        // 目前没有在播的
        if (direction === "UP") {
          if (
            componentOffset - scrollPosition >= -(0.5 * BOXHEIGHT) &&
            componentOffset - scrollPosition <= 0.5 * BOXHEIGHT
          ) {
            if (play === false) {
              dispatch(setGalleryPlayIndex(index));
              setPlay(true);
            }
          } else {
            if (play === true) {
              dispatch(setGalleryPlayIndex(-1));
              setPlay(false);
            }
          }
        } else {
          if (
            componentOffset - scrollPosition >= 1 * BOXHEIGHT &&
            componentOffset - scrollPosition <= 1.5 * BOXHEIGHT
          ) {
            if (play === false) {
              dispatch(setGalleryPlayIndex(index));
              setPlay(true);
            }
          } else {
            if (play === true) {
              dispatch(setGalleryPlayIndex(-1));
              setPlay(false);
            }
          }
        }
      } else {
        // 目前有在播的

        // 且在播的属于本盒子
        if (galleryPlayIndex === index) {
          // console.log(index);
          if (direction === "UP") {
            // 本盒子向上走
            if (componentOffset - scrollPosition <= -(0.5 * BOXHEIGHT)) {
              if (play === true) {
                // console.log("向上超出释放", index);
                setPlay(false);
                dispatch(setGalleryPlayIndex(-1));
              }
            }
          } else {
            // 本盒子向下走
            if (componentOffset - scrollPosition >= BOXHEIGHT * 2) {
              // console.log("向下超出释放", index);
              if (play === true) {
                setPlay(false);
                dispatch(setGalleryPlayIndex(-1));
              }
            }
          }
        }
      }
    }
  }, [scrollPosition, direction, galleryPlayIndex, scrollState]);

  return play;
}
