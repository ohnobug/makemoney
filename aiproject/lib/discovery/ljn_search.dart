import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spicychat/tools/ljn_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';

class LJNSearch extends StatefulWidget {
  const LJNSearch({super.key});

  @override
  State<LJNSearch> createState() => _LJNSearch();
}

class _LJNSearch extends State<LJNSearch> {
  List<Widget> historyList = [];
  List<Widget> suggestionsForYouList = [];
  List<Widget> hotList = [];

  PageController pageController = PageController();
  double pageControllerOffset = 0;

  // 搜索历史key, 为了获取高度
  GlobalKey historyKey = GlobalKey();
  double historyHeight = 0;

  // 最后点击的标题
  int lastedTapHotTitleKey = -1;

  // 热门标题
  int hotListCurrentPage = 0;
  PageController hotListController = PageController();
  List<String> hotListTitles = [];
  GlobalKey hotTitleBoxKey = GlobalKey();
  ScrollController hotTitleBoxController = ScrollController();
  final Map<int, GlobalKey> hotListTitlesKeys = {};

  double hotTitleBoxTop = 0;

  @override
  void initState() {
    super.initState();

    // 历史
    historyList.addAll([
      Text(
        style: TextStyle(fontSize: 32.w, height: 1.08),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        "俄公开恐怖分子被捕的画面",
      ),
      Text(
        style: TextStyle(fontSize: 32.w, height: 1.08),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        "微软宣布将终止对Windows10的支持",
      ),
      Text(
        style: TextStyle(fontSize: 32.w, height: 1.08),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        "唐尚珺是弱智的吗 考了那么多次高考",
      ),
      Text(
        style: TextStyle(fontSize: 32.w, height: 1.08),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        "美国大选最新消息",
      ),
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

    // 抖音热榜标题
    hotListTitles = [
      "抖音热榜",
      "同城榜",
      "直播榜",
      "团购榜",
      "品牌榜",
      "音乐榜",
      "科技榜",
      "汽车榜",
      "傻逼榜",
      "富人榜",
      "恶搞榜",
      "恐怖榜",
      "儿童榜",
      "好人榜",
      "恶人榜",
      "摇滚榜",
      "电影榜",
      "电视剧榜"
    ];

    hotListTitles.asMap().entries.forEach((v) {
      hotListTitlesKeys[v.key] = GlobalKey();
    });

    // 热榜
    hotList.addAll([
      Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "上海世茂等被强制执行17.6亿",
              style: TextStyle(fontSize: 32.w, height: 1.08),
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Transform.translate(
                offset: Offset(0, ((32.w - 30.w) / 2) * -1),
                child: SizedBox(
                  width: 30.w * 1.2,
                  height: 30.w * 1.2,
                  // color: Colors.red,
                  child: Center(
                    child: Icon(
                      const IconData(
                        0xe71e,
                        fontFamily: 'Iconfont',
                      ), // 使用的图标
                      color: const Color.fromARGB(255, 255, 0, 0), // 图标颜色
                      size: 30.w, // 图标大小
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
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

    // 页面滚动监听
    pageController.addListener(() {
      logger.info("pageController.offset: ${pageController.offset}");
      setState(() {
        pageControllerOffset = pageController.offset;
      });
    });

    // 确保在布局完成后获取高度
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final historyKeyContext = historyKey.currentContext;
      if (historyKeyContext != null) {
        final renderBox = historyKeyContext.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          setState(() {
            historyHeight = renderBox.size.height;
            logger.info("historyHeight: $historyHeight");
          });
        }
      }
    });
  }

  // 判断盒子是否在显示, 若不显示则显示都可视区域
  bool isItemVisibleAndMove(int index) {
    final GlobalKey? itemKey = hotListTitlesKeys[index];
    final GlobalKey? firstKey = hotListTitlesKeys[0];
    if (itemKey != null && firstKey != null) {
      // 父元素
      final RenderBox? parentRenderBox =
          hotTitleBoxKey.currentContext?.findRenderObject() as RenderBox?;

      // 子元素
      final RenderBox? childRenderBox =
          itemKey.currentContext?.findRenderObject() as RenderBox?;

      // 第一个元素
      final RenderBox? firstRenderBox =
          firstKey.currentContext?.findRenderObject() as RenderBox?;

      if (parentRenderBox != null &&
          childRenderBox != null &&
          firstRenderBox != null) {
        final parentPosition = parentRenderBox.localToGlobal(Offset.zero);
        final childPosition = childRenderBox.localToGlobal(Offset.zero);
        final firstPosition = firstRenderBox.localToGlobal(Offset.zero);

        // 子元素相对于父元素的坐标
        final Offset childParentRelativePosition =
            childPosition - parentPosition;

        // 子元素相对于第一个元素的坐标
        final Offset childFirstRelativePosition = childPosition - firstPosition;

        logger.info("parentPosition:$parentPosition");
        logger.info("childPosition:$childPosition");
        logger.info("childParentRelativePosition:$childParentRelativePosition");

        if (childParentRelativePosition.dx - (childRenderBox.size.width * 0.5) <
            0) {
          // logger.info("子元素在盒子左边, 向右边移动");
          // 子元素在盒子左边, 向右边移动
          hotTitleBoxController.animateTo(
              childFirstRelativePosition.dx - childRenderBox.size.width,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear);
        } else if ((childParentRelativePosition.dx +
                childRenderBox.size.width * 1.5) >
            parentRenderBox.size.width) {
          // logger.info("子元素在盒子右边, 向左边移动");
          // 子元素在盒子右边, 向左边移动
          hotTitleBoxController.animateTo(
              childFirstRelativePosition.dx -
                  parentRenderBox.size.width +
                  childRenderBox.size.width * 2,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear);
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      logger.info("pageControllerOffset $pageControllerOffset");

      double mytop = 0;
      if (pageControllerOffset > historyHeight) {
        mytop = -1.w;
      } else {
        mytop = historyHeight - pageControllerOffset;
      }

      return Scaffold(
        primary: false,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90.0.w + systemState.statusHeight),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.w),
            margin: EdgeInsets.only(top: systemState.statusHeight),
            height: 90.w,
            color: Colors.white, // 设置背景颜色
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 返回按钮
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(), // 点击事件
                  child: Container(
                    // 加盒子是为了扩大点击区域
                    color: Colors.transparent,
                    child: Icon(
                      const IconData(
                        0xed9e,
                        fontFamily: 'Iconfont',
                      ), // 使用的图标
                      color: const Color.fromARGB(255, 99, 99, 99), // 图标颜色
                      size: 36.w, // 图标大小
                    ),
                  ),
                ),

                // 搜索框
                Expanded(
                  flex: 1,
                  child: Container(
                    // color: Colors.blue,
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    height: 65.w,
                    child: TextField(
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
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
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 70.w, // 控制图标与文字的最小宽度
                          // minHeight: 36.w,
                        ),
                        hintText: "搜索",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 30.w,
                          color: const Color.fromARGB(255, 69, 75, 83),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 233, 234, 236),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 8.0.w, horizontal: 20.0.w),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                primary: false,
                controller: pageController,
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(
                  children: [
                    // 历史 与 猜你想搜
                    Column(
                      key: historyKey,
                      children: [
                        // 历史
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: const Color.fromARGB(255, 240, 240, 240),
                                width: 1.0.w,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                              left: 30.w, right: 30.w, bottom: 10.w, top: 10.w),
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
                                      height: 1.08,
                                      fontSize: 28.w,
                                      color:
                                          const Color.fromARGB(255, 64, 64, 64),
                                    ),
                                  ),

                                  // 右边
                                  SizedBox(
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
                                              MainAxisAlignment.spaceBetween,
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
                                                color: const Color.fromARGB(
                                                    255, 64, 64, 64), // 图标颜色
                                                size: 28.w, // 图标大小
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              "换一换",
                                              style: TextStyle(
                                                  color: const Color.fromARGB(
                                                      255, 64, 64, 64),
                                                  fontSize: 28.w,
                                                  height: 1.08),
                                            ),
                                          ],
                                        ),

                                        // 中线
                                        Container(
                                          color: const Color.fromARGB(
                                              255, 223, 223, 223),
                                          height: 24.w,
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
                                            color: const Color.fromARGB(
                                                255, 64, 64, 64), // 图标颜色
                                            size: 28.w, // 图标大小
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),

                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Wrap(
                                  children: historyList.map((item) {
                                    return SizedBox(
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
                                color: const Color.fromARGB(255, 240, 240, 240),
                                width: 1.0.w,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                              left: 30.w, right: 30.w, bottom: 10.w, top: 10.w),
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
                                      height: 1.08,
                                      fontSize: 28.w,
                                      color:
                                          const Color.fromARGB(255, 64, 64, 64),
                                    ),
                                  ),

                                  // 右边
                                  SizedBox(
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
                                              MainAxisAlignment.spaceBetween,
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
                                                color: const Color.fromARGB(
                                                    255, 64, 64, 64), // 图标颜色
                                                size: 28.w, // 图标大小
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              "换一换",
                                              style: TextStyle(
                                                  color: const Color.fromARGB(
                                                      255, 64, 64, 64),
                                                  fontSize: 28.w,
                                                  height: 1.08),
                                            ),
                                          ],
                                        ),

                                        // 中线
                                        Container(
                                          color: const Color.fromARGB(
                                              255, 223, 223, 223),
                                          height: 24.w,
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
                                            color: const Color.fromARGB(
                                                255, 64, 64, 64), // 图标颜色
                                            size: 28.w, // 图标大小
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),

                              // 标题列表
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Wrap(
                                  children: suggestionsForYouList.map((item) {
                                    return SizedBox(
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
                      ],
                    ),

                    SizedBox(
                      height: 110.w,
                    ),

                    // 热榜
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: (hotList.length * (72.w + 15.w) + 90.w),
                      child: PageView(
                        scrollDirection: Axis.horizontal,
                        controller: hotListController,
                        onPageChanged: (index) {
                          setState(() {
                            hotListCurrentPage = index;

                            if (lastedTapHotTitleKey == -1) {
                              isItemVisibleAndMove(index);
                            }
                          });
                        },
                        children: [
                          ...hotListTitles.asMap().entries.map((_) {
                            return hotListWidget(hotList);
                          })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 占位
            Positioned(
              left: 0,
              top: mytop,
              child: Container(
                color: Colors.white,
                key: hotTitleBoxKey,
                alignment: Alignment.center,
                height: 110.w,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  controller: hotTitleBoxController,
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...hotListTitles.asMap().entries.map((e) {
                        return GestureDetector(
                          onTap: () {
                            logger.info("用户点击了${e.key}");

                            lastedTapHotTitleKey = e.key;

                            // 页面滚动
                            hotListController
                                .animateToPage(e.key,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.linear)
                                .then((_) {
                              logger.info("热榜滚动完成");
                              setState(() {
                                lastedTapHotTitleKey = -1;

                                // 意外中断时, 使标题移动到正确的位置
                                int pageIndex = hotListController.page!.toInt();
                                isItemVisibleAndMove(pageIndex);
                              });
                            });
                          },
                          child: hotListTitleBuild(hotListTitlesKeys[e.key]!,
                              e.value, hotListCurrentPage == e.key),
                        );
                      })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget hotListWidget(List<Widget> hotList) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return Container(
        // height: 4350.w + 90.w,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          children: [
            ...hotList.asMap().entries.map(
              (e) {
                return Container(
                  height: 72.w,
                  decoration: BoxDecoration(
                    // color: e.key < 3
                    //     ? const Color.fromARGB(255, 253, 245, 242)
                    //     : const Color.fromARGB(255, 231, 231, 231),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.w),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft, // 渐变开始点
                      end: Alignment.centerRight, // 渐变结束点
                      colors: [
                        e.key < 3
                            ? const Color.fromARGB(255, 253, 245, 242)
                            : const Color.fromARGB(255, 245, 245, 245), // 起始颜色
                        Colors.white, // 结束颜色
                      ],
                    ),
                  ),
                  padding: EdgeInsets.only(left: 24.w, right: 24.w),
                  margin: EdgeInsets.only(bottom: 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 图标
                      SizedBox(
                        height: 37.w,
                        width: 37.w,
                        child: Stack(
                          children: [
                            // 排序
                            if (e.key < 3) ...[
                              Icon(
                                const IconData(
                                  0xe649,
                                  fontFamily: 'Iconfont',
                                ), // 使用的图标
                                color: const Color.fromARGB(
                                    255, 247, 171, 66), // 图标颜色
                                size: 37.w, // 图标大小
                              ),
                              Center(
                                child: Text(
                                  (e.key + 1).toString(),
                                  style: TextStyle(
                                      fontSize: 24.w,
                                      height: 1.08,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white),
                                ),
                              )
                            ] else
                              Center(
                                child: Text(
                                  (e.key + 1).toString(),
                                  style: TextStyle(
                                    fontSize: 28.w,
                                    height: 1.08,
                                    fontWeight: FontWeight.bold,
                                    // fontStyle: FontStyle.italic,
                                    color: const Color.fromARGB(
                                        255, 143, 143, 143),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),

                      // 标题
                      Expanded(
                        // 使用 Expanded 限制文本区域
                        child: e.value,
                      ),

                      // 阅读人数
                      Text(
                        "1201.2万",
                        style: TextStyle(
                          fontSize: 25.w,
                          color: const Color.fromARGB(255, 157, 143, 145),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 90.w,
              child: const Center(
                child: Text(
                  "查看完整榜单",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  // 热榜标题
  Widget hotListTitleBuild(GlobalKey key, String title, bool selected) {
    return Container(
      key: key,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Text(
        title,
        style: TextStyle(
          height: 1.08,
          fontSize: selected ? 32.w : 30.w,
          fontFamily: "AlibabaPuHuiTi-Medium",
          color: selected ? const Color(0xFF151515) : const Color(0xFF747474),
        ),
      ),
    );
  }
}
