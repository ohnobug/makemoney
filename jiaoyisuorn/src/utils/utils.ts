import { Dimensions, StyleSheet } from "react-native";

const deviceInfo = Dimensions.get("screen");
// 转换单位
export function px2vw(value: number) {
  if (value === 0.5) return 0.4;
  const baseWidth = 375;
  return (value / baseWidth) * deviceInfo.width;
}

// 防抖
export function debounce(fn: any, wait: number) {
  var timer: any = null;
  return function () {
    if (timer !== null) {
      clearTimeout(timer);
    }
    timer = setTimeout(fn, wait);
  };
}

// 点击检测
export function checkTap(
  targetRange: { x1: number; y1: number; x2: number; y2: number },
  tapPosition: { x: number; y: number }
) {
  if (
    tapPosition.x > targetRange.x1 &&
    tapPosition.x < targetRange.x2 &&
    tapPosition.y > targetRange.y1 &&
    tapPosition.y < targetRange.y2
  ) {
    return true;
  } else {
    return false;
  }
}
