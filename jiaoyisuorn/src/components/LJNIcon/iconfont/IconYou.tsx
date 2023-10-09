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

let IconYou: FunctionComponent<Props> = ({ size, color, ...rest }) => {
  return (
    <Svg viewBox="0 0 1024 1024" width={size} height={size} {...rest}>
      <Path
        d="M210.037 456.406L602.263 104.35A87.354 87.354 0 0 1 660.613 82C708.877 82 748 121.15 748 169.444v704.111a87.476 87.476 0 0 1-22.336 58.39c-32.226 35.95-87.474 38.951-123.4 6.704L210.036 586.593a87.415 87.415 0 0 1-6.7-6.705c-32.227-35.95-29.227-91.235 6.7-123.482z"
        fill={getIconColor(color, 0, '#333333')}
      />
    </Svg>
  );
};

IconYou.defaultProps = {
  size: 18,
};

IconYou = React.memo ? React.memo(IconYou) : IconYou;

export default IconYou;
