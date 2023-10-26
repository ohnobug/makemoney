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

let IconYuyin: FunctionComponent<Props> = ({ size, color, ...rest }) => {
  return (
    <Svg viewBox="0 0 1024 1024" width={size} height={size} {...rest}>
      <Path
        d="M407.552 418.304L315.904 512 409.6 605.696c47.104-53.248 47.104-136.192-2.048-187.392z"
        fill={getIconColor(color, 0, '#333333')}
      />
      <Path
        d="M501.248 326.656L454.144 373.76c74.752 74.752 74.752 200.704 0 277.504l47.104 47.104c102.4-105.472 102.4-267.264 0-371.712z"
        fill={getIconColor(color, 1, '#333333')}
      />
      <Path
        d="M592.896 234.496l-47.104 47.104c128 128 128 332.8 0 462.848l47.104 47.104c153.6-155.648 153.6-403.456 0-557.056z"
        fill={getIconColor(color, 2, '#333333')}
      />
      <Path
        d="M514.048 4.096C232.448 4.096 4.096 232.448 4.096 514.048S232.448 1024 514.048 1024s509.952-228.352 509.952-509.952S795.648 4.096 514.048 4.096z m0 988.16C249.856 992.256 35.84 778.24 35.84 514.048 35.84 249.856 249.856 35.84 514.048 35.84s478.208 214.016 478.208 478.208c0 264.192-214.016 478.208-478.208 478.208z"
        fill={getIconColor(color, 3, '#333333')}
      />
    </Svg>
  );
};

IconYuyin.defaultProps = {
  size: 18,
};

IconYuyin = React.memo ? React.memo(IconYuyin) : IconYuyin;

export default IconYuyin;
