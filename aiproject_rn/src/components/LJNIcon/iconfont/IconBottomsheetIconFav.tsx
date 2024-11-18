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

let IconBottomsheetIconFav: FunctionComponent<Props> = ({ size, color, ...rest }) => {
  return (
    <Svg viewBox="0 0 1024 1024" width={size} height={size} {...rest}>
      <Path
        d="M870.328889 273.066667L520.490667 475.064889 170.666667 273.066667c0.881778-0.568889 1.763556-1.123556 2.645333-1.621334L483.697778 94.051556c20.337778-11.633778 53.319111-11.619556 73.628444 0L867.697778 271.459556c0.881778 0.497778 1.763556 1.038222 2.645333 1.621333z"
        fill={getIconColor(color, 0, '#10AEFF')}
      />
      <Path
        d="M912.554667 327.509333c0.284444 2.275556 0.426667 4.494222 0.426666 6.684445v355.612444c0 23.025778-16.497778 51.128889-36.807111 62.734222L565.816889 929.948444a54.328889 54.328889 0 0 1-4.835556 2.446223v-401.92l351.573334-202.965334z"
        fill={getIconColor(color, 1, '#FA5151')}
      />
      <Path
        d="M475.178667 929.948444L164.835556 752.540444C144.483556 740.920889 128 712.632889 128 689.806222V334.193778c0-2.190222 0.142222-4.423111 0.426667-6.684445l351.573333 202.965334v401.92a54.300444 54.300444 0 0 1-4.821333-2.446223z"
        fill={getIconColor(color, 2, '#FFC300')}
      />
    </Svg>
  );
};



IconBottomsheetIconFav = React.memo ? React.memo(IconBottomsheetIconFav) : IconBottomsheetIconFav;

export default IconBottomsheetIconFav;
