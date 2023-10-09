import LJNFuncList from "components/LJNFuncList";
import LJNScrollView from "components/LJNScrollView";
import { useAppDispatch, useAppSelector, useStyles } from "hooks";
import React from "react";
import { View } from "react-native";
import { selectAppTheme, setAppTheme } from "store/SystemSlice";
import LJNActivation1 from "./Components/LJNActivation1";
import LJNUserInfo from "./Components/LJNUserInfo";
import context from "./context";
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

          {/* 其他信息 */}
          <View style={styles.ljn_activation_area}>
            <LJNActivation1
              title={"新手任务"}
              onClick={() => {
                navigation.navigate("login", "login");
              }}
              buttonText={"去完成"}
            />
            <LJNActivation1
              title={"切换主题"}
              onClick={() => {
                // console.log(theme);
                dispatch(setAppTheme(theme === "dark" ? "light" : "dark"));
              }}
              buttonText={"切换"}
            />
          </View>

          {/* 功能列表 */}
          <LJNFuncList
            list={[
              {
                avatar: require("assets/images/func1.png"),
                name: "服务",
              },
            ]}
          />

          <LJNFuncList
            list={[
              {
                avatar: require("assets/images/func2.png"),
                name: "收藏",
              },
              {
                avatar: require("assets/images/func3.png"),
                name: "朋友圈",
              },
              {
                avatar: require("assets/images/func4.png"),
                name: "视频号",
              },
              {
                avatar: require("assets/images/func5.png"),
                name: "卡包",
              },
              {
                avatar: require("assets/images/func6.png"),
                name: "表情",
              },
            ]}
          />

          <LJNFuncList
            list={[
              {
                avatar: require("assets/images/func7.png"),
                name: "设置",
              },
            ]}
          />
        </Provider>
      }
    />
  );
}
