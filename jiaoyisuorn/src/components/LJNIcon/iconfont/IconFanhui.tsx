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

let IconFanhui: FunctionComponent<Props> = ({ size, color, ...rest }) => {
  return (
    <Svg viewBox="0 0 1024 1024" width={size} height={size} {...rest}>
      <Path
        d="M373.544625 511.358387l350.899882 329.200674c13.337773 13.022595 13.337773 34.127262 0 47.15088-13.33675 13.022595-34.944883 13.022595-48.278563 0L305.709657 540.155247c-2.186805-1.321088-4.26514-2.883677-6.160303-4.736884-13.328563-13.022595-13.328563-34.124192 0-47.146786l0.261966-0.249687c0.098237-0.098237 0.173962-0.196475 0.276293-0.290619 0.23843-0.23536 0.496304-0.431835 0.737804-0.659009l374.812501-350.778108c13.328563-13.027711 34.944883-13.027711 48.27754 0 13.33368 13.022595 13.33368 34.123168 0 47.146786L373.544625 511.358387 373.544625 511.358387zM373.544625 511.358387"
        fill={getIconColor(color, 0, '#272636')}
      />
    </Svg>
  );
};

IconFanhui.defaultProps = {
  size: 18,
};

IconFanhui = React.memo ? React.memo(IconFanhui) : IconFanhui;

export default IconFanhui;
