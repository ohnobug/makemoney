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

let IconZuo: FunctionComponent<Props> = ({ size, color, ...rest }) => {
  return (
    <Svg viewBox="0 0 1024 1024" width={size} height={size} {...rest}>
      <Path
        d="M764.963 456.406L372.737 104.35A87.354 87.354 0 0 0 314.387 82C266.123 82 227 121.15 227 169.444v704.111a87.476 87.476 0 0 0 22.336 58.39c32.226 35.95 87.474 38.951 123.4 6.704l392.227-352.056a87.415 87.415 0 0 0 6.7-6.705c32.227-35.95 29.227-91.235-6.7-123.482z"
        fill={getIconColor(color, 0, '#333333')}
      />
    </Svg>
  );
};



IconZuo = React.memo ? React.memo(IconZuo) : IconZuo;

export default IconZuo;
