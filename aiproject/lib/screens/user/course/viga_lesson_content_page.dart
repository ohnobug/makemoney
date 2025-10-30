import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/screens/user/course/course_models.dart';

// [更正] 类名已修正为 VigaLessonContentPage
class VigaLessonContentPage extends StatefulWidget {
  final String lessonId;
  const VigaLessonContentPage({super.key, required this.lessonId});

  @override
  State<VigaLessonContentPage> createState() => _VigaLessonContentPageState();
}

// [更正] State 类名已修正
class _VigaLessonContentPageState extends State<VigaLessonContentPage> {
  LessonItem? _lesson;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLessonData();
  }

  // 模拟网络请求，根据 lesson_id 获取具体内容
  void _fetchLessonData() {
    // 实际项目中，这里会是一个异步的网络请求
    // 这是一个模拟的数据源，你需要替换成你的 API 调用
    final allLessons = [
      LessonItem(
          id: "btc_01",
          title: "课程信息",
          type: LessonType.reading,
          status: LessonStatus.completed,
          duration: "10 分钟",
          contentTitle: "第一章：什么是加密货币？",
          contentDescription:
              "加密货币（Cryptocurrency）是一种使用密码学原理来确保交易安全及控制交易单位创造的交易媒介..."),
      LessonItem(
          id: "btc_02",
          title: "欢迎",
          type: LessonType.video,
          status: LessonStatus.completed,
          duration: "2 分钟",
          contentTitle: "欢迎来到比特币课程",
          contentDescription: "在本课程中，我们将探索激动人心的数字货币世界..."),
      LessonItem(
          id: "btc_06",
          title: "守财奴硬币",
          type: LessonType.assignment,
          status: LessonStatus.overdue,
          duration: "3 小时",
          contentTitle: "编程作业 #1: 创建你自己的货币",
          contentDescription: "请根据课程所学知识，实现一个简单的 GoofyCoin..."),
    ];

    try {
      final lesson =
          allLessons.firstWhere((item) => item.id == widget.lessonId);
      setState(() {
        _lesson = lesson;
        _isLoading = false;
      });
    } catch (e) {
      // 处理找不到 lesson 的情况
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_lesson?.title ?? "加载中..."),
        elevation: 0.5,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _lesson == null
              ? const Center(child: Text("无法加载课程内容"))
              : SingleChildScrollView(
                  padding: EdgeInsets.all(30.w),
                  child: _buildContent(_lesson!),
                ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildContent(LessonItem lesson) {
    switch (lesson.type) {
      case LessonType.video:
        return _buildVideoContent(lesson);
      case LessonType.reading:
        return _buildReadingContent(lesson);
      case LessonType.assignment:
        return _buildAssignmentContent(lesson);
      case LessonType.quiz:
        return _buildQuizContent(lesson);
    }
  }

  Widget _buildVideoContent(LessonItem lesson) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            color: Colors.black,
            child: Center(
                child: Icon(Icons.play_circle_fill,
                    color: Colors.white, size: 100.w)),
          ),
        ),
        SizedBox(height: 40.w),
        Text(lesson.contentTitle,
            style: TextStyle(fontSize: 36.w, fontWeight: FontWeight.bold)),
        SizedBox(height: 20.w),
        Text(lesson.contentDescription,
            style:
                TextStyle(fontSize: 28.w, height: 1.6, color: Colors.black87)),
        const Divider(height: 60),
        Text("课程讲义",
            style: TextStyle(fontSize: 32.w, fontWeight: FontWeight.bold)),
        SizedBox(height: 20.w),
        ListTile(
          leading: const Icon(Icons.picture_as_pdf_rounded),
          title: const Text("lesson_1_slides.pdf"),
          trailing: const Icon(Icons.download_for_offline_outlined),
          onTap: () {},
        )
      ],
    );
  }

  Widget _buildReadingContent(LessonItem lesson) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(lesson.contentTitle,
            style: TextStyle(
                fontSize: 44.w, fontWeight: FontWeight.bold, height: 1.4)),
        SizedBox(height: 10.w),
        Text("作者：Arvind Narayanan",
            style: TextStyle(color: Colors.grey.shade600)),
        const Divider(height: 60),
        Text(lesson.contentDescription,
            style:
                TextStyle(fontSize: 30.w, height: 1.8, color: Colors.black87)),
      ],
    );
  }

  Widget _buildAssignmentContent(LessonItem lesson) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(lesson.contentTitle,
            style: TextStyle(fontSize: 40.w, fontWeight: FontWeight.bold)),
        const Divider(height: 60),
        Text("说明",
            style: TextStyle(fontSize: 32.w, fontWeight: FontWeight.bold)),
        SizedBox(height: 15.w),
        Text(lesson.contentDescription,
            style: TextStyle(fontSize: 28.w, height: 1.6)),
        SizedBox(height: 30.w),
        Text("提交",
            style: TextStyle(fontSize: 32.w, fontWeight: FontWeight.bold)),
        SizedBox(height: 20.w),
        OutlinedButton.icon(
            icon: const Icon(Icons.upload_file),
            label: const Text("上传你的代码"),
            onPressed: () {},
            style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 90.w)))
      ],
    );
  }

  Widget _buildQuizContent(LessonItem lesson) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(lesson.title,
            style: TextStyle(fontSize: 40.w, fontWeight: FontWeight.bold)),
        SizedBox(height: 10.w),
        Text("共 10 题，限时 60 分钟", style: TextStyle(color: Colors.grey.shade600)),
        const Divider(height: 60),
        Text("准备好后，请点击下方按钮开始测验。", style: TextStyle(fontSize: 28.w)),
        SizedBox(height: 40.w),
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 90.w)),
            child: const Text("开始测验"))
      ],
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomAppBar(
      elevation: 4,
      child: SizedBox(
        height: 100.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.arrow_back_ios_new),
              label: const Text("上一节"),
              onPressed: () {},
            ),
            TextButton.icon(
              label: const Text("下一节"),
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
