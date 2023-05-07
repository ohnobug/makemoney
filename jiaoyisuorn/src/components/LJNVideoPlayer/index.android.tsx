import React, { useRef } from "react";
type Props = { style: any };
import { Video, ResizeMode } from "expo-av";

const noav = require("../../assets/noav.mp4");

export default function index({ style }: Props) {
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
      shouldPlay
      source={noav}
    />
  );
}
