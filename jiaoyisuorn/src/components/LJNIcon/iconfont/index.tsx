/* tslint:disable */
/* eslint-disable */

import React, { FunctionComponent } from 'react';
import { ViewProps } from 'react-native';
import { GProps } from 'react-native-svg';
import IconLiebiao from './IconLiebiao';
import IconGengduo from './IconGengduo';
import IconGupiao from './IconGupiao';
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
export { default as IconLiebiao } from './IconLiebiao';
export { default as IconGengduo } from './IconGengduo';
export { default as IconGupiao } from './IconGupiao';
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

export type IconNames = 'liebiao' | 'gengduo' | 'gupiao' | 'jinyizhoushouyi' | 'rmb' | 'xiajiantou' | 'fenxiang_2' | 'eye' | '4' | 'fuzhi' | 'jinrujiantouxiao' | 'xitongfanhui' | 'xinxi' | 'shezhi' | 'yuyan';

interface Props extends GProps, ViewProps {
  name: IconNames;
  size?: number;
  color?: string | string[];
}

let IconFont: FunctionComponent<Props> = ({ name, ...rest }) => {
  switch (name) {
    case 'liebiao':
      return <IconLiebiao key="1" {...rest} />;
    case 'gengduo':
      return <IconGengduo key="2" {...rest} />;
    case 'gupiao':
      return <IconGupiao key="3" {...rest} />;
    case 'jinyizhoushouyi':
      return <IconJinyizhoushouyi key="4" {...rest} />;
    case 'rmb':
      return <IconRmb key="5" {...rest} />;
    case 'xiajiantou':
      return <IconXiajiantou key="6" {...rest} />;
    case 'fenxiang_2':
      return <IconFenxiang2 key="7" {...rest} />;
    case 'eye':
      return <IconEye key="8" {...rest} />;
    case '4':
      return <Icon4 key="9" {...rest} />;
    case 'fuzhi':
      return <IconFuzhi key="10" {...rest} />;
    case 'jinrujiantouxiao':
      return <IconJinrujiantouxiao key="11" {...rest} />;
    case 'xitongfanhui':
      return <IconXitongfanhui key="12" {...rest} />;
    case 'xinxi':
      return <IconXinxi key="13" {...rest} />;
    case 'shezhi':
      return <IconShezhi key="14" {...rest} />;
    case 'yuyan':
      return <IconYuyan key="15" {...rest} />;
  }

  return null;
};

IconFont = React.memo ? React.memo(IconFont) : IconFont;

export default IconFont;
