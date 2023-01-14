import { Platform, ScrollView, StyleProp, ViewStyle } from "react-native";
import React, { MutableRefObject, useRef } from "react";

type Props = {
  children: JSX.Element;
  style?: StyleProp<ViewStyle>;
  horizontal?: boolean;
};

const index = (
  { children = <></>, style = {}, horizontal = false }: Props,
  ref: MutableRefObject<ScrollView>
) => {
  return (
    <ScrollView
      style={style}
      bounces={false}
      alwaysBounceHorizontal={false}
      alwaysBounceVertical={false}
      horizontal={horizontal}
      directionalLockEnabled
      showsHorizontalScrollIndicator={false}
      ref={ref}
      scrollEnabled={true}
    >
      {children}
    </ScrollView>
  );
};

export default React.forwardRef(index);
