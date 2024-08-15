import { FlashList } from "@shopify/flash-list";
import LJNHeader from "components/LJNHeader";
import LJNIcon from "components/LJNIcon";
import { useAppSelector, useStyles } from "hooks";
import React, { useCallback, useEffect, useState } from "react";
import { Image, Text, TouchableHighlight, View } from "react-native";
import { Gesture } from "react-native-gesture-handler";
import { selectAppTheme } from "store/SystemSlice";
import darkTheme from "themes/default/styles";
import lightTheme from "themes/light/styles";
import { checkTap, px2vw } from "utils/utils";
import { setTheme } from "./styles";

interface IData {
  id: string;
  friendName: string;
  notice: boolean;
  message: string;
  avatar: any;
}
const DATA: IData[] = [
  {
    id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
    friendName: "花重月数",
    notice: true,
    message: "今天天气真好，阳光明媚，让人心情愉悦。",
    avatar: require("assets/chat/avatar/chat_1.jpg"),
  },
  {
    id: "4462b35d-e742-5011-9ed6-f10666ef8e9f",
    friendName: "旧梦如风°",
    notice: true,
    message: "你吃过了吗？吃的什么？有没有想我？",
    avatar: require("assets/chat/avatar/chat_2.jpg"),
  },
  {
    id: "c7e7c26e-aa86-5e7b-9bbd-018f46b27e7a",
    friendName: "蝶舞庄周",
    notice: true,
    message: "我很高兴见到你，今天看起来很不错。",
    avatar: require("assets/chat/avatar/chat_3.jpg"),
  },
  {
    id: "6390e7d0-c8bd-5929-b537-76f6577c591c",
    friendName: "绿逾初夏",
    notice: false,
    message: "你最近过得如何？工作顺利吗？有没有遇到什么有趣的事情？",
    avatar: require("assets/chat/avatar/chat_4.jpg"),
  },
  {
    id: "d87d7c11-04f1-569c-8fd3-de333397966c",
    friendName: "余笙南吟",
    notice: false,
    message: "今天上班/上学累吗？要注意休息哦。",
    avatar: require("assets/chat/avatar/chat_5.jpg"),
  },
  {
    id: "7c3f2f89-6eae-5658-bce9-b3d8e20e309c",
    friendName: "陈情匿旧酒",
    notice: false,
    message: "这个周末有什么计划？有没有想好去哪里玩？",
    avatar: require("assets/chat/avatar/chat_6.jpg"),
  },
  {
    id: "6b4ac788-576a-5a7c-be38-854571564bd1",
    friendName: "白桃乌龙",
    notice: false,
    message: "你喜欢看什么电影？我最近看了一部不错的电影，推荐给你！",
    avatar: require("assets/chat/avatar/chat_7.jpg"),
  },
  {
    id: "139bf645-623d-5791-ad6b-4907e5fc8309",
    friendName: "清浅ˋ旧时光",
    notice: false,
    message: "你最近有没有去旅行？去了哪些地方？感觉怎么样？",
    avatar: require("assets/chat/avatar/chat_8.jpg"),
  },
  {
    id: "35fe74be-e7cb-520e-9d79-1b19b1018249",
    friendName: "荒碎梦残",
    notice: false,
    message: "我听说你最近升职了，恭喜你！一定能够做得更好！",
    avatar: require("assets/chat/avatar/chat_9.jpg"),
  },
  {
    id: "18127772-a653-5ca6-ba2c-5b1b855aa236",
    friendName: "无梦相赠",
    notice: false,
    message: "你今天穿得很漂亮，看起来很有气质。",
    avatar: require("assets/chat/avatar/chat_10.jpg"),
  },
  {
    id: "a41401db-2dde-519d-bc9f-df6e51089c9e",
    friendName: "离人泪",
    notice: false,
    message: "你最喜欢的颜色是什么？是不是很时尚？",
    avatar: require("assets/chat/avatar/chat_11.jpg"),
  },
  {
    id: "335ebb66-9440-5a2e-9795-d1b10eaf626e",
    friendName: "伊人在水一方",
    notice: false,
    message: "你最近有没有去尝试新的餐厅？有没有吃到什么特别好吃的菜？",
    avatar: require("assets/chat/avatar/chat_12.jpg"),
  },
  {
    id: "abc8c77e-924c-5ba8-94bc-36978fda42c5",
    friendName: "与我共梦",
    notice: false,
    message: "你的生日是今天吗？生日快乐啊！有没有想好怎么庆祝？",
    avatar: require("assets/chat/avatar/chat_13.jpg"),
  },
  {
    id: "86f1db28-5c98-580d-b365-70a752fde80c",
    friendName: "挽弦暮笙",
    notice: false,
    message: "你平常喜欢做什么样的运动？我最近喜欢上了瑜伽。",
    avatar: require("assets/chat/avatar/chat_14.jpg"),
  },
  {
    id: "81fd1656-bfa0-5e12-bab4-9cbc208e3f4a",
    friendName: "开始厌倦",
    notice: false,
    message: "我觉得你很有创造力，一定能够做出很多很棒的东西。",
    avatar: require("assets/chat/avatar/chat_15.jpg"),
  },
  {
    id: "bbe17759-086d-51f6-871a-4fc5d7014fd3",
    friendName: "仙女收纳盒",
    notice: false,
    message: "你最近有没有追什么好剧？有没有推荐的电视剧？",
    avatar: require("assets/chat/avatar/chat_16.jpg"),
  },
  {
    id: "6e48d092-0d0e-5769-9837-96ee651c7a4b",
    friendName: "華燈初上",
    notice: false,
    message: "我很喜欢你的发型，看起来很时尚，一定是精心打理过的。",
    avatar: require("assets/chat/avatar/chat_17.jpg"),
  },
  {
    id: "dbc2eaca-56ce-5940-b9fc-9a42583ce674",
    friendName: "袖手今生",
    notice: false,
    message: "你是什么星座的？我最近对星座运势感兴趣了。",
    avatar: require("assets/chat/avatar/chat_18.jpg"),
  },
  {
    id: "be028228-1689-5058-903b-07b6d9380d78",
    friendName: "ら道不清的忧伤",
    notice: false,
    message: "我觉得你笑起来很好看，让人感觉很温暖。",
    avatar: require("assets/chat/avatar/chat_19.jpg"),
  },
  {
    id: "419adb76-6b8c-5602-a415-2d619b4fc17f",
    friendName: "凉生",
    notice: false,
    message: "你愿意和我一起去旅行吗？我们可以一起去探索未知的地方。",
    avatar: require("assets/chat/avatar/chat_20.jpg"),
  },
  {
    id: "b1b6b991-5f30-5039-896e-a8f694f94c4e",
    friendName: "墨香九歌",
    notice: false,
    message: "你的梦想是什么？我最近梦想成为一名优秀的厨师。",
    avatar: require("assets/chat/avatar/chat_21.jpg"),
  },
  {
    id: "d70f0966-df79-530c-b18d-bcf61e402bb8",
    friendName: "暖栀",
    notice: false,
    message: "你最近有没有学到什么新知识？我最近在学习一门新技能。",
    avatar: require("assets/chat/avatar/chat_22.jpg"),
  },
  {
    id: "0d0618d4-4520-5d8c-8c3f-e9fdf7048a3c",
    friendName: "等待许了苍老",
    notice: false,
    message: "我听说你要搬家了，是吗？祝贺你！新家在哪里？是不是很期待？",
    avatar: require("assets/chat/avatar/chat_23.jpg"),
  },
  {
    id: "8cf05eaa-4990-5f2c-8fc4-d4c3dd103093",
    friendName: "此昵称不存在",
    notice: false,
    message: "你的家人都好吗？他们是否也一切安好？",
    avatar: require("assets/chat/avatar/chat_24.jpg"),
  },
  {
    id: "d3c0b95b-2a3a-506e-9d33-d318015c8e7a",
    friendName: "长风",
    notice: false,
    message: "你有没有考虑过去创业？我最近有了一些新的想法。",
    avatar: require("assets/chat/avatar/chat_25.jpg"),
  },
  {
    id: "9bb1f004-e6d6-5486-8599-a0479af31957",
    friendName: "残阳暮雪",
    notice: false,
    message: "我很欣赏你的工作态度，一定能够取得很大的成就。",
    avatar: require("assets/chat/avatar/chat_26.jpg"),
  },
  {
    id: "45416737-8e10-55d7-9e2e-4a560cb87e90",
    friendName: "点到为止",
    notice: false,
    message: "你想要养宠物吗？养一只可爱的小狗或小猫怎么样？",
    avatar: require("assets/chat/avatar/chat_27.jpg"),
  },
  {
    id: "4c515c9f-c5ef-58a6-af94-b918277b0760",
    friendName: "素衣风尘叹",
    notice: false,
    message: "你喜欢看书吗？有没有什么推荐的书籍？我最近在看《论语》。",
    avatar: require("assets/chat/avatar/chat_28.jpg"),
  },
  {
    id: "04d307f4-150e-5a27-a574-d8bf5edfd7b9",
    friendName: "半心人",
    notice: false,
    message: "我最近在学烹饪，你想尝尝我的手艺吗？可以来找我哦！",
    avatar: require("assets/chat/avatar/chat_29.jpg"),
  },
  {
    id: "6e23cca1-c545-5c63-a997-45d87db376f1",
    friendName: "笑低了眉眼",
    notice: false,
    message: "我觉得你很幽默，一定能够给大家带来很多欢乐。",
    avatar: require("assets/chat/avatar/chat_30.jpg"),
  },
  {
    id: "faa7c794-e311-5ca4-bf78-4900358fae2e",
    friendName: "明媚殇",
    notice: false,
    message: "你想要去哪个城市旅游？我最近想去巴黎。",
    avatar: require("assets/chat/avatar/chat_31.jpg"),
  },
  {
    id: "4d5d0c4e-e58f-5578-abb9-404d6187a247",
    friendName: "暖梦旧歌",
    notice: false,
    message: "你的童年是怎样的？有没有很多美好的回忆？",
    avatar: require("assets/chat/avatar/chat_32.jpg"),
  },
  {
    id: "dafa3cc0-1a2c-53f5-835d-c55312177368",
    friendName: "偏爱",
    notice: false,
    message: "你喜欢看日出还是日落？我更喜欢看日落。",
    avatar: require("assets/chat/avatar/chat_33.jpg"),
  },
  {
    id: "a4986a55-9c65-57b5-ade7-74b94c9e95e2",
    friendName: "剑魄琴心",
    notice: false,
    message: "我很享受和你聊天的时光，希望以后能够经常联系。",
    avatar: require("assets/chat/avatar/chat_34.jpg"),
  },
  {
    id: "5a88682d-835c-530f-b32e-cf696d4510c2",
    friendName: "凉笙墨染",
    notice: false,
    message: "你有没有喜欢的明星或名人？我最近喜欢上了王俊凯。",
    avatar: require("assets/chat/avatar/chat_35.jpg"),
  },
  {
    id: "f87c4b58-35ed-5f35-a181-5dae1cf200c8",
    friendName: "男医",
    notice: false,
    message: "你的家人支持你的工作/学业吗？他们一直很支持我。",
    avatar: require("assets/chat/avatar/chat_36.jpg"),
  },
  {
    id: "2ebbe9ac-d3f1-5b76-a670-7f26c86b567b",
    friendName: "不谙世事",
    notice: false,
    message: "你想要养什么类型的植物或花卉？我喜欢养多肉植物。",
    avatar: require("assets/chat/avatar/chat_37.jpg"),
  },
  {
    id: "69063e04-e7e9-5fc7-905e-00eaf360a0bb",
    friendName: "纯净的眸子",
    notice: false,
    message: "我最近开始学习一门新技能，你猜是什么？学会了再告诉你！",
    avatar: require("assets/chat/avatar/chat_38.jpg"),
  },
  {
    id: "72a2a0ea-930d-5097-87df-3001cd5429c3",
    friendName: "橘子风车",
    notice: false,
    message: "我很感激你的帮助，让我感受到了温暖和关怀。",
    avatar: require("assets/chat/avatar/chat_39.jpg"),
  },
  {
    id: "92e8d98e-016a-5db8-80da-1dd4a3fdf5ce",
    friendName: "醉过无痕",
    notice: false,
    message: "你想要尝试极限运动吗？比如滑雪和冲浪。",
    avatar: require("assets/chat/avatar/chat_40.jpg"),
  },
  {
    id: "70d2cc19-735c-5377-b5f3-87ceb5407d86",
    friendName: "悠悠我心",
    notice: false,
    message:
      "你喜欢听音乐吗？有没有推荐的乐队或歌手？我最近喜欢上了毛不易的歌。",
    avatar: require("assets/chat/avatar/chat_41.jpg"),
  },
  {
    id: "f886c85b-cd50-5ff0-84e4-f9f9f14ca5eb",
    friendName: "只倾心不倾城",
    notice: false,
    message: "我最近开始关注营养饮食，你呢？有没有什么好的建议？",
    avatar: require("assets/chat/avatar/chat_42.jpg"),
  },
  {
    id: "735c4f25-54f5-56e3-8e3d-36b4dbb47d2a",
    friendName: "心安是归处",
    notice: false,
    message: "我觉得你很独立，一定能够自己做好很多事情。",
    avatar: require("assets/chat/avatar/chat_43.jpg"),
  },
  {
    id: "70f03f90-5ad3-5993-b69e-1c30d4c92690",
    friendName: "天凝",
    notice: false,
    message: "你喜欢看哪种类型的电影或电视剧？我喜欢看爱情片和喜剧片。",
    avatar: require("assets/chat/avatar/chat_44.jpg"),
  },
  {
    id: "8b008ba9-83cf-5fbe-9d55-a8aea0a0a4c3",
    friendName: "心思爆甜",
    notice: false,
    message: "我听说你要去参加一个重要的面试/考试，祝你好运！你一定能够成功！",
    avatar: require("assets/chat/avatar/chat_45.jpg"),
  },
  {
    id: "95f350e3-6f8b-5d51-a71d-296812fb3a4b",
    friendName: "若羽ぬ",
    notice: false,
    message: "我很期待和你一起去看那场演唱会/电影/比赛，一定会有很棒的体验。",
    avatar: require("assets/chat/avatar/chat_46.jpg"),
  },
  {
    id: "7593f773-1ab9-5018-b5d3-73565c2ef84e",
    friendName: "旧念何挽",
    notice: false,
    message: "你觉得自己的穿衣风格是什么？我喜欢休闲和简约的风格。",
    avatar: require("assets/chat/avatar/chat_47.jpg"),
  },
  {
    id: "98bb4b0a-6001-5a02-ba45-17f8ad014f85",
    friendName: "静已思之愈脓",
    notice: false,
    message: "嘿，你在做什么？我刚好在准备一份报告。",
    avatar: require("assets/chat/avatar/chat_48.jpg"),
  },
  {
    id: "4cf44d5c-ce06-547a-92f8-79c97a1aa84c",
    friendName: "白鹿",
    notice: false,
    message: "今天天气真是糟透了。是的，雨下得很大，路面都淹水了。",
    avatar: require("assets/chat/avatar/chat_49.jpg"),
  },
  {
    id: "4e7c1526-4e1a-5d95-9185-7447b8b94aab",
    friendName: "歌满长安",
    notice: false,
    message:
      "你听说过最近的那个热门话题吗？是的，那个关于环境保护的话题很热门。",
    avatar: require("assets/chat/avatar/chat_50.jpg"),
  },
  {
    id: "0cd03b26-3cfe-5ead-8e6e-79ec2d3dc1c5",
    friendName: "夜莹",
    notice: false,
    message: "我最近在追的一部剧终于更新了！太好了，又可以继续追剧了。",
    avatar: require("assets/chat/avatar/chat_51.jpg"),
  },
  {
    id: "097cb20e-a0e8-592d-be77-d9f077a54438",
    friendName: "墨染殇雪",
    notice: false,
    message: "你在写日记吗？是的，我记录了一些今天发生的事情。",
    avatar: require("assets/chat/avatar/chat_52.jpg"),
  },
  {
    id: "4bb45f4f-671b-5c65-8396-641eab996ac6",
    friendName: "北城半夏",
    notice: false,
    message: "我刚看完一本好书，推荐给你！谢谢，我最近在读《麦田里的守望者》。",
    avatar: require("assets/chat/avatar/chat_53.jpg"),
  },
  {
    id: "bebc2f50-960b-57f5-8d91-119006075a93",
    friendName: "不语却知心*",
    notice: false,
    message: "你在想什么？我正在想一个有趣的点子。",
    avatar: require("assets/chat/avatar/chat_54.jpg"),
  },
  {
    id: "8f2a0760-04ed-5806-ab5c-98730e7cebf7",
    friendName: "迷途散了雾",
    notice: false,
    message: "我觉得我需要多做一些运动。是的，保持健康是很重要的。",
    avatar: require("assets/chat/avatar/chat_55.jpg"),
  },
  {
    id: "0270450e-6e89-5898-be1e-613df770e5d4",
    friendName: "紫涩微凉",
    notice: false,
    message: "你在读什么书？我正在读一本关于历史的小说。",
    avatar: require("assets/chat/avatar/chat_56.jpg"),
  },
  {
    id: "d89d17ce-92e7-5441-a12d-949a6af5884a",
    friendName: "归途",
    notice: false,
    message: "你对未来有什么期待？我希望能够实现我的梦想。",
    avatar: require("assets/chat/avatar/chat_57.jpg"),
  },
  {
    id: "28e8d285-76b2-5ecb-aa0a-57934af4522c",
    friendName: "浅凉",
    notice: false,
    message: "你有没有喜欢的电影明星？是的，我非常喜欢Tom Hanks。",
    avatar: require("assets/chat/avatar/chat_58.jpg"),
  },
  {
    id: "9c94cfe2-bb54-57cb-ae4e-a0bb5a616bd8",
    friendName: "就要一梦南柯",
    notice: false,
    message: "我觉得你应该多笑笑。谢谢，我会尽量多笑的。",
    avatar: require("assets/chat/avatar/chat_59.jpg"),
  },
  {
    id: "a83d623e-c83f-5290-9ee9-8008f5fac568",
    friendName: "墨染傾城",
    notice: false,
    message: "你在哪里买的那件衣服？我在一家名叫Zara的店里买的。",
    avatar: require("assets/chat/avatar/chat_60.jpg"),
  },
  {
    id: "240fc36a-0760-595d-9044-f1b158ef34d6",
    friendName: "清泪伊人醉-",
    notice: false,
    message: "我刚刚在网上买了一些生活用品。是的，网购非常方便。",
    avatar: require("assets/chat/avatar/chat_61.jpg"),
  },
  {
    id: "05bf5257-77be-55f7-a7a3-6b2b93141783",
    friendName: "思念托春风寄去",
    notice: false,
    message: "你听说过最近的那个大新闻吗？当然，那件关于政治的事情很引人关注。",
    avatar: require("assets/chat/avatar/chat_62.jpg"),
  },
  {
    id: "4b3786b5-43f4-5627-9d98-b52b0885b42d",
    friendName: "三分醒°柒分醉",
    notice: false,
    message: "我觉得你应该多休息一下。谢谢你的建议，我会尽量多休息的。",
    avatar: require("assets/chat/avatar/chat_63.jpg"),
  },
  {
    id: "1b433810-955a-5d26-afe0-93263038c1db",
    friendName: "若迈风",
    notice: false,
    message: "你在做什么运动？我正在做一些有氧运动来保持身材。",
    avatar: require("assets/chat/avatar/chat_64.jpg"),
  },
  {
    id: "59f45924-003e-5052-bb4a-e5d16585dc01",
    friendName: "淡淡稻花香",
    notice: false,
    message: "我最近在学习一门外语。我正在学习日语，但进展很慢。",
    avatar: require("assets/chat/avatar/chat_65.jpg"),
  },
  {
    id: "9da95920-5f27-574a-84df-d79e166895e6",
    friendName: "楼兰一梦",
    notice: false,
    message: "你今天过得怎么样？今天很忙碌，但是也学到了很多东西。",
    avatar: require("assets/chat/avatar/chat_66.jpg"),
  },
  {
    id: "5d1bf246-5c40-54d4-b50f-4f0ad29d32ab",
    friendName: "一身仙女味",
    notice: false,
    message: "你有没有喜欢的歌手或乐队？我很喜欢Taylor Swift的歌曲。",
    avatar: require("assets/chat/avatar/chat_67.jpg"),
  },
  {
    id: "6c93f675-9823-5a8e-95c8-97ed6e756322",
    friendName: "海蓝无魂",
    notice: false,
    message: "你喜欢看书还是看电视？我更喜欢看电视，因为可以放松身心。",
    avatar: require("assets/chat/avatar/chat_68.jpg"),
  },
  {
    id: "64db6f4e-406e-540b-9c66-5b5a0dda0764",
    friendName: "旧事太过惘然。",
    notice: false,
    message: "你最近有没有去旅行？我最近去了上海参观世博会。",
    avatar: require("assets/chat/avatar/chat_69.jpg"),
  },
  {
    id: "0acb1933-e37e-59a4-810f-136d6ec365a8",
    friendName: "瑾萱",
    notice: false,
    message: "你喜欢看什么类型的书？我喜欢看小说和传记。",
    avatar: require("assets/chat/avatar/chat_70.jpg"),
  },
  {
    id: "47e8f073-845c-51a8-ac24-a5817df702f5",
    friendName: "思念托春风寄去",
    notice: false,
    message: "你最喜欢的季节是什么？我最喜欢的是夏天，因为可以去海滩玩水。",
    avatar: require("assets/chat/avatar/chat_71.jpg"),
  },
  {
    id: "f0820e47-84f2-5b29-a5c7-8695bccc4197",
    friendName: "春暖花开",
    notice: false,
    message: "你有没有喜欢的歌手或乐队？我非常喜欢披头士乐队。",
    avatar: require("assets/chat/avatar/chat_72.jpg"),
  },
  {
    id: "ca5182a8-3555-52c9-a87b-b587885fdbdb",
    friendName: "岁月安然",
    notice: false,
    message:
      "你喜欢看电影还是电视剧？我更喜欢看电影，因为可以在短时间内了解故事情节。",
    avatar: require("assets/chat/avatar/chat_73.jpg"),
  },
  {
    id: "c28574fe-f0aa-5359-b9a5-f50304cfc91b",
    friendName: "话多心凉",
    notice: false,
    message: "你有没有喜欢的运动项目？我最喜欢的运动是篮球。",
    avatar: require("assets/chat/avatar/chat_74.jpg"),
  },
  {
    id: "5c9c1ff6-46aa-5419-a581-f007a097f142",
    friendName: "浅浅℡",
    notice: false,
    message: "你喜欢甜食还是咸食？我更喜欢甜食，因为它们很美味。",
    avatar: require("assets/chat/avatar/chat_75.jpg"),
  },
  {
    id: "016add49-7c7f-5d48-9198-19710e147805",
    friendName: "浅浅嫣然笑",
    notice: false,
    message: "你今天穿的衣服是什么风格？我今天穿的是休闲装，很舒适。",
    avatar: require("assets/chat/avatar/chat_76.jpg"),
  },
  {
    id: "41ce32fa-6bec-5405-988f-af6bab9ede15",
    friendName: "游灵",
    notice: false,
    message:
      "你喜欢在家里看书还是去图书馆？我更喜欢去图书馆，因为那里有很多书籍可以选择。",
    avatar: require("assets/chat/avatar/chat_77.jpg"),
  },
  {
    id: "a700c08f-fef9-50e7-b6fa-e6c0faa7a0c5",
    friendName: "╮曾經的回憶",
    notice: false,
    message: "你最近有没有追什么好剧？我最近在追《权力的游戏》。",
    avatar: require("assets/chat/avatar/chat_78.jpg"),
  },
  {
    id: "525b9f9a-7c2e-5987-aeb3-b2755b32968a",
    friendName: "白河夜船",
    notice: false,
    message:
      "你在工作中遇到过哪些挑战？我最近遇到了一个技术难题，但最终解决了。",
    avatar: require("assets/chat/avatar/chat_79.jpg"),
  },
  {
    id: "6fcad2ff-7f01-5f25-8ece-ef7a997c5504",
    friendName: "夜簌",
    notice: false,
    message: "你喜欢喝哪种类型的咖啡或茶？我喜欢喝拿铁咖啡。",
    avatar: require("assets/chat/avatar/chat_80.jpg"),
  },
  {
    id: "ab42b977-e1ff-5e43-b2ae-c10df6ec6710",
    friendName: "拾柒",
    notice: false,
    message: "你觉得自己的优点是什么？我认为我的优点是勤奋和聪明。",
    avatar: require("assets/chat/avatar/chat_81.jpg"),
  },
  {
    id: "2d7565d0-7842-5b71-8e53-909a5a7c052d",
    friendName: "神爱温柔人",
    notice: false,
    message: "你今天心情如何？我今天心情很好，因为和朋友们一起出去玩很开心。",
    avatar: require("assets/chat/avatar/chat_82.jpg"),
  },
  {
    id: "a1258976-bb0d-5cda-9f51-408cc1257721",
    friendName: "风迷了眼",
    notice: false,
    message:
      "你喜欢去哪里旅游？我最想去的是南非的开普敦，那里有美丽的自然风景和丰富的文化体验。",
    avatar: require("assets/chat/avatar/chat_83.jpg"),
  },
  {
    id: "c96df4dd-1f91-5cc8-8269-a1dba8d8a889",
    friendName: "越奋力越幸运",
    notice: false,
    message: "你有没有喜欢的动物？我最喜欢的动物是狗，因为它们很可爱忠诚。",
    avatar: require("assets/chat/avatar/chat_84.jpg"),
  },
  {
    id: "042fbf74-4c24-532b-8176-63def05f1377",
    friendName: "鹤逐巫山",
    notice: false,
    message: "你最近有没有学到什么新知识？我最近在学习如何使用Python编程语言。",
    avatar: require("assets/chat/avatar/chat_85.jpg"),
  },
  {
    id: "7aacbe12-0ea1-5ba4-b556-6928761ba014",
    friendName: "风月斟酒",
    notice: false,
    message:
      "你喜欢听流行音乐还是古典音乐？我更喜欢听古典音乐，因为它有很深的情感表达和艺术性。",
    avatar: require("assets/chat/avatar/chat_86.jpg"),
  },
  {
    id: "da09f5e2-8da7-5023-8bd8-00048a061682",
    friendName: "旧人moon",
    notice: false,
    message:
      "你喜欢在城市生活还是乡村生活？我更喜欢在城市生活，因为那里有很多便利设施和娱乐活动。",
    avatar: require("assets/chat/avatar/chat_87.jpg"),
  },
  {
    id: "1f7670ac-c212-5b42-adaf-97c2ff51d08a",
    friendName: "醉酒沉香",
    notice: false,
    message:
      "你觉得友谊中最重要的是什么？我认为友谊中最重要的是互相理解和支持。",
    avatar: require("assets/chat/avatar/chat_88.jpg"),
  },
  {
    id: "8371e210-738c-5862-a1dc-fcd29c4ec5b4",
    friendName: "阳光暖心脏",
    notice: false,
    message:
      "你的梦想是什么？我的梦想是成为一名优秀的工程师，为人们创造美好的生活。",
    avatar: require("assets/chat/avatar/chat_89.jpg"),
  },
  {
    id: "6ae258da-2111-5ead-aa41-7ff9d51f5511",
    friendName: "失之淡然",
    notice: false,
    message: "你今天做了什么好事？我今天帮助了一个需要帮助的朋友，他很感激。",
    avatar: require("assets/chat/avatar/chat_90.jpg"),
  },
  {
    id: "0924b40e-ec01-59c3-89d7-dd0f56db0a10",
    friendName: "锦衾薄ご",
    notice: false,
    message: "我最近有没有见到你？我们最近没有见面，但我很高兴能够和你聊天。",
    avatar: require("assets/chat/avatar/chat_91.jpg"),
  },
  {
    id: "02232d8e-f694-5633-8093-0d628aae7d25",
    friendName: "她的糖好苦",
    notice: false,
    message: "你有什么爱好？我爱好游泳和摄影，这些让我放松并充满乐趣。",
    avatar: require("assets/chat/avatar/chat_92.jpg"),
  },
  {
    id: "a9b533b1-2643-5b84-94e0-5ae645f24f9a",
    friendName: "万木争春",
    notice: false,
    message:
      "你有没有喜欢的节日？我最喜欢的节日是春节，因为它充满了欢乐和家庭的团聚。",
    avatar: require("assets/chat/avatar/chat_93.jpg"),
  },
  {
    id: "bf4a8689-ccc4-5c8e-a7b9-b3dc3155e640",
    friendName: "胸有大志",
    notice: false,
    message:
      "你平时喜欢做什么样的运动？我平时喜欢做瑜伽和慢跑，这些让我保持身体健康。",
    avatar: require("assets/chat/avatar/chat_94.jpg"),
  },
  {
    id: "4c5cdf55-05e7-5c0b-9d8c-9e4d26d341f2",
    friendName: "樱田",
    notice: false,
    message:
      "你觉得自己的穿衣风格是什么？我最近的穿衣风格比较休闲和简约，因为这样让我感觉舒适自在。",
    avatar: require("assets/chat/avatar/chat_95.jpg"),
  },
  {
    id: "aed3b48d-3ec3-5aa3-b4fb-c755067598ad",
    friendName: "南莲楚简",
    notice: false,
    message: "你今天吃了什么？我今天吃了一份健康的沙拉和一份鸡肉三明治。",
    avatar: require("assets/chat/avatar/chat_96.jpg"),
  },
  {
    id: "c9c37c8c-4631-58ed-80e5-9ed1aa78d19d",
    friendName: "捞月亮的人",
    notice: false,
    message:
      "这个周末你有什么计划？我打算在家做一些家务，并看一本我很期待的小说。",
    avatar: require("assets/chat/avatar/chat_97.jpg"),
  },
  {
    id: "2894a5fc-05bf-5eb2-ae8e-f4b7570e92cc",
    friendName: "远方",
    notice: false,
    message: "你有没有喜欢的运动项目？我最喜欢的运动是篮球。",
    avatar: require("assets/chat/avatar/chat_98.jpg"),
  },
  {
    id: "71226c90-c2b1-5585-9580-25d6c1170680",
    friendName: "花开宿语",
    notice: false,
    message: "你有没有喜欢的动物？我最喜欢的动物是狗，因为它们很可爱忠诚。",
    avatar: require("assets/chat/avatar/chat_99.jpg"),
  },
  {
    id: "a2326f7d-384f-5ed0-9961-2410a7fb9ef1",
    friendName: "清波晃日",
    notice: false,
    message:
      "你喜欢听流行音乐还是古典音乐？我更喜欢听古典音乐，因为它有很深的情感表达和艺术性。",
    avatar: require("assets/chat/avatar/chat_100.jpg"),
  },
  {
    id: "f3728ef1-6382-5935-a129-e48d2220bc0f",
    friendName: "隐隐仙姬",
    notice: false,
    message: "我最近有没有见到你？我们最近没有见面，但我很高兴能够和你聊天。",
    avatar: require("assets/chat/avatar/chat_101.jpg"),
  },
  {
    id: "9d590140-9b81-565b-a4e7-2a7090caa7cf",
    friendName: "故笙诉离歌",
    notice: false,
    message: "你有没有喜欢的歌手或乐队？我非常喜欢披头士乐队。",
    avatar: require("assets/chat/avatar/chat_102.jpg"),
  },
];

const HEIGHT = px2vw(69);

const myData: any = DATA.map((item: any, index) => {
  item.offset = index * HEIGHT;
  return item;
});

type ItemProps = {
  item: {
    id: string;
    friendName: string;
    message: string;
    notice: boolean;
    avatar: any;
    offset: number;
  };
  tapPosition: {
    x: number;
    y: number;
  };
  scrollPosition: number;
  navigation: any;
};

function RenderItem({
  item,
  tapPosition,
  scrollPosition,
  navigation,
}: ItemProps) {
  const styles = useStyles(setTheme);
  const theme = useAppSelector(selectAppTheme);

  const { id, friendName, message, notice, avatar, offset } = item;

  useEffect(() => {
    if (
      checkTap(
        {
          x1: 0,
          y1: 0 + (offset - scrollPosition),
          x2: px2vw(375),
          y2: HEIGHT + (offset - scrollPosition),
        },
        tapPosition
      )
    ) {
      // console.log("你在", i, "中短按");
      console.log("你按的是", friendName);
      navigation.navigate("chatMessage");
    }
  }, [tapPosition, scrollPosition]);

  const onPress = (item: any) => {
    // console.log("你点击了");
    navigation.navigate("chatMessage", {
      friendInfo: item
    });
  };

  return (
    <TouchableHighlight
      activeOpacity={0.1}
      underlayColor={"#ededed"}
      onPress={() => onPress(item)}
      style={notice ? styles.ljn_chat_item_notice : styles.ljn_chat_item}
    >
      <>
      {/* 头像 */}
      <View style={styles.ljn_avatar_box}>
        <Image style={styles.ljn_avatar} source={avatar} />
      </View>

      {/* 名字和聊天信息 */}
      <View
        style={
          notice
            ? styles.ljn_chat_message_info_notice
            : styles.ljn_chat_message_info
        }
      >
        {/* 好友名称 */}
        <View style={styles.ljn_chat_friend_info_row}>
          <View style={styles.ljn_chat_friend_name_box}>
            <Text style={styles.ljn_chat_friend_name} numberOfLines={1}>
              {friendName}
            </Text>
          </View>
          <View style={styles.ljn_chat_date_box}>
            <Text style={styles.ljn_chat_date}>17:25</Text>
          </View>
        </View>

        {/* 好友消息盒子 */}
        <View style={styles.ljn_chat_message_box_row}>
          <View style={styles.ljn_chat_message_box}>
            <Text style={styles.ljn_chat_message} numberOfLines={1}>
              {message}
            </Text>
          </View>
          <View style={styles.ljn_chat_message_icon}>
            {notice ? (
              <LJNIcon
                title={"jingyin1-05"}
                size={16}
                color={
                  theme === "dark"
                    ? darkTheme.chatBriefMessageColor
                    : lightTheme.chatBriefMessageColor
                }
              />
            ) : null}
          </View>
        </View>
      </View>
      </>
    </TouchableHighlight>
  );
}

type Props = any;
export default function SlideChat({ navigation }: Props) {
  const styles = useStyles(setTheme);
  const theme = useAppSelector(selectAppTheme);

  // 记录滚动的位置
  const [scrollPosition, setScrollPosition] = useState(0);
  const handleScroll = (event: any) => {
    const position = event.nativeEvent.contentOffset.y;
    setScrollPosition(position);
  };

  const [longTapPosition, setLongTapPosition] = useState({ x: 0, y: 0 });
  const [tapPosition, setTapPosition] = useState({ x: 0, y: 0 });
  // 长按
  const longTap = Gesture.Pan()
    .activateAfterLongPress(400)
    .runOnJS(true)
    .onStart((e) => {
      console.log("长按", {
        x: e.x,
        y: e.y,
      });
      setLongTapPosition({
        x: e.x,
        y: e.y,
      });
    })
    .onEnd((e) => {
      setLongTapPosition({
        x: 0,
        y: 0,
      });
    });

  // 点击
  const singleTap = Gesture.Tap()
    .maxDuration(120)
    .runOnJS(true)
    .maxDeltaY(5)
    .maxDeltaX(5)
    .onStart((e) => {
      console.log("短按", {
        x: e.x,
        y: e.y,
      });
      setTapPosition({
        x: e.x,
        y: e.y,
      });
    })
    .onEnd((e) => {
      setTapPosition({
        x: 0,
        y: 0,
      });
    });

  const _renderitem = useCallback(
    ({ item }: any) => (
      <RenderItem
        item={item}
        tapPosition={tapPosition}
        scrollPosition={scrollPosition}
        navigation={navigation}
      />
    ),
    []
  );

  return (
    <View style={styles.container}>
      <LJNHeader title={"微信"}></LJNHeader>

      <View style={styles.ljn_chat_login_status}>
        <View style={styles.ljn_chat_login_status_icon}>
          <LJNIcon
            title={"diannao"}
            size={20}
            color={
              theme === "dark"
                ? darkTheme.chatStatusTextColor
                : lightTheme.chatStatusTextColor
            }
          />
        </View>
        <Text style={styles.ljn_chat_login_status_text}>Windows微信已登录</Text>
      </View>

      <View style={styles.ljn_main}>
        <FlashList
          renderItem={_renderitem}
          // getItemType={({ item }: any) => {
          //   return item.id;
          // }}
          estimatedItemSize={HEIGHT}
          data={myData}
        />
        {/* <GestureDetector gesture={Gesture.Simultaneous(longTap)}> */}
        {/* <FlatList
          // removeClippedSubviews={false}
          // pointerEvents="none"
          // initialNumToRender={20} // 首批渲染的元素数量
          // windowSize={15} // 渲染区域高度
          // maxToRenderPerBatch={80} // 增量渲染最大数量
          data={myData}
          // alwaysBounceHorizontal={false}
          // alwaysBounceVertical={false}
          // bounces={false}
          // overScrollMode="never"
          getItemLayout={(data: any, index: number) => {
            return { length: HEIGHT, offset: HEIGHT * index, index: index };
          }}
          onScroll={handleScroll}
          showsVerticalScrollIndicator={false}
          renderItem={_renderitem}
          keyExtractor={(item) => item.id}
        /> */}
        {/* </GestureDetector> */}
      </View>
    </View>
  );
}
