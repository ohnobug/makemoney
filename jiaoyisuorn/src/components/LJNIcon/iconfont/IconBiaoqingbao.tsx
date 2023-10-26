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

let IconBiaoqingbao: FunctionComponent<Props> = ({ size, color, ...rest }) => {
  return (
    <Svg viewBox="0 0 1024 1024" width={size} height={size} {...rest}>
      <Path
        d="M512 1024C229.226667 1024 0 794.773333 0 512S229.226667 0 512 0s512 229.226667 512 512-229.226667 512-512 512z m0-64c247.424 0 448-200.576 448-448S759.424 64 512 64 64 264.576 64 512s200.576 448 448 448z m319.637333-426.666667c-5.610667 165.909333-141.866667 298.666667-309.141333 298.666667C355.2 832 218.965333 699.242667 213.333333 533.333333h618.304zM522.496 768c109.226667 0 202.154667-71.530667 233.770667-170.666667H288.704c31.616 99.136 124.544 170.666667 233.792 170.666667zM330.666667 426.666667a74.666667 74.666667 0 1 1 0-149.333334 74.666667 74.666667 0 0 1 0 149.333334z m362.666666 0a74.666667 74.666667 0 1 1 0-149.333334 74.666667 74.666667 0 0 1 0 149.333334z"
        fill={getIconColor(color, 0, '#1F1F1F')}
      />
    </Svg>
  );
};

IconBiaoqingbao.defaultProps = {
  size: 18,
};

IconBiaoqingbao = React.memo ? React.memo(IconBiaoqingbao) : IconBiaoqingbao;

export default IconBiaoqingbao;
