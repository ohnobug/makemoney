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

let IconLiebiao: FunctionComponent<Props> = ({ size, color, ...rest }) => {
  return (
    <Svg viewBox="0 0 1024 1024" width={size} height={size} {...rest}>
      <Path
        d="M64 480h352V128H64v352z m64-288h224v224H128V192zM64 928h352V576H64v352z m64-288h224v224H128v-224zM526.848 224H928a32 32 0 1 0 0-64H526.848a32 32 0 0 0 0 64zM928 608H526.848a32 32 0 1 0 0 64H928a32 32 0 1 0 0-64zM928 384H526.848a32 32 0 0 0 0 64H928a32 32 0 1 0 0-64zM928 832H526.848a32 32 0 1 0 0 64H928a32 32 0 1 0 0-64z"
        fill={getIconColor(color, 0, '#333333')}
      />
    </Svg>
  );
};

IconLiebiao.defaultProps = {
  size: 18,
};

IconLiebiao = React.memo ? React.memo(IconLiebiao) : IconLiebiao;

export default IconLiebiao;
