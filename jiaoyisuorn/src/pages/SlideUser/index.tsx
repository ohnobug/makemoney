import LJNScrollView from "components/LJNScrollView";
import { useAppDispatch, useAppSelector, useStyles } from "hooks";
import React, { useCallback, useState } from "react";
import { View, Text } from "react-native";
import { selectAppTheme, setAppTheme } from "store/SystemSlice";
import LJNActivation1 from "./Components/LJNActivation1";
import LJNUserInfo from "./Components/LJNUserInfo";
import { setTheme } from "./styles";
import context from "./context";
import { useFocusEffect } from "@react-navigation/native";
const { Provider } = context;

type Props = any;

export default function SlideUser({ navigation }: Props) {
  const styles = useStyles(setTheme);

  const theme = useAppSelector(selectAppTheme);
  const dispatch = useAppDispatch();

  const [itIsFocused, setItIsFocused] = useState(false);
  useFocusEffect(
    useCallback(() => {
      setItIsFocused(true);

      return () => {};
    }, [])
  );

  return (
    <>
      {itIsFocused ? (
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
            </Provider>
          }
        />
      ) : (
        <View>
          <Text>加载中...</Text>
        </View>
      )}
    </>
  );
}
