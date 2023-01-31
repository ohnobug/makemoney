import React, { useEffect, useRef, useState } from "react";
import {
  View,
  ScrollView,
  Text,
  StyleSheet,
  TextInput,
  Platform,
} from "react-native";
import LJNTabbar from "../../components/LJNTabbar";
import LJNIcon from "../../components/LJNIcon";
import { useAppSelector } from "../../hooks";
import { selectTheme } from "../../store/SystemSlice";
import { setTheme } from "./styles";
import LJNButton from "../../components/LJNButton";
import LJNScrollView from "../../components/LJNScrollView";
import { px2vw } from "../../utils/utils";
import LJNHeaderScroll from "../../components/LJNHeaderScroll";
import LJNEmptyBlock from "../../components/LJNEmptyBlock";

type Props = {};

export default function index({}: Props) {
  const theme = useAppSelector(selectTheme);
  const [styles, setStyles] = useState<any>(setTheme(theme));
  useEffect(() => {
    setStyles(setTheme(theme));
  }, [theme]);

  let bigScrollView = useRef<ScrollView>(null);

  // 输入框
  const [text, setText] = useState("");

  // 顶部滑动
  let myswiperHeader = useRef<any>(null);

  // 上一次的价格
  let prevPrice = useRef<number>(0).current;
  // 是否上涨
  const [isUp, setIsUp] = useState<boolean>(false);
  const [list1, setList1] = useState([
    { price: 22886.49, amount: 0.0406, percentage: "30%" },
    { price: 22886.49, amount: 0.0406, percentage: "30%" },
    { price: 22886.49, amount: 0.0406, percentage: "30%" },
    { price: 22886.49, amount: 0.0406, percentage: "30%" },
    { price: 22886.49, amount: 0.0406, percentage: "30%" },
    { price: 22886.49, amount: 0.0406, percentage: "30%" },
    { price: 22886.49, amount: 0.0406, percentage: "30%" },
    { price: 22886.49, amount: 0.0406, percentage: "30%" },
    { price: 22886.49, amount: 0.0406, percentage: "30%" },
    { price: 22886.49, amount: 0.0406, percentage: "30%" },
  ]);

  useEffect(() => {
    let timer = setInterval(() => {
      setList1((l: any) => {
        let nl = l.map((item: any) => {
          return {
            price: (Math.round(Math.random() * 10000 * 100) / 100).toFixed(2),
            amount: Math.random().toFixed(4),
            percentage: Math.random() * 100 + "%",
          };
        });
        nl.sort((a: any, b: any) => {
          return b.price - a.price;
        });

        if (prevPrice > nl[5].price) {
          setIsUp(false);
        } else {
          setIsUp(true);
        }
        prevPrice = nl[5].price;
        return nl;
      });
    }, 300);

    return () => {
      clearInterval(timer);
    };
  }, []);

  return (
    <View style={styles.container}>
      <LJNScrollView
        style={styles.ljn_main}
        horizontal={false}
        ref={bigScrollView}
        children={
          <>
            {/* 资产区域 */}
            <View style={styles.container}>
              {/* 切换模式 */}
              <View style={styles.ljn_header}>
                <View style={styles.ljn_header_left}>
                  <View style={styles.ljn_header_left_1}>
                    <Text
                      style={StyleSheet.flatten([
                        styles.ljn_header_left_1_text,
                        styles.ljn_header_left_1_text_active,
                      ])}
                    >
                      现货
                    </Text>
                  </View>
                  <View style={styles.ljn_header_left_1}>
                    <Text style={styles.ljn_header_left_1_text}>杠杠</Text>
                  </View>
                  <View style={styles.ljn_header_left_1}>
                    <Text style={styles.ljn_header_left_1_text}>法币</Text>
                  </View>
                </View>
              </View>

              {/* 买卖操作 */}
              <View style={styles.ljn_trade_operation}>
                <View style={styles.ljn_trade_operation_left}>
                  {/* 币种 */}
                  <View style={styles.ljn_trade_operation_left_title_area}>
                    <View
                      style={styles.ljn_trade_operation_left_title_area_icon}
                    >
                      <LJNIcon title={"xinxi"} size={18} />
                    </View>
                    <Text
                      style={styles.ljn_trade_operation_left_title_area_text1}
                    >
                      BTC/USDT
                    </Text>
                    <Text
                      style={styles.ljn_trade_operation_left_title_area_text2}
                    >
                      -1.24%
                    </Text>
                  </View>

                  {/* 买入卖出按钮组 */}
                  <View style={styles.ljn_trade_operation_buysell_buttons}>
                    <View style={styles.ljn_trade_operation_buysell_buy}>
                      <Text style={styles.ljn_trade_operation_buysell_buy_text}>
                        买入
                      </Text>
                    </View>
                    <View style={styles.ljn_trade_operation_buysell_sell}>
                      <Text
                        style={styles.ljn_trade_operation_buysell_sell_text}
                      >
                        卖出
                      </Text>
                    </View>
                  </View>

                  {/* 限价委托 */}
                  <TextInput
                    editable
                    multiline={false}
                    maxLength={40}
                    onChangeText={(val: string) => {
                      setText(val);
                    }}
                    value={text}
                    placeholder="限价委托"
                    style={StyleSheet.flatten([
                      styles.ljn_trade_operation_input,
                      Platform.OS === "web"
                        ? {
                            outline: "none",
                          }
                        : null,
                    ])}
                  />

                  {/* 22887.55 */}
                  <TextInput
                    editable
                    multiline={false}
                    maxLength={40}
                    onChangeText={(val: string) => {
                      setText(val);
                    }}
                    value={text}
                    placeholder="22887.55"
                    style={StyleSheet.flatten([
                      styles.ljn_trade_operation_input,
                      {
                        marginBottom: px2vw(0),
                      },
                      Platform.OS === "web"
                        ? {
                            outline: "none",
                          }
                        : null,
                    ])}
                  />

                  {/* 约等于 */}
                  <View style={styles.ljn_trade_operation_about_value}>
                    <Text style={styles.ljn_trade_operation_about_value_text}>
                      ≈22887.55 CNY
                    </Text>
                  </View>

                  {/* 数量 */}
                  <TextInput
                    editable
                    multiline={false}
                    maxLength={40}
                    onChangeText={(val: string) => {
                      setText(val);
                    }}
                    value={text}
                    placeholder="数量"
                    style={StyleSheet.flatten([
                      styles.ljn_trade_operation_input,
                      Platform.OS === "web"
                        ? {
                            outline: "none",
                          }
                        : null,
                    ])}
                  />

                  {/* 快速选择 */}
                  <View style={styles.ljn_trade_operation_percentage_selector}>
                    <View
                      style={
                        styles.ljn_trade_operation_percentage_selector_button
                      }
                    >
                      <Text
                        style={
                          styles.ljn_trade_operation_percentage_selector_button_text
                        }
                      >
                        25%
                      </Text>
                    </View>
                    <View
                      style={
                        styles.ljn_trade_operation_percentage_selector_button
                      }
                    >
                      <Text
                        style={
                          styles.ljn_trade_operation_percentage_selector_button_text
                        }
                      >
                        50%
                      </Text>
                    </View>
                    <View
                      style={
                        styles.ljn_trade_operation_percentage_selector_button
                      }
                    >
                      <Text
                        style={
                          styles.ljn_trade_operation_percentage_selector_button_text
                        }
                      >
                        75%
                      </Text>
                    </View>
                    <View
                      style={
                        styles.ljn_trade_operation_percentage_selector_button
                      }
                    >
                      <Text
                        style={
                          styles.ljn_trade_operation_percentage_selector_button_text
                        }
                      >
                        100%
                      </Text>
                    </View>
                  </View>

                  {/* 交易额 */}
                  <TextInput
                    editable
                    multiline={false}
                    maxLength={40}
                    onChangeText={(val: string) => {
                      setText(val);
                    }}
                    value={text}
                    placeholder="交易额"
                    style={StyleSheet.flatten([
                      styles.ljn_trade_operation_input,
                      Platform.OS === "web"
                        ? {
                            outline: "none",
                          }
                        : null,
                    ])}
                  />

                  {/* 可用 */}
                  <View style={styles.ljn_balance_area}>
                    <Text style={styles.ljn_balance_area_title}>可用</Text>
                    <View style={styles.ljn_balance_area_value}>
                      <Text style={styles.ljn_balance_area_value_text1}>
                        --
                      </Text>
                      <Text style={styles.ljn_balance_area_value_text2}>
                        USDT
                      </Text>
                      <LJNIcon title="xinxi" size={12} />
                    </View>
                  </View>

                  <LJNButton title={"登录"} size="middle" />
                </View>

                <View style={styles.ljn_trade_operation_right}>
                  {/* 倍速 */}
                  <View style={styles.ljn_trade_operation_right_title_area}>
                    <View style={styles.ljn_trade_operation_right_title_button}>
                      <Text
                        style={
                          styles.ljn_trade_operation_right_title_button_text
                        }
                      >
                        200X
                      </Text>
                    </View>
                    <LJNIcon title="gupiao" size={25} />
                    <LJNIcon title="gengduo" size={25} />
                  </View>

                  {/* 浮动标题 */}
                  <View
                    style={styles.ljn_trade_operation_right_float_title_area}
                  >
                    <View style={styles.ljn_trade_operation_right_float_title}>
                      <Text
                        style={
                          styles.ljn_trade_operation_right_float_title_text
                        }
                      >
                        价格
                      </Text>
                    </View>
                    <View style={styles.ljn_trade_operation_right_float_title}>
                      <Text
                        style={
                          styles.ljn_trade_operation_right_float_title_text
                        }
                      >
                        数量
                      </Text>
                    </View>
                  </View>

                  {/* 浮动数据 */}
                  {list1.slice(0, 5).map((item, index) => {
                    return (
                      <View
                        key={index}
                        style={styles.ljn_trade_operation_right_float_data_area}
                      >
                        <View
                          style={StyleSheet.flatten([
                            styles.ljn_trade_operation_right_float_data_background,
                            {
                              backgroundColor: "#df5e52",
                              opacity: 0.5,
                              width: item.percentage,
                            },
                          ])}
                        ></View>
                        <View
                          style={styles.ljn_trade_operation_right_float_data}
                        >
                          <Text
                            style={
                              styles.ljn_trade_operation_right_float_data_text1
                            }
                          >
                            {item.price}
                          </Text>
                        </View>
                        <View
                          style={styles.ljn_trade_operation_right_float_data}
                        >
                          <Text
                            style={
                              styles.ljn_trade_operation_right_float_data_text2
                            }
                          >
                            {item.amount}
                          </Text>
                        </View>
                      </View>
                    );
                  })}

                  {/* 当前价格 */}
                  <View style={styles.ljn_trade_operation_current_price}>
                    <Text
                      style={StyleSheet.flatten([
                        styles.ljn_trade_operation_current_price_text1,
                        isUp ? { color: "#139a86" } : { color: "#df5e52" },
                      ])}
                    >
                      {list1[5].price}
                    </Text>
                    <Text
                      style={styles.ljn_trade_operation_current_price_text2}
                    >
                      ≈{(list1[5].price * 7.5).toFixed(2)}CNY
                    </Text>
                  </View>

                  {/* 浮动数据 */}
                  {list1.slice(5, 10).map((item, index) => {
                    return (
                      <View
                        key={index}
                        style={styles.ljn_trade_operation_right_float_data_area}
                      >
                        <View
                          style={StyleSheet.flatten([
                            styles.ljn_trade_operation_right_float_data_background,
                            {
                              backgroundColor: "#139a86",
                              opacity: 0.5,
                              width: item.percentage,
                            },
                          ])}
                        ></View>
                        <View
                          style={styles.ljn_trade_operation_right_float_data}
                        >
                          <Text
                            style={StyleSheet.flatten([
                              styles.ljn_trade_operation_right_float_data_text1,
                              {
                                color: "#139a86",
                              },
                            ])}
                          >
                            {item.price}
                          </Text>
                        </View>
                        <View
                          style={styles.ljn_trade_operation_right_float_data}
                        >
                          <Text
                            style={
                              styles.ljn_trade_operation_right_float_data_text2
                            }
                          >
                            {item.amount}
                          </Text>
                        </View>
                      </View>
                    );
                  })}

                  {/* 调整精度 */}
                  <View style={styles.ljn_trade_operation_accuracy}>
                    <View
                      style={styles.ljn_trade_operation_accuracy_selector_area}
                    >
                      {/* 精度 */}
                      <TextInput
                        editable
                        multiline={false}
                        maxLength={40}
                        onChangeText={(val: string) => {
                          setText(val);
                        }}
                        value={text}
                        placeholder="0.01"
                        style={StyleSheet.flatten([
                          styles.ljn_trade_operation_accuracy_selector,
                          Platform.OS === "web"
                            ? {
                                outline: "none",
                              }
                            : null,
                        ])}
                      />
                    </View>
                    <View style={styles.ljn_trade_operation_accuracy_icon}>
                      <View
                        style={styles.ljn_trade_operation_accuracy_icon_box}
                      >
                        <LJNIcon title={"liebiao"} />
                      </View>
                    </View>
                  </View>
                </View>
              </View>

              {/* tabs */}
              <LJNHeaderScroll
                ref={myswiperHeader}
                list={["资产", "当前委托", "历史成交"]}
                onChange={(n: number) => {}}
              />
              <View
                style={{
                  height: px2vw(500),
                }}
              >
                <LJNEmptyBlock />
              </View>
            </View>
          </>
        }
      />

      <View style={styles.ljn_footer}>
        <LJNTabbar />
      </View>
    </View>
  );
}
