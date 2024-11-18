import LJNIcon from "components/LJNIcon";
import LJNLoading from "components/LJNLoading";
import { useAppSelector, useStyles } from "hooks";
import React, { useContext, useEffect, useState } from "react";
import { Image, Text, View } from "react-native";
import { setTheme } from "./styles";
import { selectAppTheme } from "store/SystemSlice";
import darkTheme from "themes/default/styles";
import lightTheme from "themes/light/styles";
import { px2vw } from "utils/utils";

type Props = {};

const LJNUserInfo = (props: Props) => {
  const styles = useStyles(setTheme);
  const theme = useAppSelector(selectAppTheme);

  const [list, setList] = useState([
    {
      icon: require("assets/images/nav1icon.png"),
      title: "CNY买币",
      path: "/",
    },
    {
      icon: require("assets/images/nav2icon.png"),
      title: "交易机器人",
      path: "/",
    },
    {
      icon: require("assets/images/nav3icon.png"),
      title: "USDT合约",
      path: "/",
    },
    {
      icon: require("assets/images/nav4icon.png"),
      title: "理财",
      path: "/",
    },
    {
      icon: require("assets/images/nav5icon.png"),
      title: "跟单 ",
      path: "/",
    },
  ]);

  let [show, setShow] = useState(false);
  useEffect(() => {
    let timer = setTimeout(() => {
      setShow(true);
    }, 0);

    return () => {
      clearTimeout(timer);
    };
  }, []);


  return (
    <View style={styles.ljn_header_area}>
      {/* 顶部功能区域 */}
      {show ? (
        <>
          {/* 用户信息 */}
          <View style={styles.ljn_userinfo_area}>
            <View style={styles.ljn_userinfo_avatar_area}>
              <Image
                style={styles.ljn_userinfo_avatar_area_img}
                source={require("assets/images/wu.jpg")}
              />
            </View>

            <View style={styles.ljn_userinfo}>
              <View style={styles.ljn_userinfo_username}>
                <Text style={styles.ljn_userinfo_username_text}>
                  李俊杰
                </Text>
              </View>

              <View style={styles.ljn_userinfo_uid}>
                <View style={styles.ljn_userinfo_uid_area}>
                  <Text style={styles.ljn_userinfo_uid_text}>
                    微信号：TheMonsterClub
                  </Text>
                  <View style={styles.ljn_userinfo_uid_copy_icon}>
                    <LJNIcon title={"erweima"} size={13} color={theme === "dark" ? darkTheme.textColor : lightTheme.textColor} />
                  </View>
                  <View style={styles.ljn_userinfo_uid_copy_icon2}>
                    <LJNIcon title={"jinrujiantouxiao"} size={13} color={theme === "dark" ? darkTheme.textColor : lightTheme.textColor} />
                  </View>
                </View>
              </View>

              <View style={{
                // backgroundColor: "red",
                display: "flex",
                flexDirection: "row"
              }}>

                <View style={{
                  borderWidth: px2vw(1.2),
                  borderRadius: px2vw(12),
                  borderColor: theme === 'dark' ? darkTheme.chatBorderColor : lightTheme.chatBorderColor,
                  height: px2vw(24),
                  // flexBasis: px2vw(57),
                  justifyContent: "center",
                  alignContent: "center",
                  marginRight: px2vw(5),
                  paddingLeft: px2vw(10),
                  paddingRight: px2vw(10),
                }}>
                  <Text style={{
                    textAlign: "center",
                    color: theme === 'dark' ? darkTheme.textColor : lightTheme.textColor,
                  }}>+ 状态</Text>
                </View>


                <View style={{
                  borderWidth: px2vw(1.2),
                  borderRadius: px2vw(12),
                  borderColor: theme === 'dark' ? darkTheme.chatBorderColor : lightTheme.chatBorderColor,
                  height: px2vw(24),
                  // flexBasis: px2vw(57),
                  justifyContent: "center",
                  alignContent: "center",
                  marginRight: px2vw(5),
                  paddingLeft: px2vw(10),
                  paddingRight: px2vw(10),
                }}>
                  <Text style={{
                    textAlign: "center",
                    color: theme === 'dark' ? darkTheme.textColor : lightTheme.textColor,
                  }}>+ 等四个朋友</Text>
                </View>
              </View>
 


            </View>
          </View>
        </>
      ) : (
        <LJNLoading />
      )}
    </View>
  );
};

export default LJNUserInfo;
