import {
  Animated,
  LayoutRectangle,
  PanResponder,
  ScrollView,
  StyleSheet,
  Text,
  View,
} from "react-native";
import React, { useEffect, useRef, useState } from "react";
import { px2vw } from "../../../../../../utils/utils";

type Props = {
  tabs: Array<string>;
  activeIndex: number;
  onChange: (index: number) => void;
};

let isScroll = false;
let topTabs: Array<ITabItem> = [];

const index = ({ activeIndex, onChange, tabs }: Props) => {
  // 滚动对象
  let scroll = useRef<any>(null);

  // tabs 底部蓝色
  const springLeft = useRef(new Animated.Value(0)).current;
  const springWidth = useRef(new Animated.Value(0)).current;

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

  // Scroll
  let _pan1 = useRef(
    PanResponder.create({
      onStartShouldSetPanResponderCapture() {
        return false;
      },
      onStartShouldSetPanResponder() {
        return false;
      },
      onMoveShouldSetPanResponder() {
        return true;
      },
      onPanResponderTerminationRequest() {
        return false;
      },
      onPanResponderGrant() {
        console.log("parent onPanResponderGrant");
      },
      onPanResponderStart() {
        console.log("parent onPanResponderStart");
      },
      onPanResponderMove() {
        console.log("parent onPanResponderMove");
        isScroll = true;
      },
      onPanResponderEnd(e, gesture) {
        console.log("parent onPanResponderEnd");
        isScroll = false;
      },
      onPanResponderReject() {
        console.log("parent onPanResponderReject");
      },
      onPanResponderTerminate(e, gesture) {
        console.log("parent onPanResponderTerminate");
      },
    })
  ).current;

  // 按钮
  let _pan2 = useRef(
    PanResponder.create({
      onStartShouldSetPanResponderCapture() {
        return true;
      },
      onStartShouldSetPanResponder() {
        return true;
      },
      onMoveShouldSetPanResponder() {
        return true;
      },
      onPanResponderTerminationRequest() {
        return true;
      },
      onPanResponderStart() {
        console.log("child onPanResponderStart");
      },
      onPanResponderGrant(e, gestureState) {
        console.log("child onPanResponderGrant");
      },
      onPanResponderMove() {
        console.log("child onPanResponderMove");
      },
      onPanResponderEnd(e, gesture) {
        console.log("child onPanResponderEnd");
      },
      onPanResponderReject() {
        console.log("child onPanResponderReject");
      },
      onPanResponderTerminate(e, gesture) {
        console.log("child onPanResponderTerminate");
      },
    })
  ).current;

  // 当按钮改变的时候;
  const change = (activeIndex: number) => {
    if (topTabs.length === 0) return;

    const item = topTabs[activeIndex];
    // 下方蓝色方块动画
    if (item.x <= 0) {
      spring(px2vw(10), px2vw(35.79));
    } else {
      spring(item.x, item.width);
    }
    // 居中-------------------------------------
    let value = item.x - px2vw(182.5) + item.width / 2;
    if (value < 0) value = 0;
    scroll.current.scrollTo({
      x: value,
      animated: true,
    });
    // 居中-------------------------------------
    // 父节点方法
    onChange && onChange(activeIndex);
  };

  // 当外部改变activeIndex的时候
  useEffect(() => {
    change(activeIndex);
  }, [activeIndex]);

  useEffect(() => {
    let n = tabs.map((item) => {
      return {
        tabname: item,
        x: 0,
        width: 0,
      };
    });
    topTabs = n;

    // 一进来初始化，让蓝色小块移动正确的位置
    setTimeout(() => {
      change(activeIndex);
    }, 200);
  }, []);

  return (
    <View style={styles.ljn_tabs}>
      <ScrollView
        horizontal
        directionalLockEnabled
        showsHorizontalScrollIndicator={false}
        // snapToAlignment="center"
        ref={scroll}
        scrollEventThrottle={16}
        {..._pan1.panHandlers}
      >
        <Animated.View
          style={StyleSheet.flatten([
            styles.ljn_fly_bottom,
            {
              width: springWidth,
              left: springLeft,
            },
          ])}
        ></Animated.View>

        {tabs.map((item, index) => {
          return (
            <View
              onLayout={(event) => {
                const layout: LayoutRectangle = event.nativeEvent.layout;
                topTabs[index].x = layout.x + px2vw(10);
                topTabs[index].width = layout.width - px2vw(20);
              }}
              style={{
                ...styles.ljn_tab,
              }}
              key={index}
              {..._pan2.panHandlers}
              onTouchStart={() => {
                console.log("onTouch");
              }}
              onTouchEnd={() => {
                console.log("onTouchEnd");
                console.log(isScroll);
                if (!isScroll) change(index);
              }}
            >
              <Text
                style={Object.assign(
                  {},
                  styles.ljn_tab_text,
                  activeIndex === index ? styles.ljn_tab_text_active : null
                )}
              >
                {item}
              </Text>
            </View>
          );
        })}
      </ScrollView>
    </View>
  );
};

export default index;

const styles = StyleSheet.create({
  ljn_tabs: {
    flex: 1,
    width: px2vw(375),
    maxHeight: px2vw(43),
    borderBottomWidth: px2vw(1),
    borderBottomColor: "#272f3c",
  },
  ljn_tab: {
    paddingLeft: px2vw(10),
    paddingRight: px2vw(10),
    height: px2vw(40),
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
  },
  ljn_fly_bottom: {
    height: px2vw(3),
    backgroundColor: "#32a1fc",
    position: "absolute",
    bottom: 0,
    left: 0,
  },
  ljn_tab_text: {
    color: "#5c6175",
    fontSize: px2vw(14),
    fontWeight: "600",
  },
  ljn_tab_text_active: {
    color: "#32a1fc",
  },
});

interface ITabItem {
  tabname: string;
  x: number;
  width: number;
}
