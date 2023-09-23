import React, { useEffect, useState } from "react";
import IconFont from "./iconfont";
import { useAppSelector } from "hooks";
import { selectAppTheme } from "store/SystemSlice";
import darkTheme from "themes/default/styles";
import lightTheme from "themes/light/styles";
import { px2vw } from "utils/utils";

type Props = {
  title: string;
  size?: number;
  color?: string;
};

const index = ({ title, size = 20, color = "" }: Props) => {
  const theme = useAppSelector(selectAppTheme);
  const [IconColor, setIconColor] = useState<string>(color);

  size = px2vw(size);

  useEffect(() => {
    if (color === "") {
      if (theme === "dark") {
        setIconColor(darkTheme.titleTextColor);
      } else {
        setIconColor(lightTheme.titleTextColor);
      }
    }
  }, []);

  return <IconFont name={title as any} size={size} color={IconColor} />;
};

export default index;
