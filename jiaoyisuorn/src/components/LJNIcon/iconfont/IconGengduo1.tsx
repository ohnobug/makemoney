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

let IconGengduo1: FunctionComponent<Props> = ({ size, color, ...rest }) => {
  return (
    <Svg viewBox="0 0 1024 1024" width={size} height={size} {...rest}>
      <Path
        d="M89.088 492.715c0 0 0 0 0 0 0 43.547 35.301 78.848 78.848 78.848 43.547 0 78.848-35.301 78.848-78.848 0-0 0-0-0-0 0-43.547-35.301-78.848-78.848-78.848-43.547 0-78.848 35.301-78.848 78.848z"
        fill={getIconColor(color, 0, '#333333')}
      />
      <Path
        d="M432.128 492.715c0 0 0 0 0 0 0 43.547 35.301 78.848 78.848 78.848 43.547 0 78.848-35.301 78.848-78.848 0-0 0-0 0-0 0-43.547-35.301-78.848-78.848-78.848-43.547 0-78.848 35.301-78.848 78.848 0 0 0 0 0 0z"
        fill={getIconColor(color, 1, '#333333')}
      />
      <Path
        d="M774.144 492.715c0 43.547 35.301 78.848 78.848 78.848s78.848-35.301 78.848-78.848c0-0 0-0 0-0 0-43.547-35.301-78.848-78.848-78.848-43.547 0-78.848 35.301-78.848 78.848 0 0 0 0 0 0z"
        fill={getIconColor(color, 2, '#333333')}
      />
    </Svg>
  );
};

IconGengduo1.defaultProps = {
  size: 18,
};

IconGengduo1 = React.memo ? React.memo(IconGengduo1) : IconGengduo1;

export default IconGengduo1;
