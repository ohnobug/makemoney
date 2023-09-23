import React, { useRef, useState } from "react";
import { Image, Platform, View, VirtualizedList } from "react-native";
import { Gesture, GestureDetector } from "react-native-gesture-handler";
import LJNTabbar from "../../components/LJNTabbar";
import { useStyles } from "../../hooks";
import { debounce } from "../../utils/utils";
import LJNGalleryStyle1 from "./Components/LJNGalleryStyle1";
import LJNGalleryStyle2 from "./Components/LJNGalleryStyle2";
import LJNGalleryStyle3 from "./Components/LJNGalleryStyle3";
import LJNGalleryStyle4 from "./Components/LJNGalleryStyle4";
import LJNModal from "./Components/LJNModal";
import cssConfig from "./Components/cssConfig";
import { setTheme } from "./styles";

// 图片准备
let imagesArr = [
  require("../../assets/gallery/1.jpg"),
  require("../../assets/gallery/2.jpg"),
  require("../../assets/gallery/3.jpg"),
  require("../../assets/gallery/4.jpg"),
  require("../../assets/gallery/5.jpg"),
  require("../../assets/gallery/6.jpg"),
  require("../../assets/gallery/7.jpg"),
  require("../../assets/gallery/8.jpg"),
  require("../../assets/gallery/9.jpg"),
  require("../../assets/gallery/10.jpg"),
  require("../../assets/gallery/11.jpg"),
  require("../../assets/gallery/12.jpg"),
  require("../../assets/gallery/13.jpg"),
  require("../../assets/gallery/14.jpg"),
  require("../../assets/gallery/15.jpg"),
  require("../../assets/gallery/16.jpg"),
  require("../../assets/gallery/17.jpg"),
  require("../../assets/gallery/18.jpg"),
  require("../../assets/gallery/19.jpg"),
  require("../../assets/gallery/20.jpg"),
  require("../../assets/gallery/21.jpg"),
  require("../../assets/gallery/22.jpg"),
  require("../../assets/gallery/23.jpg"),
  require("../../assets/gallery/24.jpg"),
  require("../../assets/gallery/25.jpg"),
  require("../../assets/gallery/26.jpg"),
  require("../../assets/gallery/27.jpg"),
  require("../../assets/gallery/28.jpg"),
  require("../../assets/gallery/29.jpg"),
  require("../../assets/gallery/30.jpg"),
  require("../../assets/gallery/31.jpg"),
  require("../../assets/gallery/32.jpg"),
  require("../../assets/gallery/33.jpg"),
  require("../../assets/gallery/34.jpg"),
  require("../../assets/gallery/35.jpg"),
  require("../../assets/gallery/36.jpg"),
  require("../../assets/gallery/37.jpg"),
  require("../../assets/gallery/38.jpg"),
  require("../../assets/gallery/39.jpg"),
  require("../../assets/gallery/40.jpg"),
  require("../../assets/gallery/41.jpg"),
  require("../../assets/gallery/42.jpg"),
  require("../../assets/gallery/43.jpg"),
  require("../../assets/gallery/44.jpg"),
  require("../../assets/gallery/45.jpg"),
  require("../../assets/gallery/46.jpg"),
  require("../../assets/gallery/47.jpg"),
  require("../../assets/gallery/48.jpg"),
  require("../../assets/gallery/49.jpg"),
  require("../../assets/gallery/50.jpg"),
  require("../../assets/gallery/51.jpg"),
  require("../../assets/gallery/52.jpg"),
  require("../../assets/gallery/53.jpg"),
  require("../../assets/gallery/54.jpg"),
  require("../../assets/gallery/55.jpg"),
  require("../../assets/gallery/56.jpg"),
  require("../../assets/gallery/57.jpg"),
  require("../../assets/gallery/58.jpg"),
  require("../../assets/gallery/59.jpg"),
  require("../../assets/gallery/60.jpg"),
  require("../../assets/gallery/61.jpg"),
  require("../../assets/gallery/62.jpg"),
  require("../../assets/gallery/63.jpg"),
  require("../../assets/gallery/64.jpg"),
  require("../../assets/gallery/65.jpg"),
  require("../../assets/gallery/66.jpg"),
  require("../../assets/gallery/67.jpg"),
  require("../../assets/gallery/68.jpg"),
  require("../../assets/gallery/69.jpg"),
  require("../../assets/gallery/70.jpg"),
  require("../../assets/gallery/71.jpg"),
  require("../../assets/gallery/72.jpg"),
  require("../../assets/gallery/73.jpg"),
  require("../../assets/gallery/74.jpg"),
  require("../../assets/gallery/75.jpg"),
  require("../../assets/gallery/76.jpg"),
  require("../../assets/gallery/77.jpg"),
  require("../../assets/gallery/78.jpg"),
  require("../../assets/gallery/79.jpg"),
  require("../../assets/gallery/80.jpg"),
  require("../../assets/gallery/81.jpg"),
  require("../../assets/gallery/82.jpg"),
  require("../../assets/gallery/83.jpg"),
  require("../../assets/gallery/84.jpg"),
  require("../../assets/gallery/85.jpg"),
  require("../../assets/gallery/86.jpg"),
  require("../../assets/gallery/87.jpg"),
  require("../../assets/gallery/88.jpg"),
  require("../../assets/gallery/89.jpg"),
  require("../../assets/gallery/90.jpg"),
  require("../../assets/gallery/91.jpg"),
  require("../../assets/gallery/92.jpg"),
  require("../../assets/gallery/93.jpg"),
  require("../../assets/gallery/94.jpg"),
  require("../../assets/gallery/95.jpg"),
  require("../../assets/gallery/96.jpg"),
  require("../../assets/gallery/97.jpg"),
  require("../../assets/gallery/98.jpg"),
  require("../../assets/gallery/99.jpg"),
  require("../../assets/gallery/100.jpg"),
  require("../../assets/gallery/101.jpg"),
  require("../../assets/gallery/102.jpg"),
  require("../../assets/gallery/103.jpg"),
  require("../../assets/gallery/104.jpg"),
  require("../../assets/gallery/105.jpg"),
  require("../../assets/gallery/106.jpg"),
  require("../../assets/gallery/107.jpg"),
  require("../../assets/gallery/108.jpg"),
  require("../../assets/gallery/109.jpg"),
  require("../../assets/gallery/110.jpg"),
  require("../../assets/gallery/111.jpg"),
  require("../../assets/gallery/112.jpg"),
  require("../../assets/gallery/113.jpg"),
  require("../../assets/gallery/114.jpg"),
  require("../../assets/gallery/115.jpg"),
  require("../../assets/gallery/116.jpg"),
  require("../../assets/gallery/117.jpg"),
  require("../../assets/gallery/118.jpg"),
  require("../../assets/gallery/119.jpg"),
  require("../../assets/gallery/120.jpg"),
  require("../../assets/gallery/121.jpg"),
  require("../../assets/gallery/122.jpg"),
  require("../../assets/gallery/123.jpg"),
  require("../../assets/gallery/124.jpg"),
  require("../../assets/gallery/125.jpg"),
  require("../../assets/gallery/126.jpg"),
  require("../../assets/gallery/127.jpg"),
  require("../../assets/gallery/128.jpg"),
  require("../../assets/gallery/129.jpg"),
  require("../../assets/gallery/130.jpg"),
  require("../../assets/gallery/131.jpg"),
  require("../../assets/gallery/132.jpg"),
];

// 生成数据
const makeData = (n: number) => {
  return new Array(n).fill("").map(() => {
    let exampleImageUri;
    if (Platform.OS === "web") {
      exampleImageUri = imagesArr[~~(Math.random() * 132)];
    } else {
      exampleImageUri = Image.resolveAssetSource(
        imagesArr[~~(Math.random() * 132)]
      ).uri;
    }

    return {
      url: "",
      image: exampleImageUri,
    };
  });
};

// 盒子高度
const HEIGHT = (cssConfig.boxGap + cssConfig.boxSize) * 2;

// 模拟数据生成
const list = new Array(100).fill(0).map((item, index) => {
  return {
    id: index,
    type: 1 + ~~(Math.random() * 4),
    data: makeData(6),
    offset: index * HEIGHT,
  };
});

type Props = {};
const index = (props: Props) => {
  const styles = useStyles(setTheme);

  // 记录滚动的位置
  const [scrollPosition, setScrollPosition] = useState(0);

  // 滚动方向
  const [direction, setDirection] = useState<"UP" | "DOWN">("UP");

  // 滚动状态（手工滚动、自动滚动、自动滚动完成）
  const [scrollState, setScrollState] = useState<
    "handleScroll" | "autoScroll" | "scrollEnd"
  >("scrollEnd");

  const beginScroll = useRef(0);
  const handleScroll = (event: any) => {
    const position = event.nativeEvent.contentOffset.y;
    // 兼容web
    if (position - scrollPosition === 0) return;

    setScrollPosition(position);

    if (beginScroll.current === 0) {
      beginScroll.current = new Date().getTime();
      setScrollState("handleScroll");
      console.log("手工滚动开始");
    }

    // 方向计算
    if (position - scrollPosition > 0) {
      setDirection("UP");
    } else {
      setDirection("DOWN");
    }
  };

  const photoModal = useRef(null);

  const [scrollEnabled, setScrollEnabled] = useState(true);
  const childSetScrollEnabled = (b: boolean) => {
    setScrollEnabled(b);
  };

  const [longTapPosition, setLongTapPosition] = useState({ x: 0, y: 0 });
  const [tapPosition, setTapPosition] = useState({ x: 0, y: 0 });

  const onScrollEnd = debounce(() => {
    console.log("自动滚动结束");
    // 动画完了释放
    setScrollState("scrollEnd");
    // 重置
    beginScroll.current = 0;
  }, 30);

  // 长按
  const longTap = Gesture.Pan()
    .activateAfterLongPress(120)
    .runOnJS(true)
    .onStart((e) => {
      setLongTapPosition({
        x: e.x,
        y: e.y,
      });
    })
    .onUpdate((e) => {
      // setLongTapPosition({
      //   x: e.x,
      //   y: e.y,
      // });
    })
    .onEnd((e) => {
      setLongTapPosition({
        x: 0,
        y: 0,
      });
      photoModal.current && photoModal.current.display(false);
    });

  // 点击
  const singleTap = Gesture.Tap()
    .maxDuration(250)
    .runOnJS(true)
    .onStart((e) => {
      setTapPosition({
        x: e.x,
        y: e.y,
      });
    })
    .onEnd((e) => {
      setTapPosition({
        x: 0,
        y: 0,
      });
    });

  return (
    <>
      <View style={styles.container}>
        <View style={styles.ljn_main}>
          <GestureDetector gesture={Gesture.Simultaneous(singleTap, longTap)}>
            <VirtualizedList
              horizontal={false}
              data={list}
              renderItem={({ item, index }) => {
                if (item.type == 1) {
                  return (
                    <LJNGalleryStyle1
                      key={index}
                      scrollState={scrollState}
                      index={index}
                      offset={item.offset}
                      gallery={item.data}
                      scrollPosition={scrollPosition}
                      direction={direction}
                      longTapPosition={longTapPosition}
                      tapPosition={tapPosition}
                      longTap={(item: any) => {
                        console.log("ttttttttttttttt");
                        photoModal.current.display(true, item);
                      }}
                    />
                  );
                } else if (item.type == 2) {
                  return (
                    <LJNGalleryStyle2
                      key={index}
                      scrollState={scrollState}
                      index={index}
                      offset={item.offset}
                      gallery={item.data.slice(1)}
                      scrollPosition={scrollPosition}
                      direction={direction}
                      longTapPosition={longTapPosition}
                      tapPosition={tapPosition}
                      longTap={(item: any) => {
                        console.log("ttttttttttttttt");
                        photoModal.current.display(true, item);
                      }}
                    />
                  );
                } else if (item.type == 3) {
                  return (
                    <LJNGalleryStyle3
                      key={index}
                      scrollState={scrollState}
                      index={index}
                      offset={item.offset}
                      gallery={item.data.slice(1)}
                      scrollPosition={scrollPosition}
                      direction={direction}
                      longTapPosition={longTapPosition}
                      tapPosition={tapPosition}
                      longTap={(item: any) => {
                        console.log("ttttttttttttttt");
                        photoModal.current.display(true, item);
                      }}
                    />
                  );
                } else if (item.type == 4) {
                  return (
                    <LJNGalleryStyle4
                      key={index}
                      scrollState={scrollState}
                      index={index}
                      offset={item.offset}
                      gallery={item.data.slice(1)}
                      scrollPosition={scrollPosition}
                      direction={direction}
                      longTapPosition={longTapPosition}
                      tapPosition={tapPosition}
                      longTap={(item: any) => {
                        console.log("ttttttttttttttt");
                        photoModal.current.display(true, item);
                      }}
                    />
                  );
                }
              }}
              keyExtractor={(item: any) => item.id}
              getItemCount={(data) => data.length}
              getItem={(data, index) => data[index]}
              getItemLayout={(data: any, index: number) => {
                return { length: HEIGHT, offset: HEIGHT * index, index: index };
              }}
              initialNumToRender={5} // 首批渲染的元素数量
              windowSize={5} // 渲染区域高度
              maxToRenderPerBatch={20} // 增量渲染最大数量
              scrollEnabled={scrollEnabled}
              scrollEventThrottle={16}
              // debug
              onScrollEndDrag={(e) => {
                console.log("自动滚动开始");
                setScrollState("autoScroll");
              }}
              onMomentumScrollEnd={onScrollEnd}
              onScroll={handleScroll}
              onTouchEnd={() => {
                if (Platform.OS === "web") {
                  console.log("web自动滚动开始");
                  setScrollState("autoScroll");
                  setTimeout(() => {
                    onScrollEnd();
                  }, 2000);
                }
              }}
            />
          </GestureDetector>

          <LJNModal ref={photoModal} />
        </View>

        {/* 底部 */}
        <View style={styles.ljn_footer}>
          <LJNTabbar />
        </View>
      </View>
    </>
  );
};

export default index;
