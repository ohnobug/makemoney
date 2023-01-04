import { Dimensions } from "react-native";

const deviceInfo = Dimensions.get("screen");
// 转换单位
export function px2vw(value: number) {
  const baseWidth = 375;
  return (value / baseWidth) * deviceInfo.width;
}
