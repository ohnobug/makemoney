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

let IconShoufukuan: FunctionComponent<Props> = ({ size, color, ...rest }) => {
  return (
    <Svg viewBox="0 0 1283 1024" width={size} height={size} {...rest}>
      <Path
        d="M924.55936 0h357.888v67.072h-357.888z"
        fill={getIconColor(color, 0, '#333333')}
      />
      <Path
        d="M1216.24064 358.88128V0.99328h67.072v357.888zM1282.90816 665.13408v357.888h-67.072v-357.888z"
        fill={getIconColor(color, 1, '#333333')}
      />
      <Path
        d="M924.04736 956.928h357.888V1024h-357.888zM359.3216 1023.81568H1.4336v-67.072h357.888z"
        fill={getIconColor(color, 2, '#333333')}
      />
      <Path
        d="M67.072 664.9344v357.888h-67.072v-357.888z"
        fill={getIconColor(color, 3, '#333333')}
      />
      <Path
        d="M0.70656 359.808V1.92h67.072v357.888z"
        fill={getIconColor(color, 4, '#333333')}
      />
      <Path
        d="M359.86432 67.9168H1.97632V0.8448h357.888z"
        fill={getIconColor(color, 5, '#333333')}
      />
      <Path
        d="M562.57536 722.944c-10.752 0-22.016-4.096-30.208-12.8L360.84736 537.6a42.9568 42.9568 0 0 1 0-60.928c16.896-16.896 44.032-16.896 60.928 0l141.312 141.824 269.824-271.36c16.896-16.896 44.032-16.896 60.928 0 16.896 16.896 16.896 44.032 0 60.928l-300.544 301.568a41.984 41.984 0 0 1-30.72 13.312z"
        fill={getIconColor(color, 6, '#333333')}
      />
    </Svg>
  );
};



IconShoufukuan = React.memo ? React.memo(IconShoufukuan) : IconShoufukuan;

export default IconShoufukuan;
