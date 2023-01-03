import { Dimensions } from "react-native";

const deviceInfo = Dimensions.get("screen");
export function px2vw(value: number) {
  const baseWidth = 750;
  return (value / baseWidth) * deviceInfo.width;
}
