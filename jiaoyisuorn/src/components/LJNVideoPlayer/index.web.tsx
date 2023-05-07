import React, { useRef } from "react";
type Props = { style: any };

const noav = require("../../assets/noav.mp4");

export default function index({ style }: Props) {
  const video = useRef(null);

  return (
    <video
      ref={(ref: any) => {
        video.current = ref;
      }}
      style={style}
      src={noav}
    />
  );
}
