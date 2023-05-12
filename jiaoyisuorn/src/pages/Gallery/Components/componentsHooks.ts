import { useEffect, useRef, useState } from "react";
import cssConfig from "./cssConfig";
import { useAppDispatch, useAppSelector } from "../../../hooks";
import {
  selectGalleryPlayIndex,
  setGalleryPlayIndex,
} from "../../../store/SystemSlice";

const BOXHEIGHT = (cssConfig.boxSize + cssConfig.boxGap) * 2;
export function useActiveBox(
  componentOffset: number,
  scrollPosition: number,
  direction: "UP" | "DOWN",
  index: number
): boolean {
  const [play, setPlay] = useState(false);
  const dispatch = useAppDispatch();

  useEffect(() => {
    return () => {
      if (play) {
        // console.log("销毁释放", index);
        setPlay(false);
        dispatch(setGalleryPlayIndex(-1));
      }
    };
  }, [play]);

  const galleryPlayIndex = useAppSelector(selectGalleryPlayIndex);
  useEffect(() => {
    if (galleryPlayIndex === -1) {
      // 目前没有在播的
      if (direction === "UP") {
        if (
          componentOffset - scrollPosition >= -(BOXHEIGHT / 2) &&
          componentOffset - scrollPosition <= BOXHEIGHT / 2
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
          componentOffset + BOXHEIGHT >= scrollPosition + 2.5 * BOXHEIGHT &&
          componentOffset + BOXHEIGHT <= scrollPosition + 3 * BOXHEIGHT
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
          if (componentOffset - scrollPosition <= -(BOXHEIGHT / 2)) {
            if (play === true) {
              console.log("向上超出释放", index);
              setPlay(false);
              dispatch(setGalleryPlayIndex(-1));
            }
          }
        } else {
          // 本盒子向下走
          if (
            componentOffset - scrollPosition >=
            BOXHEIGHT * 2 + (cssConfig.boxSize + cssConfig.boxGap)
          ) {
            console.log("向下超出释放", index);
            if (play === true) {
              setPlay(false);
              dispatch(setGalleryPlayIndex(-1));
            }
          }
        }
      }
    }
  }, [scrollPosition, direction, galleryPlayIndex]);

  return play;
}
