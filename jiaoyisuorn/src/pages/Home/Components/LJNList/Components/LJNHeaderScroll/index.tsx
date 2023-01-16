/// <reference path="../../../../index.d.ts" />

import {
  Animated,
  LayoutRectangle,
  ScrollView,
  StyleSheet,
  Text,
  View,
} from "react-native";
import React, { useEffect, useImperativeHandle, useRef, useState } from "react";
import { px2vw } from "../../../../../../utils/utils";
import LJNScrollView from "../../../../../../components/LJNScrollView";
import { useAppSelector } from "../../../../../../hooks";
import { setTheme } from "./styles";
import { selectTheme } from "../../../../../../store/SystemSlice";

type Props = {
  list: string[];
  onChange: (index: number) => void;
};

// 位置信息
const index = ({ list, onChange }: Props, ref: any) => {
  const theme = useAppSelector(selectTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
  }, [theme]);

  let TabPositionInfo: { x: number; width: number }[] = useRef([]).current;
  // 滚动对象
  let myScrollView = useRef<ScrollView>(null);
  const [activeIndex, setActiveIndex] = useState(0);

  // tabs 底部蓝色
  const springLeft = useRef(new Animated.Value(9.6)).current;
  const springWidth = useRef(new Animated.Value(26.8)).current;

  // 蓝块滑动
  const spring = (x: number, width: number) => {
    let c: Animated.TimingAnimationConfig = {
      toValue: x,
      duration: 300,
      useNativeDriver: false,
    };
    Animated.timing(springLeft, c).start();

    let d: Animated.TimingAnimationConfig = {
      toValue: width,
      duration: 200,
      useNativeDriver: false,
    };
    Animated.timing(springWidth, d).start();
  };

  // 当按钮改变的时候;
  const change = (index: number, callfunction: boolean = true) => {
    if (TabPositionInfo.length !== list.length) index = 0;

    const item = TabPositionInfo[index];

    // 下方蓝色方块动画
    if (item) {
      spring(item.x, item.width);
      // 居中-------------------------------------
      let value = item.x - px2vw(182.5) + item.width / 2;
      if (value < 0) value = 0;
      myScrollView.current?.scrollTo({
        x: value,
        animated: true,
      });
    }

    if (callfunction) {
      // 父节点方法
      onChange && onChange(index);
    }
  };

  useImperativeHandle(ref, () => ({
    goTo: (index: number) => {
      setActiveIndex(index);
    },
  }));

  useEffect(() => {
    change(activeIndex);
  }, [activeIndex]);

  return (
    <LJNScrollView
      style={styles.ljn_tabs}
      horizontal={true}
      ref={myScrollView}
      children={
        <>
          <Animated.View
            style={StyleSheet.flatten([
              styles.ljn_fly_bottom,
              {
                width: springWidth,
                left: springLeft,
              },
            ])}
          ></Animated.View>

          {list.map((item, index) => {
            return (
              <View
                onLayout={(event) => {
                  const layout: LayoutRectangle = event.nativeEvent.layout;
                  TabPositionInfo.push({
                    x: layout.x + px2vw(10),
                    width: layout.width - px2vw(20),
                  });
                }}
                style={styles.ljn_tab}
                key={index}
                onTouchEnd={() => {
                  setActiveIndex(index);
                }}
              >
                <Text
                  style={StyleSheet.flatten([
                    styles.ljn_tab_text,
                    index === activeIndex ? styles.ljn_tab_text_active : null,
                  ])}
                >
                  {item}
                </Text>
              </View>
            );
          })}
        </>
      }
    />
  );
};

export default React.forwardRef(index);

interface ITabPositionInfo {
  x: number;
  width: number;
}
