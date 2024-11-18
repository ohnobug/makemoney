import LJNScrollView from "components/LJNScrollView";
import { useAppDispatch, useAppSelector, useStyles } from "hooks";
import React from "react";
import { selectAppTheme } from "store/SystemSlice";
import context from "context";
import { setTheme } from "./styles";
import { Text, View } from "react-native";
import { px2vw } from "utils/utils";
import LJNHeader from "components/LJNHeader";
import LJNIcon from "components/LJNIcon";
import LJNFunctions from "./Components/LJNFunctions";
import darkTheme from "themes/default/styles";
import lightTheme from "themes/light/styles";

const { Provider } = context;
type Props = any;
export default ({ navigation }: Props) => {
  const styles = useStyles(setTheme);
  const theme = useAppSelector(selectAppTheme);
  const dispatch = useAppDispatch();

  return (
    <>
      <LJNHeader
        onBack={() => {
          navigation.goBack();
        }}
        onMore={() => {}}
        title={"服务"}
      ></LJNHeader>

      <LJNScrollView
        style={styles.ljn_main}
        horizontal={false}
        children={
          <Provider
            value={{
              navigate: navigation.navigate,
            }}
          >
            <View
              style={{
                height: px2vw(138),
                backgroundColor: "#2bae6a",
                borderRadius: px2vw(6),
                marginLeft: px2vw(8),
                marginRight: px2vw(8),
                marginBottom: px2vw(8),
                display: "flex",
                flexDirection: "row",
              }}
            >
              <View
                style={{
                  flex: 1,
                  display: "flex",
                  justifyContent: "flex-start",
                  alignItems: "center",
                }}
              >
                <View
                  style={{
                    marginBottom: px2vw(8),
                    marginTop: px2vw(30),
                  }}
                >
                  <LJNIcon title={"shoufukuan"} size={32} color="#fff" />
                </View>
                <Text
                  style={{
                    color: "white",
                    fontSize: px2vw(16),
                    // fontFamily: "思源黑体",
                  }}
                >
                  收付款
                </Text>
              </View>
              <View
                style={{
                  flex: 1,
                  display: "flex",
                  justifyContent: "flex-start",
                  alignItems: "center",
                }}
              >
                <View
                  style={{
                    marginBottom: px2vw(8),
                    marginTop: px2vw(30),
                  }}
                >
                  <LJNIcon title={"qianbao"} size={32} color="#fff" />
                </View>
                <Text
                  style={{
                    color: "white",
                    fontSize: px2vw(16),
                    marginBottom: px2vw(2),
                    // fontFamily: "思源黑体",
                  }}
                >
                  钱包
                </Text>

                <View
                  style={{
                    display: "flex",
                    flexDirection: "row",
                    alignItems: "center",
                    justifyContent: "center",
                  }}
                >
                  <LJNIcon
                    title={"rmb"}
                    size={14}
                    color={
                      theme === "dark"
                        ? darkTheme.blanceTextColor
                        : lightTheme.blanceTextColor
                    }
                  />

                  <Text
                    style={{
                      fontSize: px2vw(14),
                      color:
                        theme === "dark"
                          ? darkTheme.blanceTextColor
                          : lightTheme.blanceTextColor,
                    }}
                  >
                    99999999.00
                  </Text>
                </View>
              </View>
            </View>

            <LJNFunctions
              title="金融理财"
              olist={[
                {
                  icon: require("assets/images/nav1icon.png"),
                  title: "信用卡还款",
                  screen: "home",
                  path: "index",
                },
                {
                  icon: require("assets/images/nav2icon.png"),
                  title: "微粒贷借钱",
                  screen: "home",
                  path: "index",
                },
                {
                  icon: require("assets/images/nav3icon.png"),
                  title: "理财通",
                  screen: "home",
                  path: "index",
                },
                {
                  icon: require("assets/images/nav4icon.png"),
                  title: "保险服务",
                  screen: "home",
                  path: "index",
                },
              ]}
            />

            <LJNFunctions
              title="生活服务"
              olist={[
                {
                  icon: require("assets/images/nav1icon.png"),
                  title: "手机充值",
                  screen: "home",
                  path: "index",
                },
                {
                  icon: require("assets/images/nav2icon.png"),
                  title: "生活缴费",
                  screen: "home",
                  path: "index",
                },
                {
                  icon: require("assets/images/nav3icon.png"),
                  title: "Q币充值",
                  screen: "home",
                  path: "index",
                },
                {
                  icon: require("assets/images/nav4icon.png"),
                  title: "城市服务",
                  screen: "home",
                  path: "index",
                },
                {
                  icon: require("assets/images/nav3icon.png"),
                  title: "腾讯公益",
                  screen: "home",
                  path: "index",
                },
                {
                  icon: require("assets/images/nav4icon.png"),
                  title: "医疗健康",
                  screen: "home",
                  path: "index",
                },
              ]}
            />

            <LJNFunctions
              title="交通出行"
              olist={[
                {
                  icon: require("assets/images/nav1icon.png"),
                  title: "出行服务",
                  screen: "home",
                  path: "index",
                },
                {
                  icon: require("assets/images/nav2icon.png"),
                  title: "火车票机票",
                  screen: "home",
                  path: "index",
                },
                {
                  icon: require("assets/images/nav3icon.png"),
                  title: "滴滴出行",
                  screen: "home",
                  path: "index",
                },
                {
                  icon: require("assets/images/nav4icon.png"),
                  title: "酒店",
                  screen: "home",
                  path: "index",
                },
              ]}
            />

            <LJNFunctions
              title="购物消费"
              olist={[
                {
                  icon: require("assets/images/nav1icon.png"),
                  title: "品牌发现",
                  screen: "home",
                  path: "index",
                },
                {
                  icon: require("assets/images/nav2icon.png"),
                  title: "京东购物",
                  screen: "home",
                  path: "index",
                },
                {
                  icon: require("assets/images/nav3icon.png"),
                  title: "美团外卖",
                  screen: "home",
                  path: "index",
                },
                {
                  icon: require("assets/images/nav4icon.png"),
                  title: "电影演出玩乐",
                  screen: "home",
                  path: "index",
                },

                {
                  icon: require("assets/images/nav1icon.png"),
                  title: "美团特价",
                  screen: "home",
                  path: "index",
                },
                {
                  icon: require("assets/images/nav2icon.png"),
                  title: "拼多多",
                  screen: "home",
                  path: "index",
                },
                {
                  icon: require("assets/images/nav3icon.png"),
                  title: "唯品会特卖",
                  screen: "home",
                  path: "index",
                },
                {
                  icon: require("assets/images/nav4icon.png"),
                  title: "转转二手",
                  screen: "home",
                  path: "index",
                },
              ]}
            />
          </Provider>
        }
      />
    </>
  );
};
