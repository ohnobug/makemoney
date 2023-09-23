import {
  NativeScrollEvent,
  NativeSyntheticEvent,
  ScrollView,
  StyleProp,
  ViewStyle,
} from "react-native";
import React from "react";
import { px2vw } from "utils/utils";

type Props = {
  children: JSX.Element;
  style?: StyleProp<ViewStyle>;
  horizontal?: boolean;
  onScroll?: (event: NativeSyntheticEvent<NativeScrollEvent>) => void;
  scrollEventThrottle?: number;
};

const index = (
  {
    children = <></>,
    style = {},
    horizontal = false,
    onScroll,
    scrollEventThrottle = 16,
  }: Props,
  ref: any
) => {
  return (
    <ScrollView
      contentContainerStyle={{
        paddingBottom: px2vw(20),
      }}
      scrollEventThrottle={scrollEventThrottle}
      onScroll={onScroll}
      style={style}
      ref={ref}
      horizontal={horizontal}
      bounces={true}
      alwaysBounceHorizontal={true}
      alwaysBounceVertical={true}
      directionalLockEnabled={true}
      showsHorizontalScrollIndicator={false}
      showsVerticalScrollIndicator={false}
      scrollEnabled={true}
      overScrollMode={"never"}
      disableIntervalMomentum={true}
      disableScrollViewPanResponder={true}
    >
      {children}
    </ScrollView>
  );
};

export default React.forwardRef(index);
