import React, { useEffect, useRef } from "react";

const noav = require("../../assets/noav.mp4");

type Props = { style: any; autoPlay?: boolean };
export default function index({ style, autoPlay = false }: Props) {
  const video = useRef(null);

  useEffect(() => {
    if (autoPlay) {
      video.current.play();
    } else {
      video.current.pause();
    }
  }, [autoPlay]);

  return (
    <video
      ref={(ref: any) => {
        video.current = ref;
      }}
      onLoadedMetadata={() => {
        if (autoPlay) {
          video.current.play();
        } else {
          video.current.pause();
        }
      }}
      muted
      autoPlay={false}
      style={style}
      src={noav}
    />
  );
}
