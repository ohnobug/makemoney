import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNSearchPage extends StatefulWidget {
  const LJNSearchPage({super.key});

  @override
  State<LJNSearchPage> createState() => _LJNSearchPage();
}

class _LJNSearchPage extends State<LJNSearchPage> {
  double _statusHeight = 0;
  List<Widget> historyList = [];
  List<Widget> suggestionsForYouList = [];
  List<Widget> hotList = [];

  @override
  void initState() {
    super.initState();

    // 历史
    historyList.addAll([
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "俄公开恐怖分子被捕的画面"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "微软宣布将终止对Windows10的支持"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "唐尚珺是弱智的吗 考了那么多次高考"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "美国大选最新消息"),
    ]);

    // 猜你想搜
    suggestionsForYouList.addAll([
      Text(
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        "李小龙标志性打耳光动作",
        style: TextStyle(fontSize: 32.w, height: 1.08, color: Colors.red),
      ),
      Text(
        style: TextStyle(fontSize: 32.w, height: 1.08, color: Colors.red),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        "向佐扇自己一耳光",
      ),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "美国大选最新消息"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "两任市委书记的“政绩工程”将被拆"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "习近平在湖北考察调研"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "宝妈吃瑞士卷被质疑剧本 网信办回应"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "进博新老朋友如约而至"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "美国大选选举结果或延迟公布"),
    ]);

    // 热榜
    hotList.addAll([
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "上海世茂等被强制执行17.6亿"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "特朗普痛骂佩洛西时差点爆粗口"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "睡光板床可治腰椎病？不准确"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "美国选举日首个投票点结果出炉"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "#美国大选结果对全世界有什么影响#"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "国际专家解读2024美国大选"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "美国大选今日投票 世界瞩目"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "产妇急需剖腹产却被家属要求卡点生"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "河南固始县一男子杀害妻子被抓获"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "红-19地空导弹将首次展出"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "男生偶遇七胞胎逛商场大呼震撼"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "湖南夫妻理发店因听劝爆火"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "刘晓庆前男友报警"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "3娃打闹家长先指挥后互殴 警方通报"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "王传君交罚款为女儿摘柿子"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "女大学生夜骑开封失败让妈妈开车接"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "乌克兰称已同朝鲜军队发生交战"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "最高检：五年来帮农民工讨薪2.8亿"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "班主任在家长群催缴医保 当地回应"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "国家气候中心：我国今冬大概率偏冷"),
      Text(
          style: TextStyle(fontSize: 32.w, height: 1.08),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "#2024美国大选那些事儿#"),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (kIsWeb) {
      _statusHeight = 0;
    } else {
      _statusHeight = MediaQuery.of(context).padding.top;
    }

    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return Scaffold(
              primary: false,
              appBar: null,
              body: Container(
                  width: screenSize.width,
                  height: screenSize.height,
                  child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          child: Column(
                            children: [
                              // 搜索
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 0.w),
                                margin: EdgeInsets.only(top: _statusHeight),
                                // color: const Color.fromARGB(255, 221, 76, 76), // 设置背景颜色
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () =>
                                          Navigator.of(context).pop(), // 点击事件
                                      child: Container(
                                        // 加盒子是为了扩大点击区域
                                        color: Colors.transparent,
                                        child: Icon(
                                          const IconData(
                                            0xed9e,
                                            fontFamily: 'Iconfont',
                                          ), // 使用的图标
                                          color: Colors.black, // 图标颜色
                                          size: 36.w, // 图标大小
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            // color: Colors.blue,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15.w),
                                            height: 65.w,
                                            child: TextField(
                                              onTapOutside: (event) {
                                                FocusScope.of(context)
                                                    .unfocus();
                                              },
                                              cursorHeight: 35.w,
                                              cursorWidth: 3.w,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  const IconData(
                                                    0xe612,
                                                    fontFamily: 'Iconfont',
                                                  ),
                                                  color: Colors.black,
                                                  size: 40.w,
                                                ),
                                                prefixIconConstraints:
                                                    BoxConstraints(
                                                  minWidth:
                                                      70.w, // 控制图标与文字的最小宽度
                                                  // minHeight: 36.w,
                                                ),
                                                hintText: "搜索",
                                                hintStyle: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 30.w,
                                                    color: const Color.fromARGB(
                                                        255, 69, 75, 83)),
                                                filled: true,
                                                fillColor: const Color.fromARGB(
                                                    255, 217, 220, 224),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  borderSide: BorderSide.none,
                                                ),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 8.0.w,
                                                        horizontal: 20.0.w),
                                              ),
                                            ))),
                                  ],
                                ),
                              ),

                              // 历史
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 240, 240, 240),
                                  width: 1.0.w,
                                  style: BorderStyle.solid,
                                ))),
                                width: screenSize.width,
                                padding:
                                    EdgeInsets.only(left: 30.w, right: 30.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 标题
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("猜你想搜"),

                                        // 右边
                                        Container(
                                          width: 220.w,
                                          height: 70.w,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              // 换一换按钮
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    // 加盒子是为了扩大点击区域
                                                    color: Colors.transparent,
                                                    child: Icon(
                                                      const IconData(
                                                        0xe641,
                                                        fontFamily: 'Iconfont',
                                                      ), // 使用的图标
                                                      color:
                                                          Colors.black, // 图标颜色
                                                      size: 36.w, // 图标大小
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  const Text("换一换"),
                                                ],
                                              ),

                                              // 中线
                                              Container(
                                                color: const Color.fromARGB(
                                                    255, 223, 223, 223),
                                                height: 32.w,
                                                width: 2.w,
                                              ),

                                              // 三个点
                                              Container(
                                                // 加盒子是为了扩大点击区域
                                                color: Colors.transparent,
                                                child: Icon(
                                                  const IconData(
                                                    0xe657,
                                                    fontFamily: 'Iconfont',
                                                  ), // 使用的图标
                                                  color: Colors.black, // 图标颜色
                                                  size: 36.w, // 图标大小
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),

                                    Container(
                                      width: screenSize.width,
                                      child: Wrap(
                                        children: historyList.map((item) {
                                          return Container(
                                            width: 345.w, // 每个子组件的宽度
                                            height: 70.w, // 每个子组件的高度
                                            // color: Colors.blueAccent,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [Expanded(child: item)],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // 猜你想搜
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 240, 240, 240),
                                  width: 1.0.w,
                                  style: BorderStyle.solid,
                                ))),
                                width: screenSize.width,
                                padding:
                                    EdgeInsets.only(left: 30.w, right: 30.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 标题
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "猜你想搜",
                                          style: TextStyle(
                                              fontSize: 28.w,
                                              color: const Color.fromARGB(
                                                  255, 97, 97, 97)),
                                        ),

                                        // 右边
                                        Container(
                                          width: 220.w,
                                          height: 70.w,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              // 换一换按钮
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    // 加盒子是为了扩大点击区域
                                                    color: Colors.transparent,
                                                    child: Icon(
                                                      const IconData(
                                                        0xe641,
                                                        fontFamily: 'Iconfont',
                                                      ), // 使用的图标
                                                      color:
                                                          Colors.black, // 图标颜色
                                                      size: 36.w, // 图标大小
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  const Text("换一换"),
                                                ],
                                              ),

                                              // 中线
                                              Container(
                                                color: const Color.fromARGB(
                                                    255, 223, 223, 223),
                                                height: 32.w,
                                                width: 2.w,
                                              ),

                                              // 三个点
                                              Container(
                                                // 加盒子是为了扩大点击区域
                                                color: Colors.transparent,
                                                child: Icon(
                                                  const IconData(
                                                    0xe657,
                                                    fontFamily: 'Iconfont',
                                                  ), // 使用的图标
                                                  color: Colors.black, // 图标颜色
                                                  size: 36.w, // 图标大小
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),

                                    Container(
                                      width: screenSize.width,
                                      child: Wrap(
                                        children:
                                            suggestionsForYouList.map((item) {
                                          return Container(
                                            width: 345.w, // 每个子组件的宽度
                                            height: 70.w, // 每个子组件的高度
                                            // color: Colors.blueAccent,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [Expanded(child: item)],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // 热榜
                              ...hotList.map((e) {
                                return Container(
                                  height: 72.w,
                                  padding:
                                      EdgeInsets.only(left: 30.w, right: 30.w),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        const IconData(
                                          0xed9e,
                                          fontFamily: 'Iconfont',
                                        ), // 使用的图标
                                        color: Colors.black, // 图标颜色
                                        size: 36.w, // 图标大小
                                      ),
                                      SizedBox(
                                        width: 32.w,
                                      ),
                                      Expanded(
                                        // 使用 Expanded 限制文本区域
                                        child: e,
                                      ),
                                    ],
                                  ),
                                );
                              })
                            ],
                          )))));
        });
  }
}
