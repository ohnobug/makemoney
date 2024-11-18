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

let IconDiannao: FunctionComponent<Props> = ({ size, color, ...rest }) => {
  return (
    <Svg viewBox="0 0 1024 1024" width={size} height={size} {...rest}>
      <Path
        d="M832 149.333333H192a85.333333 85.333333 0 0 0-85.333333 85.333334v448a85.333333 85.333333 0 0 0 85.333333 85.333333h640a85.333333 85.333333 0 0 0 85.333333-85.333333V234.666667a85.333333 85.333333 0 0 0-85.333333-85.333334z m42.666667 533.333334a42.666667 42.666667 0 0 1-42.666667 42.666666H192a42.666667 42.666667 0 0 1-42.666667-42.666666V234.666667a42.666667 42.666667 0 0 1 42.666667-42.666667h640a42.666667 42.666667 0 0 1 42.666667 42.666667zM725.333333 832H298.666667a21.333333 21.333333 0 0 0 0 42.666667h426.666666a21.333333 21.333333 0 0 0 0-42.666667z"
        fill={getIconColor(color, 0, '#333333')}
      />
    </Svg>
  );
};



IconDiannao = React.memo ? React.memo(IconDiannao) : IconDiannao;

export default IconDiannao;
