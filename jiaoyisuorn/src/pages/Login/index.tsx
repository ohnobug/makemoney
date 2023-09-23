import React, { useRef, useState } from "react";
import {
  Image,
  Platform,
  StyleSheet,
  Text,
  TextInput,
  TouchableOpacity,
  View,
} from "react-native";
import LJNButton from "../../components/LJNButton";
import LJNHeader from "../../components/LJNHeader";
import LJNHeaderScroll from "../../components/LJNHeaderScroll";
import LJNLineTitle from "../../components/LJNLineTitle";
import LJNLink from "../../components/LJNLink";
import { useStyles } from "hooks";
import { setTheme } from "./styles";

type Props = {
  navigation: any;
};

const Login = ({ navigation }: Props) => {
  const styles = useStyles(setTheme);

  // 顶部滑动
  let myswiperHeader = useRef<any>(null);

  // 输入框
  const [text, setText] = useState("");

  return (
    <View style={styles.ljn_container}>
      <LJNHeader title={""} navigation={navigation} />

      <View style={styles.ljn_main}>
        {/* 标题 */}
        <View style={styles.ljn_login_title}>
          <Text style={styles.ljn_login_title_text}>注册/登录您的账号</Text>
        </View>

        {/* 登录表单 */}
        <View style={styles.ljn_login_form_area}>
          {/* tabs */}
          <LJNHeaderScroll
            ref={myswiperHeader}
            list={["邮箱", "手机号"]}
            onChange={(n: number) => {}}
          />

          <View style={styles.ljn_login_form}>
            <View style={styles.ljn_login_form_row1}>
              <TextInput
                editable
                multiline={false}
                maxLength={40}
                onChangeText={(val: string) => {
                  setText(val);
                }}
                value={text}
                style={StyleSheet.flatten([
                  styles.ljn_login_form_row1_input,
                  Platform.OS === "web"
                    ? {
                        outline: "none",
                      }
                    : null,
                ])}
              />
            </View>
            <View style={styles.ljn_login_form_row2}>
              <LJNButton
                size="normal"
                title={"获取验证码"}
                style={{ width: "100%" }}
                onPress={() => {}}
              />
            </View>
            <View style={styles.ljn_login_form_row3}>
              <LJNLink
                title="密码登录"
                style={styles.ljn_login_form_row3_text}
              ></LJNLink>
            </View>
          </View>
        </View>

        {/* 其他方式 */}
        <LJNLineTitle title={"其他方式"} />
        <View style={styles.ljn_other_login_style}>
          <TouchableOpacity
            activeOpacity={0.6}
            style={styles.ljn_other_login_style_item}
          >
            <View style={styles.ljn_other_login_logo}>
              <Image
                style={styles.ljn_other_login_logo_img}
                source={require("assets/images/facebook_logo.png")}
              />
            </View>
            <View style={styles.ljn_other_login_title}>
              <Text style={styles.ljn_other_login_title_text}>Facebook</Text>
            </View>
          </TouchableOpacity>

          <TouchableOpacity
            activeOpacity={0.6}
            style={styles.ljn_other_login_style_item}
          >
            <View style={styles.ljn_other_login_logo}>
              <Image
                style={styles.ljn_other_login_logo_img}
                source={require("assets/images/google_logo.png")}
              />
            </View>
            <View style={styles.ljn_other_login_title}>
              <Text style={styles.ljn_other_login_title_text}>Google</Text>
            </View>
          </TouchableOpacity>

          <TouchableOpacity
            activeOpacity={0.6}
            style={styles.ljn_other_login_style_item}
          >
            <View style={styles.ljn_other_login_logo}>
              <Image
                style={styles.ljn_other_login_logo_img}
                source={require("assets/images/twitter_logo.png")}
              />
            </View>
            <View style={styles.ljn_other_login_title}>
              <Text style={styles.ljn_other_login_title_text}>Twitter</Text>
            </View>
          </TouchableOpacity>
        </View>

        <View style={styles.ljn_tips_text}>
          <Text style={styles.ljn_user_tips_text}>继续注册即代表同意</Text>
          <LJNLink
            title="《用户协议》"
            style={styles.ljn_user_agreement}
          ></LJNLink>
          <Text style={styles.ljn_user_tips_text}>和</Text>
          <LJNLink title="《隐私协议》"></LJNLink>
        </View>
      </View>
    </View>
  );
};

export default Login;
