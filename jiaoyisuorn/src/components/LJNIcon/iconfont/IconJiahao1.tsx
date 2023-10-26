/* tslint:disable */
/* eslint-disable */

import React, { FunctionComponent } from 'react';
import { ViewProps } from 'react-native';
import { Svg, GProps, Path } from 'react-native-svg';
import { getIconColor } from './helper';

interface Props extends GProps, ViewProps {
  size?: number;
  color?: string | string[];
}

let IconJiahao1: FunctionComponent<Props> = ({ size, color, ...rest }) => {
  return (
    <Svg viewBox="0 0 1024 1024" width={size} height={size} {...rest}>
      <Path
        d="M512.005709 0C229.233963 0 0 229.233963 0 512.005709s229.233963 511.994291 512.005709 511.994291 512.005709-229.222546 512.005709-511.994291S794.777454 0 512.005709 0z m0 955.493561A443.624865 443.624865 0 0 1 339.403735 103.330546 443.624865 443.624865 0 0 1 684.607682 920.669454a440.576328 440.576328 0 0 1-172.601973 34.824107z"
        fill={getIconColor(color, 0, '#333333')}
      />
      <Path
        d="M512.005709 199.467915a34.355979 34.355979 0 0 0-34.25322 34.25322v244.031354H233.721135a34.25322 34.25322 0 1 0 0 68.506439h244.031354v244.019937a34.25322 34.25322 0 0 0 68.506439 0V546.258928h244.031355a34.25322 34.25322 0 1 0 0-68.506439H546.258928V233.721135a34.355979 34.355979 0 0 0-34.253219-34.25322z"
        fill={getIconColor(color, 1, '#333333')}
      />
    </Svg>
  );
};

IconJiahao1.defaultProps = {
  size: 18,
};

IconJiahao1 = React.memo ? React.memo(IconJiahao1) : IconJiahao1;

export default IconJiahao1;
