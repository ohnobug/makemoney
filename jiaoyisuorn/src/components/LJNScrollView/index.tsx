import { ScrollView, StyleProp, ViewStyle } from "react-native";
import React from "react";
import { px2vw } from "../../utils/utils";

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
      contentContainerStyle={{
        paddingBottom: px2vw(20),
      }}
      style={style}
      ref={ref}
      horizontal={horizontal}
      bounces={false}
      alwaysBounceHorizontal={false}
      alwaysBounceVertical={false}
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
