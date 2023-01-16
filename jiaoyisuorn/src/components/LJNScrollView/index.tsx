import { ScrollView, StyleProp, ViewStyle } from "react-native";
import React from "react";

type Props = {
  children: JSX.Element;
  style?: StyleProp<ViewStyle>;
  horizontal?: boolean;
};

const index = (
  { children = <></>, style = {}, horizontal = false }: Props,
  ref: any
) => {
  return (
    <ScrollView
      style={style}
      ref={ref}
      horizontal={horizontal}
      bounces={false}
      alwaysBounceHorizontal={false}
      alwaysBounceVertical={false}
      directionalLockEnabled={true}
      showsHorizontalScrollIndicator={false}
      scrollEnabled={true}
    >
      {children}
    </ScrollView>
  );
};

export default React.forwardRef(index);
