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

let Icon4: FunctionComponent<Props> = ({ size, color, ...rest }) => {
  return (
    <Svg viewBox="0 0 1024 1024" width={size} height={size} {...rest}>
      <Path
        d="M780.2 447.8c10.9-66.9-36.7-97.9-63.4-115-26.6-17.1-67.3-29.4-67.3-29.4l26-104.2-60-15-26 104.2-48-12 26-104.2-60.7-15.1-26 104.2-127-31.7-15.4 61.8s62.7 15.6 69.6 17.4c7 1.7 6.1 5.3 5.5 7.6-0.6 2.4-78.9 316.5-80 320.7-1 4.2-1.7 6.6-7.5 5.2-5.9-1.5-66.6-16.6-66.6-16.6l-17.1 68.7L365.2 725l-24.9 99.7 65.5 16.3 24.9-99.7 40.8 10.2-24.9 99.7 62.4 15.6 24.9-99.7s15.7 3.9 47 11.7c31.2 7.8 149.7 9.3 175.5-94.3C782.2 580.9 696.8 537 696.8 537s72.4-22.2 83.4-89.2zM638 640c-12.4 49.6-68 53.4-80.6 50.2-12.7-3.2-111.6-27.8-111.6-27.8l33-132.4s93.3 23.3 115.6 28.8c22.2 5.6 56 31.6 43.6 81.2z m20.6-201.7c-13.2 52.8-66.2 50.4-82.9 46.3-16.7-4.2-81.5-20.3-81.5-20.3l31.4-126.1s61.7 15.4 74.4 18.5c12.7 3.2 71.8 28.8 58.6 81.6z"
        fill={getIconColor(color, 0, '#F9934A')}
      />
    </Svg>
  );
};

Icon4.defaultProps = {
  size: 18,
};

Icon4 = React.memo ? React.memo(Icon4) : Icon4;

export default Icon4;
