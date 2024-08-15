import LJNFuncList from "components/LJNFuncList";
import LJNScrollView from "components/LJNScrollView";
import { useAppDispatch, useAppSelector, useStyles } from "hooks";
import React from "react";
import { selectAppTheme, setAppTheme } from "store/SystemSlice";
import LJNUserInfo from "./Components/LJNUserInfo";
import context from "../../context";
import { setTheme } from "./styles";

const { Provider } = context;
type Props = any;
export default function SlideUser({ navigation }: Props) {
  const styles = useStyles(setTheme);

  const theme = useAppSelector(selectAppTheme);
  const dispatch = useAppDispatch();

  return (
    <LJNScrollView
      style={styles.ljn_main}
      horizontal={false}
      children={
        <Provider
          value={{
            navigate: navigation.navigate,
          }}
        >
          {/* 用户信息区域 */}
          <LJNUserInfo />

          {/* 功能列表 */}
          <LJNFuncList
            list={[
              {
                avatar: require("assets/images/icon1.png"),
                name: "服务",
                onPress: () => {
                  navigation.navigate("services", "services");
                }
              },
            ]}
          />

          <LJNFuncList
            list={[
              {
                avatar: require("assets/images/icon2.png"),
                name: "收藏",
              },
              {
                avatar: require("assets/images/icon3.png"),
                name: "朋友圈",
              },
              {
                avatar: require("assets/images/icon4.png"),
                name: "视频号",
              },
              {
                avatar: require("assets/images/icon5.png"),
                name: "卡包",
              },
              {
                avatar: require("assets/images/icon6.png"),
                name: "表情",
              },
            ]}
          />

          <LJNFuncList
            list={[
              {
                avatar: require("assets/images/icon7.png"),
                name: "设置",
                onPress: () => {
                  navigation.navigate("setting", "setting");
                }
              },
            ]}
          />
        </Provider>
      }
    />
  );
}
