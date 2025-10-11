import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:vigaviga/screens/user/course/course_models.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';

class LJNCourseList extends StatefulWidget {
  const LJNCourseList({super.key});

  @override
  State<LJNCourseList> createState() => _LJNCourseListState();
}

// [更正] State 类名已修正
class _LJNCourseListState extends State<LJNCourseList> {
  final List<Course> courseList = [
    Course(
      id: "course_btc_princeton",
      universityLogoUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Princeton_University_seal.svg/1200px-Princeton_University_seal.svg.png",
      universityName: "Princeton University",
      courseTitle: "比特币和数字货币技术",
      statusText: "课程 • 截止日期已过",
      isCompleted: true,
    ),
    Course(
      id: "course_ml_stanford",
      universityLogoUrl:
          "https://upload.wikimedia.org/wikipedia/en/thumb/b/b7/Stanford_University_seal_2003.svg/1200px-Stanford_University_seal_2003.svg.png",
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
      BuildContext context, Course course, ThemeData theme) {
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
            '/course_detail',
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.w),
                    child: CachedNetworkImage(
                      imageUrl: course.universityLogoUrl,
                      width: 48.w,
                      height: 48.w,
                      placeholder: (context, url) =>
                          Container(color: Colors.grey.shade200),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.school),
                    ),
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
                    '/course_detail',
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
