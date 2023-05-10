import React, { useRef } from "react";
import { Video, ResizeMode } from "expo-av";

const noav = require("../../assets/noav.mp4");
type Props = { style: any; autoPlay?: boolean };
export default function index({ style, autoPlay = false }: Props) {
  const video = useRef(null);

  return (
    <Video
      ref={(ref: any) => {
        video.current = ref;
      }}
      isLooping
      isMuted
      resizeMode={ResizeMode.COVER}
      videoStyle={style}
      shouldPlay={autoPlay}
      source={noav}
    />
  );
}
