import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/screens/user/course/course_models.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';

// [更正] 类名已修正为 LJNCourseDetailPage
class LJNCourseDetailPage extends StatefulWidget {
  final String courseId;
  const LJNCourseDetailPage({super.key, required this.courseId});

  @override
  State<LJNCourseDetailPage> createState() => _LJNCourseDetailPageState();
}

// [更正] State 类名已修正
class _LJNCourseDetailPageState extends State<LJNCourseDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedUnit = 1;
  List<LessonItem> _lessons = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _fetchCourseData();
  }

  // 模拟网络请求，根据 courseId 获取数据
  void _fetchCourseData() {
    // 实际项目中，这里会是一个异步的网络请求
    // Future.delayed(Duration(milliseconds: 500), () { ... });

    // 模拟：如果 courseId 是普林斯顿的，就返回比特币课程数据
    if (widget.courseId == "course_btc_princeton") {
      setState(() {
        _lessons = [
          LessonItem(
            id: "btc_01",
            title: "课程信息",
            type: LessonType.reading,
            status: LessonStatus.completed,
            duration: "10 分钟",
          ),
          LessonItem(
            id: "btc_02",
            title: "欢迎",
            type: LessonType.video,
            status: LessonStatus.completed,
            duration: "2 分钟",
          ),
          LessonItem(
            id: "btc_03",
            title: "加密哈希函数",
            type: LessonType.video,
            status: LessonStatus.completed,
            duration: "19 分钟",
          ),
          LessonItem(
            id: "btc_04",
            title: "哈希指针和数据结构",
            type: LessonType.video,
            status: LessonStatus.pending,
            duration: "9 分钟",
          ),
          LessonItem(
            id: "btc_05",
            title: "数字签名",
            type: LessonType.video,
            status: LessonStatus.pending,
            duration: "10 分钟",
          ),
          LessonItem(
            id: "btc_06",
            title: "守财奴硬币",
            type: LessonType.assignment,
            status: LessonStatus.overdue,
            duration: "3 小时",
            dueDateInfo: "已于5月3日 逾期",
          ),
          LessonItem(
            id: "btc_07",
            title: "区块链基础",
            type: LessonType.reading,
            status: LessonStatus.locked,
            duration: "25 分钟",
          ),
        ];
        _isLoading = false;
      });
    } else {
      // 模拟其他课程的数据或空状态
      setState(() {
        _lessons = [];
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  double customkToolbarHeight = 95.w;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return Scaffold(
        primary: false,
        appBar: LJNAppBar(
          title: "课程详情",
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    PreferredSize(
                      preferredSize:
                          Size.fromHeight(customkToolbarHeight + 2.5.w),
                      child: Container(
                        // 背景色确保 TabBar 在固定时有不透明的背景
                        color: theme.cardColor,
                        child: TabBar(
                          controller: _tabController,
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          labelStyle: TextStyle(
                            fontSize: 28.w,
                            fontWeight: FontWeight.bold,
                          ),
                          unselectedLabelStyle: TextStyle(fontSize: 28.w),
                          tabs: const [
                            Tab(text: "主页"),
                            Tab(text: "成绩"),
                            Tab(text: "论坛"),
                            Tab(text: "注意事项"),
                            Tab(text: "资源"),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ];
          },
          body: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : TabBarView(
                  controller: _tabController,
                  children: [
                    ColoredBox(
                      color: theme.cardColor,
                      child: ListView(
                        padding: EdgeInsets.all(20.w),
                        children: [
                          _buildUnitSelector(theme),
                          SizedBox(height: 40.w),
                          _buildDeadlineCard(theme),
                          SizedBox(height: 40.w),
                          _buildDailyGoalCard(theme),
                          SizedBox(height: 40.w),
                          _buildSectionIntro(theme),
                          SizedBox(height: 20.w),
                          ..._lessons.map((lesson) =>
                              _buildLessonCard(context, lesson, theme)),
                        ],
                      ),
                    ),
                    ColoredBox(
                      color: theme.cardColor,
                      child: const Center(
                        child: Text("成绩"),
                      ),
                    ),
                    ColoredBox(
                      color: theme.cardColor,
                      child: const Center(
                        child: Text("论坛"),
                      ),
                    ),
                    ColoredBox(
                      color: theme.cardColor,
                      child: const Center(
                        child: Text("注意事项"),
                      ),
                    ),
                    ColoredBox(
                      color: theme.cardColor,
                      child: const Center(
                        child: Text("资源"),
                      ),
                    ),
                  ],
                ),
        ),
      );
    });
  }

  Widget _buildLessonCard(
      BuildContext context, LessonItem lesson, ThemeData theme) {
    bool isLocked = lesson.status == LessonStatus.locked;
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(
        bottom: 20.w,
        left: 0,
        right: 0,
        top: 0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.w),
        side: BorderSide(color: theme.dividerColor, width: 1.5),
      ),
      child: InkWell(
        onTap: isLocked
            ? null
            : () {
                // 适配您的路由逻辑
                Navigator.pushNamed(
                  context,
                  '/user/lesson_content',
                  arguments: {'lesson_id': lesson.id},
                );
              },
        borderRadius: BorderRadius.circular(20.w),
        child: Padding(
          padding: EdgeInsets.all(30.w),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      style: TextStyle(
                        fontSize: 30.w,
                        fontWeight: FontWeight.bold,
                        color: isLocked
                            ? theme.hintColor
                            : theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    SizedBox(height: 20.w),
                    Wrap(
                      spacing: 16.w,
                      runSpacing: 16.w,
                      children: [
                        _buildLessonTag(lesson, theme),
                        _buildLessonTag(lesson, theme, isDuration: true),
                        if (lesson.dueDateInfo != null)
                          _buildLessonTag(lesson, theme, isDueDate: true),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(width: 20.w),
              Icon(Icons.download_for_offline_outlined, color: theme.hintColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUnitSelector(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "单元",
          style: TextStyle(
            fontSize: 30.w,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20.w),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(8, (index) {
              final unitNumber = index + 1;
              final isSelected = _selectedUnit == unitNumber;
              return GestureDetector(
                onTap: () => setState(() => _selectedUnit = unitNumber),
                child: Container(
                  width: 100.w,
                  height: 100.w,
                  margin: EdgeInsets.only(right: 20.w),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? theme.textTheme.bodyLarge?.color
                        : theme.cardColor,
                    borderRadius: BorderRadius.circular(50.w),
                    border: isSelected
                        ? null
                        : Border.all(color: theme.dividerColor),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isSelected)
                          Icon(
                            Icons.nightlight_round,
                            color: theme.scaffoldBackgroundColor,
                            size: 30.w,
                          ),
                        Text(
                          unitNumber.toString(),
                          style: TextStyle(
                            color: isSelected
                                ? theme.scaffoldBackgroundColor
                                : theme.textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 32.w,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildDeadlineCard(ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(30.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.redAccent, width: 1.5),
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Column(
        children: [
          Text(
            "不要让您学到的重要内容消失！每周重置您的截止日期并完成您的作业。",
            style: TextStyle(
              fontSize: 26.w,
              height: 1.5,
            ),
          ),
          SizedBox(height: 20.w),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
            label: const Text("重置我的截止日期"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 80.w),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.w)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDailyGoalCard(ThemeData theme) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.w),
        side: BorderSide(color: theme.dividerColor, width: 1.5),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "每日目标",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.w,
              ),
            ),
            SizedBox(height: 10.w),
            Row(
              children: [
                Checkbox(value: false, onChanged: (val) {}),
                const Expanded(child: Text("完成所有 3 课程视频、阅读材料或测验")),
                SizedBox(width: 20.w),
                Text("0/3", style: TextStyle(color: theme.hintColor)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionIntro(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("加密货币和加密货币简介",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36.w)),
        SizedBox(height: 20.w),
        Text("了解密码构件（“基元”）并推理其安全性。了解如何使用这些基元构建简单的加密货币。",
            style:
                TextStyle(color: theme.hintColor, fontSize: 28.w, height: 1.5)),
        SizedBox(height: 30.w),
        const Divider(),
        SizedBox(height: 10.w),
        Text("加密货币和加密货币简介",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.w)),
      ],
    );
  }

  Widget _buildLessonTag(LessonItem lesson, ThemeData theme,
      {bool isDuration = false, bool isDueDate = false}) {
    bool isCompleted = lesson.status == LessonStatus.completed;
    IconData? icon;
    String text;
    Color color;

    if (isDuration) {
      text = lesson.duration;
      color = theme.hintColor;
    } else if (isDueDate) {
      text = lesson.dueDateInfo!;
      color = theme.hintColor;
    } else {
      icon = isCompleted ? Icons.check_circle_outline_rounded : lesson.iconData;
      text = lesson.typeText;
      color = isCompleted
          ? Colors.green.shade700
          : (lesson.status == LessonStatus.locked
              ? theme.hintColor
              : theme.primaryColor);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.w),
        border: Border.all(
            color: isCompleted && !isDuration && !isDueDate
                ? color
                : theme.dividerColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon, size: 28.w, color: color),
          if (icon != null) SizedBox(width: 8.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 24.w,
              fontWeight: FontWeight.w500,
              color: isCompleted && !isDuration && !isDueDate
                  ? color
                  : theme.textTheme.bodyMedium?.color,
            ),
          )
        ],
      ),
    );
  }
}
