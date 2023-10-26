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

let IconYuyin1: FunctionComponent<Props> = ({ size, color, ...rest }) => {
  return (
    <Svg viewBox="0 0 1024 1024" width={size} height={size} {...rest}>
      <Path
        d="M512 960A448 448 0 1 1 960 512 448.5 448.5 0 0 1 512 960z m0-832a384 384 0 1 0 384 384 384.5 384.5 0 0 0-384-384z"
        fill={getIconColor(color, 0, '#333333')}
      />
      <Path
        d="M567.8 800a31.6 31.6 0 0 1-22.6-9.4 31.9 31.9 0 0 1 0-45.2 330 330 0 0 0 0-466.8 32 32 0 1 1 45.3-45.2 394 394 0 0 1 0 557.2 31.9 31.9 0 0 1-22.7 9.4z"
        fill={getIconColor(color, 1, '#333333')}
      />
      <Path
        d="M450 681.8a32 32 0 0 1-22.6-54.6 163 163 0 0 0 0-230 32 32 0 0 1 45.2-45.3 226.9 226.9 0 0 1 0 321 31.9 31.9 0 0 1-22.6 8.9z"
        fill={getIconColor(color, 2, '#333333')}
      />
      <Path
        d="M311.8 512m-55.7 0a55.7 55.7 0 1 0 111.4 0 55.7 55.7 0 1 0-111.4 0Z"
        fill={getIconColor(color, 3, '#333333')}
      />
    </Svg>
  );
};

IconYuyin1.defaultProps = {
  size: 18,
};

IconYuyin1 = React.memo ? React.memo(IconYuyin1) : IconYuyin1;

export default IconYuyin1;
