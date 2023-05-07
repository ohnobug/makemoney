import React, { useRef } from "react";
import Video from "react-native-video";
type Props = { style: any };

const noav = require("../../assets/noav.mp4");

export default function index({ style }: Props) {
  const video = useRef(null);

  return (
    <Video
      // ref={(ref: any) => {
      //   video.current = ref;
      // }}
      // repeat
      // muted
      // resizeMode="cover"
      // style={style}
      source={noav}
    />
  );
}
