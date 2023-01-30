/* tslint:disable */
/* eslint-disable */

import React, { FunctionComponent } from 'react';
import { ViewProps } from 'react-native';
import { GProps } from 'react-native-svg';
import Icon4 from './Icon4';
import IconFuzhi from './IconFuzhi';
import IconJinrujiantouxiao from './IconJinrujiantouxiao';
import IconXitongfanhui from './IconXitongfanhui';
import IconXinxi from './IconXinxi';
import IconShezhi from './IconShezhi';
import IconYuyan from './IconYuyan';
export { default as Icon4 } from './Icon4';
export { default as IconFuzhi } from './IconFuzhi';
export { default as IconJinrujiantouxiao } from './IconJinrujiantouxiao';
export { default as IconXitongfanhui } from './IconXitongfanhui';
export { default as IconXinxi } from './IconXinxi';
export { default as IconShezhi } from './IconShezhi';
export { default as IconYuyan } from './IconYuyan';

export type IconNames = '4' | 'fuzhi' | 'jinrujiantouxiao' | 'xitongfanhui' | 'xinxi' | 'shezhi' | 'yuyan';

interface Props extends GProps, ViewProps {
  name: IconNames;
  size?: number;
  color?: string | string[];
}

let IconFont: FunctionComponent<Props> = ({ name, ...rest }) => {
  switch (name) {
    case '4':
      return <Icon4 key="1" {...rest} />;
    case 'fuzhi':
      return <IconFuzhi key="2" {...rest} />;
    case 'jinrujiantouxiao':
      return <IconJinrujiantouxiao key="3" {...rest} />;
    case 'xitongfanhui':
      return <IconXitongfanhui key="4" {...rest} />;
    case 'xinxi':
      return <IconXinxi key="5" {...rest} />;
    case 'shezhi':
      return <IconShezhi key="6" {...rest} />;
    case 'yuyan':
      return <IconYuyan key="7" {...rest} />;
  }

  return null;
};

IconFont = React.memo ? React.memo(IconFont) : IconFont;

export default IconFont;
