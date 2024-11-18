import { Image } from "react-native";
import React from "react";

// const boxempty = require("../../../../assets/images/boxempty.png");
type Props = {
  style: any;
  img: any;
};

export default function index({ style, img }: Props) {
  // 加载中还需要显示一张空白的图片

  return (
    <Image
      style={style}
      source={{
        uri: img,
      }}
    />
  );
}
