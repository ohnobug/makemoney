// 文件路径: /lib/screens/user/settings/ljn_help_and_feedback.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_function_button.dart';
import 'package:vigaviga/widgets/ljn_function_buttons_section.dart';
import 'package:vigaviga/widgets/ljn_section_header.dart';

class LJNHelpAndFeedbackPage extends StatefulWidget {
  const LJNHelpAndFeedbackPage({super.key});

  @override
  State<LJNHelpAndFeedbackPage> createState() => _LJNHelpAndFeedbackPageState();
}

class _LJNHelpAndFeedbackPageState extends State<LJNHelpAndFeedbackPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // 数据列表
  final List<String> hotQuestions = [
    '笔记审核时效是多久',
    '视频互动栏怎么切换到底部？',
    '如何开通直播权限？',
    '笔记被判定违反社区规范第四条是什么意思？',
    '如何变更或解绑小红书的实名认证？',
    '如何找回小红书账号？',
    '如何开通买手权限为他人带货？',
    '小红书开店的费用是多少？',
    '商家一直不发货怎么办？',
    '如何修改、新增、删除收货地址？',
  ];

  final List<String> accountQuestions = [
    '如何修改密码？',
    '账号被盗了怎么办？',
    '怎么注销账号？',
    '如何绑定手机号？',
    '如何解除绑定手机号？',
  ];

  final List<String> profileQuestions = [
    '个人主页可以设置什么？',
    '如何更换头像？',
    '怎么修改昵称？',
    '怎么修改简介？',
  ];

  final List<String> trafficQuestions = [
    '如何增加笔记曝光？',
    '为什么我的笔记没有流量？',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 动态计算列表容器的高度，使其更易于维护
    // 每个列表项的高度 * 显示的数量
    final double listItemHeight = 90.w; // 定义每个列表项的高度
    final int itemsToShow = 5; // 定义每个Tab页显示的数量
    final double listContainerHeight = listItemHeight * itemsToShow;
    ThemeData theme = Theme.of(context);

    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      String cdnBase = systemState.cdnBase;

      return Scaffold(
        backgroundColor: const Color(0xFFF8F8F8), // 统一页面背景色
        primary: false,
        appBar: LJNAppBar(
          title: "帮助与反馈",
        ),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  systemState.appbarHeight -
                  systemState.statusHeight,
            ),
            color: theme.colorScheme.surfaceContainer,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Column(
                children: [
                  SizedBox(height: 30.w),
                  // 自助工具区域
                  LJNSectionHeader(title: "自助工具", showMore: false),
                  SizedBox(height: 10.w),
                  LJNFunctionButtonsSection(
                    buttons: [
                      LJNFunctionButton(
                        icon: "$cdnBase/miniprogram_icon/tiankongyueduqi.jpg",
                        title: '账号检测',
                        onPressed: () {},
                      ),
                      LJNFunctionButton(
                        icon: "$cdnBase/miniprogram_icon/tiankongyueduqi.jpg",
                        title: '笔记申诉',
                        onPressed: () {},
                      ),
                      LJNFunctionButton(
                        icon: "$cdnBase/miniprogram_icon/tiankongyueduqi.jpg",
                        title: '开通店铺',
                        onPressed: () {},
                      ),
                      LJNFunctionButton(
                        icon: "$cdnBase/miniprogram_icon/tiankongyueduqi.jpg",
                        title: '售后退款',
                        onPressed: () {},
                      ),
                      LJNFunctionButton(
                        icon: "$cdnBase/miniprogram_icon/tiankongyueduqi.jpg",
                        title: '券和福利',
                        onPressed: () {},
                      ),
                      LJNFunctionButton(
                        icon: "$cdnBase/miniprogram_icon/tiankongyueduqi.jpg",
                        title: '找回账号',
                        onPressed: () {},
                      ),
                      LJNFunctionButton(
                        icon: "$cdnBase/miniprogram_icon/tiankongyueduqi.jpg",
                        title: '账号与安全',
                        onPressed: () {},
                      ),
                      LJNFunctionButton(
                        icon: "$cdnBase/miniprogram_icon/tiankongyueduqi.jpg",
                        title: '查看物流',
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 40.w),

                  // 猜你想问区域
                  LJNSectionHeader(title: "猜你想问", showMore: false),
                  SizedBox(height: 20.w),

                  // 【核心修复】使用 Material 组件代替 Container，以支持水波纹效果
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.w),
                      clipBehavior: Clip.antiAlias, // 确保内容和效果不会超出圆角
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TabBar(
                            controller: _tabController,
                            tabAlignment: TabAlignment.start,
                            isScrollable: true,
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            labelStyle: TextStyle(
                              fontSize: 28.w,
                              fontWeight: FontWeight.bold,
                            ),
                            unselectedLabelStyle: TextStyle(
                              fontSize: 28.w,
                            ),
                            indicatorSize: TabBarIndicatorSize.label,
                            tabs: const [
                              Tab(text: '热门问题'),
                              Tab(text: '帐号问题'),
                              Tab(text: '个人主页问题'),
                              Tab(text: '流量问题'),
                            ],
                          ),
                          SizedBox(
                            height: listContainerHeight, // 使用动态计算的高度
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                _buildQuestionListView(
                                  hotQuestions.take(itemsToShow).toList(),
                                  listItemHeight,
                                  theme,
                                ),
                                _buildQuestionListView(
                                  accountQuestions.take(itemsToShow).toList(),
                                  listItemHeight,
                                  theme,
                                ),
                                _buildQuestionListView(
                                  profileQuestions.take(itemsToShow).toList(),
                                  listItemHeight,
                                  theme,
                                ),
                                _buildQuestionListView(
                                  trafficQuestions.take(itemsToShow).toList(),
                                  listItemHeight,
                                  theme,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.w), // 增加底部间距
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      );
    });
  }

// 辅助方法：构建问题列表
  Widget _buildQuestionListView(
      List<String> questions, double itemHeight, ThemeData theme) {
    return Column(
      children: questions.map((question) {
        // 使用 SizedBox 来约束高度
        return SizedBox(
          height: itemHeight,
          // 使用 InkWell 来提供水波纹效果和点击事件，它会填满整个 SizedBox
          child: InkWell(
            onTap: () {
              logger.info('$question was tapped!');
            },
            child: Padding(
              // 设置左右内边距
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              // 使用 Row 来水平布局
              child: Row(
                // 【核心】让 Row 的子组件在交叉轴（垂直方向）上居中
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 使用 Expanded 让 Text 占据所有剩余空间
                  Expanded(
                    child: Text(
                      question,
                      style: TextStyle(
                        fontSize: 30.w,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // 右侧的箭头图标
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 24.w,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // 辅助方法：构建底部导航栏
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey[200]!,
            width: 1.w,
          ),
        ),
      ),
      padding: EdgeInsets.only(bottom: ScreenUtil().bottomBarHeight),
      height: 100.w + ScreenUtil().bottomBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Center(
                child: Text(
                  '意见反馈',
                  style: TextStyle(
                    fontSize: 30.w,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 1.w,
            height: 40.w, // 适当增加分隔线高度
            color: Colors.grey[300],
          ),
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.headset_mic_outlined,
                    color: Colors.black87,
                    size: 30.w,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    '联系官方客服',
                    style: TextStyle(
                      fontSize: 30.w,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
