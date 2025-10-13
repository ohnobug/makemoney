// /lib/screens/user/settings/ljn_help_and_feedback.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/widgets/ljn_appbar_inner.dart';
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
    '如何解除绑定手机号？',
  ];

  final List<String> profileQuestions = [
    '个人主页可以设置什么？',
    '如何更换头像？',
    '怎么修改昵称？',
    '怎么修改简介？',
    '怎么修改主页？',
  ];

  final List<String> trafficQuestions = [
    '如何增加笔记曝光？',
    '为什么我的笔记没有流量？',
    '为什么我的笔记没有流量？',
    '为什么我的笔记没有流量？',
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
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: LJNAppBarInner(context: context, title: '帮助与客服'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 0.w),
            LJNSectionHeader(title: "猜你想问", showMore: false),
            LJNFunctionButtonsSection(
              buttons: [
                LJNFunctionButton(
                  icon: "images/miniprogram_icon/tiankongyueduqi.jpg",
                  title: '账号检测',
                  onPressed: () {},
                ),
                LJNFunctionButton(
                  icon: "images/miniprogram_icon/tiankongyueduqi.jpg",
                  title: '笔记申诉',
                  onPressed: () {},
                ),
                LJNFunctionButton(
                  icon: "images/miniprogram_icon/tiankongyueduqi.jpg",
                  title: '开通店铺',
                  onPressed: () {},
                ),
                LJNFunctionButton(
                  icon: "images/miniprogram_icon/tiankongyueduqi.jpg",
                  title: '售后退款',
                  onPressed: () {},
                ),
                LJNFunctionButton(
                  icon: "images/miniprogram_icon/tiankongyueduqi.jpg",
                  title: '券和福利',
                  onPressed: () {},
                ),
                LJNFunctionButton(
                  icon: "images/miniprogram_icon/tiankongyueduqi.jpg",
                  title: '找回账号',
                  onPressed: () {},
                ),
                LJNFunctionButton(
                  icon: "images/miniprogram_icon/tiankongyueduqi.jpg",
                  title: '账号与安全',
                  onPressed: () {},
                ),
                LJNFunctionButton(
                  icon: "images/miniprogram_icon/tiankongyueduqi.jpg",
                  title: '查看物流',
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 40.w),
            LJNSectionHeader(title: "猜你想问", showMore: false),
            SizedBox(height: 20.w),
            Container(
              padding: EdgeInsets.only(bottom: 6.w),
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.w),
              ),
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
                    height: 400.w,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildQuestionListView(hotQuestions.take(5).toList()),
                        _buildQuestionListView(
                            accountQuestions.take(5).toList()),
                        _buildQuestionListView(
                            profileQuestions.take(5).toList()),
                        _buildQuestionListView(
                            trafficQuestions.take(5).toList()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.w),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // 辅助方法：构建问题列表
  Widget _buildQuestionListView(List<String> questions) {
    return Column(
      children: questions.map((question) {
        return SizedBox(
            height: 80.w,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
              title: Text(
                question,
                style: TextStyle(
                  fontSize: 30.w,
                  color: Colors.black87,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 24.w,
                color: Colors.grey[400],
              ),
              onTap: () {
                logger.info('$question was tapped!');
              },
            ));
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
            height: 24.w,
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
                  SizedBox(width: 6.w),
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
