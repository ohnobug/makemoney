import React, { useContext, useEffect, useState } from "react";
import { Image, Text, View } from "react-native";
import LJNLoading from "components/LJNLoading";
import { useStyles } from "hooks";
import { setTheme } from "./styles";
import context from "pages/SlideHome/context";
import { px2vw } from "utils/utils";
import { useAppSelector } from "hooks";
import { selectAppTheme } from "store/SystemSlice";
import darkTheme from "themes/default/styles";
import lightTheme from "themes/light/styles";

type Props = {
  title: string,
  olist: any
};

const LJNNav = ({ title, olist }: Props) => {
  const [list, setList] = useState(olist);

  const styles = useStyles(setTheme);

  let [show, setShow] = useState(true);
  useEffect(() => {
    let timer = setTimeout(() => {
      setShow(true);
    }, 0);

    return () => {
      clearTimeout(timer);
    };
  }, []);

  const ctx = useContext<any>(context);
  const navigate = ctx.navigate;
  const theme = useAppSelector(selectAppTheme);


  return (
    <View style={{
      // height: px2vw(170),
      backgroundColor: theme === 'dark' ? darkTheme.areaBackgroundColor : lightTheme.areaBackgroundColor,
      // paddingTop: px2vw(12),
      paddingBottom: px2vw(8),
      paddingLeft: px2vw(0),
      paddingRight: px2vw(0),
      borderRadius: px2vw(10),
      marginLeft: px2vw(8),
      marginRight: px2vw(8),
      marginBottom: px2vw(8),
    }}>
      <View style={{
        height: px2vw(45),
        // backgroundColor: "red",
        display: "flex",
        flexDirection: "row",
        alignItems: "center",
        paddingLeft: px2vw(15),
      }}>
        <Text style={{
          fontSize: px2vw(12),
          color: theme === 'dark' ? darkTheme.textColor : lightTheme.textColor,
        }}>{title}</Text>
      </View>

      <View style={{
        display: "flex",
        flexDirection: "row",
        flexWrap: "wrap",
        justifyContent: "flex-start",
        // backgroundColor: "red",
      }}>


        {show ? (
          list.map((item, index) => {
            return (
              <View
                style={{
                  flexGrow: 0,
                  flexShrink: 0,
                  flexBasis: "24%",
                  height: px2vw(65),
                  display: "flex",                  
                  alignItems: "center",
                  flexDirection: "column",
                  marginBottom: px2vw(10),
                }}
                key={index}
                onTouchEnd={() => {
                  console.log("跳转到", item.path);
                  navigate(item.screen, { screen: item.path });
                }}
              >
                <View style={styles.ljn_list_item_icon}>
                  <Image
                    style={styles.ljn_list_item_icon_img}
                    source={item.icon}
                  />
                </View>
                <View style={styles.ljn_list_item_title}>
                  <Text style={styles.ljn_list_item_title_inner}>
                    {item.title}
                  </Text>
                </View>
              </View>
            );
          })
        ) : (
          <LJNLoading />
        )}
      </View>
    </View>
  );
};

export default LJNNav;
