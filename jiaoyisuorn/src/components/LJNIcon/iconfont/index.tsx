/* tslint:disable */
/* eslint-disable */

import React, { FunctionComponent } from 'react';
import { ViewProps } from 'react-native';
import { GProps } from 'react-native-svg';
import IconJiahao1 from './IconJiahao1';
import IconYuyin1 from './IconYuyin1';
import IconBiaoqingbao from './IconBiaoqingbao';
import IconYuyin from './IconYuyin';
import IconYou from './IconYou';
import IconZuo from './IconZuo';
import IconGengduo1 from './IconGengduo1';
import IconFanhui from './IconFanhui';
import IconDiannao from './IconDiannao';
import IconJingyin105 from './IconJingyin105';
import IconDianzan from './IconDianzan';
import IconLike from './IconLike';
import IconLiebiao from './IconLiebiao';
import IconGupiao from './IconGupiao';
import IconJinyizhoushouyi from './IconJinyizhoushouyi';
import IconRmb from './IconRmb';
import IconXiajiantou from './IconXiajiantou';
import IconFenxiang2 from './IconFenxiang2';
import IconEye from './IconEye';
import Icon4 from './Icon4';
import IconFuzhi from './IconFuzhi';
import IconJinrujiantouxiao from './IconJinrujiantouxiao';
import IconXinxi from './IconXinxi';
import IconShezhi from './IconShezhi';
import IconYuyan from './IconYuyan';
export { default as IconJiahao1 } from './IconJiahao1';
export { default as IconYuyin1 } from './IconYuyin1';
export { default as IconBiaoqingbao } from './IconBiaoqingbao';
export { default as IconYuyin } from './IconYuyin';
export { default as IconYou } from './IconYou';
export { default as IconZuo } from './IconZuo';
export { default as IconGengduo1 } from './IconGengduo1';
export { default as IconFanhui } from './IconFanhui';
export { default as IconDiannao } from './IconDiannao';
export { default as IconJingyin105 } from './IconJingyin105';
export { default as IconDianzan } from './IconDianzan';
export { default as IconLike } from './IconLike';
export { default as IconLiebiao } from './IconLiebiao';
export { default as IconGupiao } from './IconGupiao';
export { default as IconJinyizhoushouyi } from './IconJinyizhoushouyi';
export { default as IconRmb } from './IconRmb';
export { default as IconXiajiantou } from './IconXiajiantou';
export { default as IconFenxiang2 } from './IconFenxiang2';
export { default as IconEye } from './IconEye';
export { default as Icon4 } from './Icon4';
export { default as IconFuzhi } from './IconFuzhi';
export { default as IconJinrujiantouxiao } from './IconJinrujiantouxiao';
export { default as IconXinxi } from './IconXinxi';
export { default as IconShezhi } from './IconShezhi';
export { default as IconYuyan } from './IconYuyan';

export type IconNames = 'jiahao1' | 'yuyin1' | 'biaoqingbao' | 'yuyin' | 'you' | 'zuo' | 'gengduo1' | 'fanhui' | 'diannao' | 'jingyin1-05' | 'dianzan' | 'like' | 'liebiao' | 'gupiao' | 'jinyizhoushouyi' | 'rmb' | 'xiajiantou' | 'fenxiang_2' | 'eye' | '4' | 'fuzhi' | 'jinrujiantouxiao' | 'xinxi' | 'shezhi' | 'yuyan';

interface Props extends GProps, ViewProps {
  name: IconNames;
  size?: number;
  color?: string | string[];
}

let IconFont: FunctionComponent<Props> = ({ name, ...rest }) => {
  switch (name) {
    case 'jiahao1':
      return <IconJiahao1 key="1" {...rest} />;
    case 'yuyin1':
      return <IconYuyin1 key="2" {...rest} />;
    case 'biaoqingbao':
      return <IconBiaoqingbao key="3" {...rest} />;
    case 'yuyin':
      return <IconYuyin key="4" {...rest} />;
    case 'you':
      return <IconYou key="5" {...rest} />;
    case 'zuo':
      return <IconZuo key="6" {...rest} />;
    case 'gengduo1':
      return <IconGengduo1 key="7" {...rest} />;
    case 'fanhui':
      return <IconFanhui key="8" {...rest} />;
    case 'diannao':
      return <IconDiannao key="9" {...rest} />;
    case 'jingyin1-05':
      return <IconJingyin105 key="10" {...rest} />;
    case 'dianzan':
      return <IconDianzan key="11" {...rest} />;
    case 'like':
      return <IconLike key="12" {...rest} />;
    case 'liebiao':
      return <IconLiebiao key="13" {...rest} />;
    case 'gupiao':
      return <IconGupiao key="14" {...rest} />;
    case 'jinyizhoushouyi':
      return <IconJinyizhoushouyi key="15" {...rest} />;
    case 'rmb':
      return <IconRmb key="16" {...rest} />;
    case 'xiajiantou':
      return <IconXiajiantou key="17" {...rest} />;
    case 'fenxiang_2':
      return <IconFenxiang2 key="18" {...rest} />;
    case 'eye':
      return <IconEye key="19" {...rest} />;
    case '4':
      return <Icon4 key="20" {...rest} />;
    case 'fuzhi':
      return <IconFuzhi key="21" {...rest} />;
    case 'jinrujiantouxiao':
      return <IconJinrujiantouxiao key="22" {...rest} />;
    case 'xinxi':
      return <IconXinxi key="23" {...rest} />;
    case 'shezhi':
      return <IconShezhi key="24" {...rest} />;
    case 'yuyan':
      return <IconYuyan key="25" {...rest} />;
  }

  return null;
};

IconFont = React.memo ? React.memo(IconFont) : IconFont;

export default IconFont;
