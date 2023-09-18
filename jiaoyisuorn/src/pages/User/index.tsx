import React from "react";
import { View } from "react-native";
import LJNScrollView from "../../components/LJNScrollView";
import LJNTabbar from "../../components/LJNTabbar";
import { useAppDispatch, useAppSelector, useStyles } from "../../hooks";
import LJNActivation1 from "./Components/LJNActivation1";
import LJNUserInfo from "./Components/LJNUserInfo";
import { setTheme } from "./styles";
import { useNavigate } from "react-router-native";
import { selectAppTheme, setAppTheme } from "../../store/SystemSlice";

type Props = {};

export default function index({}: Props) {
  const styles = useStyles(setTheme);

  const navigate = useNavigate();
  const theme = useAppSelector(selectAppTheme);
  const dispatch = useAppDispatch();

  return (
    <View style={styles.container}>
      <LJNScrollView
        style={styles.ljn_main}
        horizontal={false}
        children={
          <>
            {/* 用户信息区域 */}
            <LJNUserInfo />

            {/* 其他信息 */}
            <View style={styles.ljn_activation_area}>
              <LJNActivation1
                title={"新手任务"}
                onClick={() => {
                  navigate("/login");
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
          </>
        }
      />

      <View style={styles.ljn_footer}>
        <LJNTabbar />
      </View>
    </View>
  );
}
