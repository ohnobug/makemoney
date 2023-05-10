import { useEffect, useRef, useState } from "react";
import cssConfig from "./cssConfig";

const boxHeight = (cssConfig.boxSize + cssConfig.boxGap) * 2;
export function useActiveBox(
  scrollPosition: number
): [boolean, (event: any) => void] {
  let componentY = useRef(0);
  const [apply, setApply] = useState(false);

  const handleLayout = (event: any) => {
    const { x, y, width, height } = event.nativeEvent.layout;
    console.log("视图布局发生变化：", { x, y, width, height });
    componentY.current = y;

    if (
      componentY.current >= scrollPosition - (boxHeight - 100) &&
      componentY.current <= scrollPosition + 100
    ) {
      setApply(true);
    } else {
      setApply(false);
    }
  };

  useEffect(() => {
    if (
      componentY.current >= scrollPosition - (boxHeight - 100) &&
      componentY.current <= scrollPosition + 100
    ) {
      setApply(true);
    } else {
      setApply(false);
    }
  }, [scrollPosition]);

  return [apply, handleLayout];
}
