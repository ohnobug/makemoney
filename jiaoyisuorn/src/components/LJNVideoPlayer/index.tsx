import React, { useEffect, useRef, useState } from "react";
import { Video, ResizeMode } from "expo-av";

const noav = require("../../assets/noav.mp4");
type Props = { style: any; autoPlay?: boolean };
export default function LJNVideoPlayer({ style, autoPlay = false }: Props) {
  // const video = useRef(null);

  // useEffect(() => {
  //   video.current.loadAsync(noav, {
  //     isLooping: true,
  //     isMuted: true,
  //     shouldPlay: true,
  //   });

  //   return () => {
  //     video.current.unloadAsync();
  //   };
  // }, []);

  const [left, setLeft] = useState(-1000);

  return (
    <Video
      // ref={(ref: any) => {
      //   video.current = ref;
      // }}
      isLooping
      isMuted
      resizeMode={ResizeMode.COVER}
      style={{
        ...style,
        ...{
          left: left,
        },
      }}
      videoStyle={{
        width: style.width,
        height: style.height,
      }}
      onLoad={() => {
        setLeft(0);
      }}
      shouldPlay={autoPlay}
      source={noav}
    />
  );
}
