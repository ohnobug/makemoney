import { Dimensions } from "react-native";

const deviceInfo = Dimensions.get("screen");
// 转换单位
export function px2vw(value: number) {
  if (value === 1) return 0.5;
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
