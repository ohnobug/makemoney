import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/screens/user/course/course_models.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';

class LJNCourseListPage extends StatefulWidget {
  const LJNCourseListPage({super.key});

  @override
  State<LJNCourseListPage> createState() => _LJNCourseListPageState();
}

// [更正] State 类名已修正
class _LJNCourseListPageState extends State<LJNCourseListPage> {
  final List<Course> courseList = [
    Course(
      id: "course_btc_princeton",
      universityName: "Princeton University",
      courseTitle: "比特币和数字货币技术",
      statusText: "课程 • 截止日期已过",
      isCompleted: true,
    ),
    Course(
      id: "course_ml_stanford",
      universityName: "Stanford University",
      courseTitle: "机器学习入门",
      statusText: "课程 • 正在进行中",
      isCompleted: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: LJNAppBar(
        title: "学院",
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
        itemCount: courseList.length,
        itemBuilder: (context, index) {
          return _buildCourseCard(context, courseList[index], theme);
        },
      ),
    );
  }

  Widget _buildCourseCard(
    BuildContext context,
    Course course,
    ThemeData theme,
  ) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.w),
        side: BorderSide(color: theme.dividerColor, width: 1.5),
      ),
      margin: EdgeInsets.only(top: 20.w),
      child: InkWell(
        onTap: () {
          // 适配您的路由逻辑
          Navigator.pushNamed(
            context,
            '/user/course_detail',
            arguments: {'course_id': course.id},
          );
        },
        borderRadius: BorderRadius.circular(24.w),
        child: Padding(
          padding: EdgeInsets.all(30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    const IconData(
                      0xe644,
                      fontFamily: 'Iconfont',
                    ), // 使用的图标
                    color: theme.colorScheme.onSurface, // 图标颜色
                    size: 30.w, // 图标大小
                  ),
                  SizedBox(width: 20.w),
                  Text(
                    course.universityName,
                    style: TextStyle(
                      fontSize: 28.w,
                      fontWeight: FontWeight.w500,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.w),
              Text(
                course.courseTitle,
                style: TextStyle(
                  fontSize: 34.w,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 15.w),
              Text(
                course.statusText,
                style: TextStyle(fontSize: 24.w, color: theme.hintColor),
              ),
              SizedBox(height: 30.w),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/user/course_detail',
                    arguments: {'course_id': course.id},
                  );
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 80.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.w),
                  ),
                  side: BorderSide(
                    color: theme.colorScheme.primary.withAlpha(204),
                  ),
                ),
                child: Text(
                  course.isCompleted ? "重新访问课程" : "继续学习",
                  style: TextStyle(
                    fontSize: 28.w,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
