import emitter from "bus";
import { useStyles } from "hooks";
import React, { useEffect, useRef } from "react";
import { Animated, FlatList, ScrollView, View } from "react-native";
import { px2vw } from "utils/utils";
import LJNTabbar from "./components/LJNTabbar";
import slides from "./slides";
import AssetsSlide from "./slides/AssetsSlide";
import ChatSlide from "./slides/ChatSlide";
import ContractSlide from "./slides/ContractSlide";
import HomeSlide from "./slides/HomeSlide";
import TransactionSlide from "./slides/TransactionSlide";
import UserSlide from "./slides/UserSlide";
import { setTheme } from "./styles";
import { Outlet } from "react-router-dom";

interface OnboardingItem {
  id: string;
  title: string;
  description: string;
}

interface RenderSlideProps {
  id: string;
}

const OnboardingItem = (qqq) => {
  const { id, title, description } = qqq.item;

  const RenderSlide = ({ id }: RenderSlideProps) => {
    if (id === "1") {
      return <HomeSlide></HomeSlide>;
    } else if (id === "2") {
      return <ChatSlide></ChatSlide>;
    } else if (id === "3") {
      return <TransactionSlide></TransactionSlide>;
    } else if (id === "4") {
      return <ContractSlide></ContractSlide>;
    } else if (id === "5") {
      return <AssetsSlide></AssetsSlide>;
    } else if (id === "6") {
      return <UserSlide></UserSlide>;
    }
  };

  return (
    <View
      style={{
        flex: 1,
        width: px2vw(375),
      }}
    >
      <RenderSlide id={id} />
    </View>
  );
};

type Props = {};
export default function index({}: Props) {
  let bigScrollView = useRef<ScrollView>(null);

  useEffect(() => {
    emitter.emit("getBigScrollView", bigScrollView.current);
  }, [bigScrollView]);

  const styles = useStyles(setTheme);
  const scrollx = useRef(new Animated.Value(0)).current;

  return (
    <View style={styles.container}>
      <Outlet />

      <FlatList
        data={slides}
        renderItem={(qq) => <OnboardingItem item={qq.item} />}
        horizontal
        showsHorizontalScrollIndicator={false}
        pagingEnabled
        bounces={false}
        keyExtractor={(item) => item.id}
        onScroll={Animated.event(
          [{ nativeEvent: { contentOffset: { x: scrollx } } }],
          {
            useNativeDriver: false,
          }
        )}
      />

      {/* 底部 */}
      <View style={styles.ljn_footer}>
        <LJNTabbar />
      </View>
    </View>
  );
}
