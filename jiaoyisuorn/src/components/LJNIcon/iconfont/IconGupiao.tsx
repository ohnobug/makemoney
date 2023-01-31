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

let IconGupiao: FunctionComponent<Props> = ({ size, color, ...rest }) => {
  return (
    <Svg viewBox="0 0 1024 1024" width={size} height={size} {...rest}>
      <Path
        d="M757.215 181.305h74.655c35.34 0 63.99 28.65 63.99 63.99v298.62c0 35.34-28.65 63.99-63.99 63.99h-74.655V725.22h-63.99V607.905H618.57c-35.34 0-63.99-28.65-63.99-63.99v-298.62c0-35.34 28.65-63.99 63.99-63.99h74.655V85.32h63.99v95.985z m-426.6 213.3h74.655c35.34 0 63.99 28.65 63.99 63.99v319.95c0 35.34-28.65 63.99-63.99 63.99h-74.655v95.985h-63.99v-95.985H191.97c-35.34 0-63.99-28.65-63.99-63.99v-319.95c0-35.34 28.65-63.99 63.99-63.99h74.655V298.62h63.99v95.985z m-138.645 63.99v319.95h213.3v-319.95h-213.3z m426.6-213.3v298.62h213.3v-298.62h-213.3z"
        fill={getIconColor(color, 0, '#000000')}
      />
    </Svg>
  );
};

IconGupiao.defaultProps = {
  size: 18,
};

IconGupiao = React.memo ? React.memo(IconGupiao) : IconGupiao;

export default IconGupiao;
