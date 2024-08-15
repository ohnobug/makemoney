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

let IconEye: FunctionComponent<Props> = ({ size, color, ...rest }) => {
  return (
    <Svg viewBox="0 0 1024 1024" width={size} height={size} {...rest}>
      <Path
        d="M512 832C128 832 0 512 0 512S128 192 512 192s512 320 512 320-128 320-512 320z m0-512c-106.048 0-192 85.952-192 192s85.952 192 192 192 192-85.952 192-192-85.952-192-192-192z m0 320c-70.656 0-128-57.344-128-128h128l-90.496-90.496A127.36 127.36 0 0 1 512 384c70.656 0 128 57.344 128 128s-57.344 128-128 128z"
        fill={getIconColor(color, 0, '#333333')}
      />
    </Svg>
  );
};



IconEye = React.memo ? React.memo(IconEye) : IconEye;

export default IconEye;
