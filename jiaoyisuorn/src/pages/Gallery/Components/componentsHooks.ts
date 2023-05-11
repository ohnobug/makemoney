import { useEffect, useRef, useState } from "react";
import cssConfig from "./cssConfig";

const boxHeight = (cssConfig.boxSize + cssConfig.boxGap) * 2;
export function useActiveBox(
  componentY: number,
  scrollPosition: number
): boolean {
  const [apply, setApply] = useState(false);

  useEffect(() => {
    if (
      componentY >= scrollPosition - (boxHeight - 200) &&
      componentY <= scrollPosition + 200
    ) {
      setApply(true);
    } else {
      setApply(false);
    }
  }, []);

  useEffect(() => {
    if (
      componentY >= scrollPosition - (boxHeight - 200) &&
      componentY <= scrollPosition + 200
    ) {
      setApply(true);
    } else {
      setApply(false);
    }
  }, [scrollPosition]);

  return apply;
}
