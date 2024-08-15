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

let IconFenxiang2: FunctionComponent<Props> = ({ size, color, ...rest }) => {
  return (
    <Svg viewBox="0 0 1024 1024" width={size} height={size} {...rest}>
      <Path
        d="M779.636364 954.181818h-535.272728A174.778182 174.778182 0 0 1 69.818182 779.636364v-535.272728A174.778182 174.778182 0 0 1 244.363636 69.818182H512a34.909091 34.909091 0 0 1 0 69.818182H244.363636A104.96 104.96 0 0 0 139.636364 244.363636v535.272728a104.96 104.96 0 0 0 104.727272 104.727272h535.272728a104.96 104.96 0 0 0 104.727272-104.727272V512a34.909091 34.909091 0 0 1 69.818182 0v267.636364a174.778182 174.778182 0 0 1-174.545454 174.545454z"
        fill={getIconColor(color, 0, '#333333')}
      />
      <Path
        d="M500.363636 558.545455a35.141818 35.141818 0 0 1-24.669091-10.24 34.676364 34.676364 0 0 1 0-49.338182l418.909091-418.909091a34.909091 34.909091 0 0 1 49.338182 49.338182l-418.909091 418.909091a35.141818 35.141818 0 0 1-24.669091 10.24z"
        fill={getIconColor(color, 1, '#333333')}
      />
      <Path
        d="M919.272727 139.636364h-186.181818a34.909091 34.909091 0 0 1 0-69.818182h186.181818a34.909091 34.909091 0 0 1 0 69.818182z"
        fill={getIconColor(color, 2, '#333333')}
      />
      <Path
        d="M919.272727 325.818182a34.909091 34.909091 0 0 1-34.909091-34.909091v-186.181818a34.909091 34.909091 0 0 1 69.818182 0v186.181818a34.909091 34.909091 0 0 1-34.909091 34.909091z"
        fill={getIconColor(color, 3, '#333333')}
      />
    </Svg>
  );
};



IconFenxiang2 = React.memo ? React.memo(IconFenxiang2) : IconFenxiang2;

export default IconFenxiang2;
