import {StyleSheet, View, Text, Image} from 'react-native';
import React, {useEffect, useRef, useState} from 'react';
import {px2vw} from '../../../../utils/utils';
import {theme} from '../../../../themes/default/styles';
import Swiper from '../../../../library/react-native-web-swiper/src/index';
import LJNHeaderScroll from './Components/LJNHeaderScroll';

type Props = {setScrollEnabled: (v: boolean) => void};

let timer: any;

interface ISwiperSliceProps {
  index?: number;
  activeIndex?: number;
  list: IListItem[];
}

const SwiperSlice = (props: ISwiperSliceProps) => {
  return (
    <View style={styles.ljn_list}>
      {/* 列表标题 */}
      <View style={styles.ljn_list_title_area}>
        <View style={styles.ljn_list_title1}>
          <Text style={styles.ljn_list_title_inner}>名称</Text>
        </View>
        <View style={styles.ljn_list_title2}>
          <Text style={styles.ljn_list_title_inner}>最新价格</Text>
        </View>
        <View style={styles.ljn_list_title3}>
          <Text style={styles.ljn_list_title_inner}>涨跌幅</Text>
        </View>
      </View>

      {/* 列表 */}
      <View style={styles.ljn_list_inner}>
        {props.list
          ? props.list.map((item, index) => {
              return (
                <View style={styles.ljn_list_item} key={index}>
                  <View style={styles.ljn_list_item_column1}>
                    <Image
                      style={styles.ljn_list_item_icon}
                      source={item.icon}
                    />
                    {item.name}
                  </View>
                  <View style={styles.ljn_list_item_column2}>
                    <Text style={styles.ljn_list_item_column2_text}>
                      {item.price}
                    </Text>
                  </View>
                  <View style={styles.ljn_list_item_column3}>
                    {item.float.indexOf('-') === 0 ? (
                      <View style={styles.ljn_list_item_float_btn_down}>
                        <Text style={styles.ljn_list_item_float_btn_text}>
                          {item.float}
                        </Text>
                      </View>
                    ) : (
                      <View style={styles.ljn_list_item_float_btn_up}>
                        <Text style={styles.ljn_list_item_float_btn_text}>
                          {item.float}
                        </Text>
                      </View>
                    )}
                  </View>
                </View>
              );
            })
          : null}
      </View>

      {/* 查看更多 */}
      <View style={styles.ljn_showmore}>
        <Text style={styles.ljn_showmore_text}>查看更多</Text>
        <Image
          style={styles.ljn_showmore_icon}
          source={require('../../../../assets/images/arrow_right.png')}
        />
      </View>
    </View>
  );
};

const index = (props: Props) => {
  // 当前点击的tab
  const [activeIndex, setActiveIndex] = useState(0);
  const [list, setList] = useState(initData2);

  // 选中
  const changeIndex = (index: number) => {
    // 设置当前激活的tab
    setActiveIndex(index);
  };

  useEffect(() => {
    setInterval(() => {
      let newList = list.map(titem => {
        let nlist = titem.list.map(item => {
          item.price =
            Math.round(
              (Math.trunc(Math.random() * 1000) +
                Math.trunc(Math.random() * 10000) / 10000) *
                10000,
            ) / 10000;
          let float: number = Math.random() * 100;
          let sign = Math.random() > 0.5;
          if (sign) {
            item.float = '-' + float.toFixed(2) + '%';
          } else {
            item.float = '+' + float.toFixed(2) + '%';
          }
          return item;
        });

        titem.list = [...nlist];
        return titem;
      });
      // setList([...newList]);
      setList(JSON.parse(JSON.stringify(newList)));
    }, 1000);
  }, []);

  // useEffect(() => {
  //   console.log(list[0].list[0].float);
  // }, [list]);

  const onHeaderScrollChange = (index: number) => {
    // 改变tabs的位置
    changeIndex(index);
    // 切换swiper位置
    myswiper.current.goTo(index);
  };

  // 列表滑动
  let myswiper = useRef<any>(null);
  const _swiperPan = {
    onPanResponderGrant: () => {
      props.setScrollEnabled(false);
      console.log('onPanResponderGrant');
    },
    onPanResponderMove: () => {
      props.setScrollEnabled(false);
      console.log('onPanResponderMove');
    },
    onPanResponderRelease: () => {
      console.log('onPanResponderRelease');

      if (timer) {
        console.log('清理时钟');
        clearTimeout(timer);
      }
      timer = setTimeout(() => {
        console.log('释放了');
        props.setScrollEnabled(true);
      }, 500);
    },
    // onAnimationEnd: () => {
    //   console.log("动画播放完成释放");
    //   props.setScrollEnabled(true);
    // },
    // onPanResponderTerminationRequest: () => false,
    onPanResponderTerminate: () => {
      console.log('onPanResponderTerminate');
      if (timer) {
        console.log('清理时钟');
        clearTimeout(timer);
      }

      timer = setTimeout(() => {
        console.log('释放了');
        props.setScrollEnabled(true);
      }, 500);
    },
  };

  return (
    <View style={styles.ljn_container}>
      {/* tabs */}
      <LJNHeaderScroll
        tabs={list.map(item => item.tabname)}
        activeIndex={activeIndex}
        onChange={onHeaderScrollChange}
      />

      {/* 列表区域 可以左右滑动 */}
      <View style={styles.ljn_list_area}>
        <Swiper
          ref={myswiper}
          loop={false}
          vertical={false}
          minDistanceToCapture={15}
          // minDistanceForAction={0}
          onIndexChanged={(e: number) => changeIndex(e)}
          controlsEnabled={false}
          // springConfig={{
          //   overshootClamping: false,
          //   speed: 12,
          //   bounciness: 0,
          // friction: 30,
          // }}
          controlsProps={{
            prevPos: false,
            nextPos: false,
          }}
          {..._swiperPan}>
          {list.map((item1, index1) => {
            return <SwiperSlice key={index1} list={item1.list} />;
          })}
        </Swiper>
      </View>
    </View>
  );
};

export default index;

const styles = StyleSheet.create({
  ljn_container: {
    height: px2vw(570),
    backgroundColor: theme.areaBackgroundColor,
    borderRadius: px2vw(10),
    marginBottom: px2vw(10),
    display: 'flex',
    flexDirection: 'column',
  },

  // ----------------------------------列表 start
  ljn_list_area: {
    display: 'flex',
    flex: 1,
    // backgroundColor: "blue",
  },

  // -------------------- 标题 start
  ljn_list_title_area: {
    display: 'flex',
    flexDirection: 'row',
    marginBottom: px2vw(5),
    minHeight: px2vw(30),
    marginTop: px2vw(5),
    // backgroundColor: "blue",
    flex: 0,
  },
  ljn_list_title1: {
    flex: 1.5,
    display: 'flex',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'flex-start',
  },
  ljn_list_title2: {
    flex: 1,
    display: 'flex',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
  },
  ljn_list_title3: {
    flex: 1,
    display: 'flex',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'flex-end',
  },
  ljn_list_title_inner: {
    fontSize: px2vw(14),
    color: '#707589',
  },
  // -------------------- 标题 end

  ljn_list: {
    display: 'flex',
    flex: 1,
    flexDirection: 'column',
    paddingLeft: px2vw(12),
    paddingRight: px2vw(12),
    // backgroundColor: "red",
  },
  ljn_list_inner: {
    flex: 1,
  },

  ljn_list_item: {
    display: 'flex',
    flexDirection: 'row',
    height: px2vw(30),
    marginBottom: px2vw(15),
    backgroundColor: '#18202d',
  },
  ljn_list_item_column1: {
    flex: 1.5,
    display: 'flex',
    flexDirection: 'row',
    justifyContent: 'flex-start',
    alignItems: 'center',
  },
  ljn_list_item_column2: {
    flex: 1,
    display: 'flex',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'flex-end',
    paddingRight: px2vw(32),
  },
  ljn_list_item_column2_text: {
    color: 'white',
    fontSize: px2vw(14),
  },
  ljn_list_item_column3: {
    flex: 1,
    display: 'flex',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'flex-end',
    // backgroundColor: "yellow",
  },
  ljn_list_item_icon: {
    width: px2vw(25),
    height: px2vw(25),
  },
  ljn_list_item_name: {
    display: 'flex',
    flexDirection: 'row',
    alignItems: 'center',
    marginLeft: px2vw(6),
  },
  ljn_list_item_name1: {
    color: 'white',
    fontSize: px2vw(14),
    fontWeight: '600',
  },
  ljn_list_item_name2: {
    color: '#434b58',
    fontSize: px2vw(12),
    marginLeft: px2vw(3),
  },
  ljn_list_item_name3: {
    color: '#434b58',
    fontSize: px2vw(10),
  },
  ljn_list_item_float_btn_up: {
    height: px2vw(30),
    width: px2vw(70),
    backgroundColor: '#11b394',
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: px2vw(4),
  },
  ljn_list_item_float_btn_down: {
    height: px2vw(30),
    width: px2vw(70),
    backgroundColor: '#dc291b',
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: px2vw(4),
  },
  ljn_list_item_float_btn_text: {
    color: 'white',
  },
  // ---------------------------------- 列表end

  ljn_showmore: {
    flex: 1,
    maxHeight: px2vw(50),
    display: 'flex',
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    // backgroundColor: "red",
  },
  ljn_showmore_text: {
    color: '#707589',
    fontSize: px2vw(12),
  },
  ljn_showmore_icon: {
    marginLeft: px2vw(5),
    width: px2vw(15),
    height: px2vw(15),
  },
});

interface IListItem {
  key: string;
  icon: any;
  name: JSX.Element;
  price: number;
  float: string;
}

interface IList {
  tabname: string;
  list: IListItem[];
}

const initData = [
  {
    key: '1',
    icon: require('../../../../assets/images/nav1icon.png'),
    name: (
      <View style={styles.ljn_list_item_name}>
        <Text style={styles.ljn_list_item_name1}>HT</Text>
        <Text style={styles.ljn_list_item_name2}>/</Text>
        <Text style={styles.ljn_list_item_name3}>USDT</Text>
      </View>
    ),
    price: 5.3251,
    float: '+0.91%',
  },
  {
    key: '2',
    icon: require('../../../../assets/images/nav1icon.png'),
    name: (
      <View style={styles.ljn_list_item_name}>
        <Text style={styles.ljn_list_item_name1}>TRX</Text>
        <Text style={styles.ljn_list_item_name2}>/</Text>
        <Text style={styles.ljn_list_item_name3}>USDT</Text>
      </View>
    ),
    price: 0.055375,
    float: '+0.04%',
  },
  {
    key: '3',
    icon: require('../../../../assets/images/nav1icon.png'),
    name: (
      <View style={styles.ljn_list_item_name}>
        <Text style={styles.ljn_list_item_name1}>PI</Text>
        <Text style={styles.ljn_list_item_name2}>/</Text>
        <Text style={styles.ljn_list_item_name3}>USDT</Text>
      </View>
    ),
    price: 79.498777,
    float: '-20.89%',
  },
  {
    key: '4',
    icon: require('../../../../assets/images/nav1icon.png'),
    name: (
      <View style={styles.ljn_list_item_name}>
        <Text style={styles.ljn_list_item_name1}>FIL</Text>
        <Text style={styles.ljn_list_item_name2}>/</Text>
        <Text style={styles.ljn_list_item_name3}>USDT</Text>
      </View>
    ),
    price: 3.2908,
    float: '+4.92%',
  },
  {
    key: '5',
    icon: require('../../../../assets/images/nav1icon.png'),
    name: (
      <View style={styles.ljn_list_item_name}>
        <Text style={styles.ljn_list_item_name1}>ETH</Text>
        <Text style={styles.ljn_list_item_name2}>/</Text>
        <Text style={styles.ljn_list_item_name3}>USDT</Text>
      </View>
    ),
    price: 1248.23,
    float: '+3.00%',
  },
  {
    key: '6',
    icon: require('../../../../assets/images/nav1icon.png'),
    name: (
      <View style={styles.ljn_list_item_name}>
        <Text style={styles.ljn_list_item_name1}>SOL</Text>
        <Text style={styles.ljn_list_item_name2}>/</Text>
        <Text style={styles.ljn_list_item_name3}>USDT</Text>
      </View>
    ),
    price: 13.7589,
    float: '+5.20%',
  },
  {
    key: '7',
    icon: require('../../../../assets/images/nav1icon.png'),
    name: (
      <View style={styles.ljn_list_item_name}>
        <Text style={styles.ljn_list_item_name1}>BTC</Text>
        <Text style={styles.ljn_list_item_name2}>/</Text>
        <Text style={styles.ljn_list_item_name3}>USDT</Text>
      </View>
    ),
    price: 16854.3,
    float: '+1.06%',
  },
  {
    key: '8',
    icon: require('../../../../assets/images/nav1icon.png'),
    name: (
      <View style={styles.ljn_list_item_name}>
        <Text style={styles.ljn_list_item_name1}>ETC</Text>
        <Text style={styles.ljn_list_item_name2}>/</Text>
        <Text style={styles.ljn_list_item_name3}>USDT</Text>
      </View>
    ),
    price: 17.619,
    float: '+10.70%',
  },
  {
    key: '9',
    icon: require('../../../../assets/images/nav1icon.png'),
    name: (
      <View style={styles.ljn_list_item_name}>
        <Text style={styles.ljn_list_item_name1}>LTC</Text>
        <Text style={styles.ljn_list_item_name2}>/</Text>
        <Text style={styles.ljn_list_item_name3}>USDT</Text>
      </View>
    ),
    price: 76.62,
    float: '+2.62%',
  },
  {
    key: '10',
    icon: require('../../../../assets/images/nav1icon.png'),
    name: (
      <View style={styles.ljn_list_item_name}>
        <Text style={styles.ljn_list_item_name1}>OP</Text>
        <Text style={styles.ljn_list_item_name2}>/</Text>
        <Text style={styles.ljn_list_item_name3}>USDT</Text>
      </View>
    ),
    price: 1.0177,
    float: '+4.60%',
  },
];

const initData2: Array<IList> = [
  {tabname: '自选', list: initData},
  {tabname: '热榜', list: initData},
  {tabname: '涨幅榜', list: initData},
  {tabname: '新币榜', list: initData},
  // { tabname: "成交额榜", list: initData },
  // { tabname: "跌幅榜", list: initData },
  // { tabname: "自选", list: initData },
  // { tabname: "热榜", list: initData },
  // { tabname: "涨幅榜", list: initData },
  // { tabname: "新币榜", list: initData },
  // { tabname: "成交额榜", list: initData },
  // { tabname: "跌幅榜", list: initData },
];
