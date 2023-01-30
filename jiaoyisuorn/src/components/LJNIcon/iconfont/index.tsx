/* tslint:disable */
/* eslint-disable */

import React, { FunctionComponent } from 'react';
import { ViewProps } from 'react-native';
import { GProps } from 'react-native-svg';
import IconJinyizhoushouyi from './IconJinyizhoushouyi';
import IconRmb from './IconRmb';
import IconXiajiantou from './IconXiajiantou';
import IconFenxiang2 from './IconFenxiang2';
import IconEye from './IconEye';
import Icon4 from './Icon4';
import IconFuzhi from './IconFuzhi';
import IconJinrujiantouxiao from './IconJinrujiantouxiao';
import IconXitongfanhui from './IconXitongfanhui';
import IconXinxi from './IconXinxi';
import IconShezhi from './IconShezhi';
import IconYuyan from './IconYuyan';
export { default as IconJinyizhoushouyi } from './IconJinyizhoushouyi';
export { default as IconRmb } from './IconRmb';
export { default as IconXiajiantou } from './IconXiajiantou';
export { default as IconFenxiang2 } from './IconFenxiang2';
export { default as IconEye } from './IconEye';
export { default as Icon4 } from './Icon4';
export { default as IconFuzhi } from './IconFuzhi';
export { default as IconJinrujiantouxiao } from './IconJinrujiantouxiao';
export { default as IconXitongfanhui } from './IconXitongfanhui';
export { default as IconXinxi } from './IconXinxi';
export { default as IconShezhi } from './IconShezhi';
export { default as IconYuyan } from './IconYuyan';

export type IconNames = 'jinyizhoushouyi' | 'rmb' | 'xiajiantou' | 'fenxiang_2' | 'eye' | '4' | 'fuzhi' | 'jinrujiantouxiao' | 'xitongfanhui' | 'xinxi' | 'shezhi' | 'yuyan';

interface Props extends GProps, ViewProps {
  name: IconNames;
  size?: number;
  color?: string | string[];
}

let IconFont: FunctionComponent<Props> = ({ name, ...rest }) => {
  switch (name) {
    case 'jinyizhoushouyi':
      return <IconJinyizhoushouyi key="1" {...rest} />;
    case 'rmb':
      return <IconRmb key="2" {...rest} />;
    case 'xiajiantou':
      return <IconXiajiantou key="3" {...rest} />;
    case 'fenxiang_2':
      return <IconFenxiang2 key="4" {...rest} />;
    case 'eye':
      return <IconEye key="5" {...rest} />;
    case '4':
      return <Icon4 key="6" {...rest} />;
    case 'fuzhi':
      return <IconFuzhi key="7" {...rest} />;
    case 'jinrujiantouxiao':
      return <IconJinrujiantouxiao key="8" {...rest} />;
    case 'xitongfanhui':
      return <IconXitongfanhui key="9" {...rest} />;
    case 'xinxi':
      return <IconXinxi key="10" {...rest} />;
    case 'shezhi':
      return <IconShezhi key="11" {...rest} />;
    case 'yuyan':
      return <IconYuyan key="12" {...rest} />;
  }

  return null;
};

IconFont = React.memo ? React.memo(IconFont) : IconFont;

export default IconFont;
