import 'package:flutter/material.dart';

// --- Model for LJNCourseListPage ---
class Course {
  final String id;
  final String universityName;
  final String courseTitle;
  final String statusText;
  final bool isCompleted;

  Course({
    required this.id,
    required this.universityName,
    required this.courseTitle,
    required this.statusText,
    this.isCompleted = false,
  });
}

// --- Models for LJNCourseDetailPage & LJNLessonContentPage ---

enum LessonType {
  video,
  reading,
  assignment,
  quiz,
}

enum LessonStatus {
  completed,
  pending,
  locked,
  overdue,
}

class LessonItem {
  final String id;
  final String title;
  final LessonType type;
  final LessonStatus status;
  final String duration;
  final String? dueDateInfo;
  final String contentDescription;
  final String contentTitle;

  LessonItem({
    required this.id,
    required this.title,
    required this.type,
    required this.status,
    required this.duration,
    this.dueDateInfo,
    this.contentDescription = "",
    this.contentTitle = "",
  });

  IconData get iconData {
    switch (type) {
      case LessonType.video:
        return Icons.play_arrow_rounded;
      case LessonType.reading:
        return Icons.article_rounded;
      case LessonType.assignment:
        return Icons.code_rounded;
      case LessonType.quiz:
        return Icons.quiz_rounded;
    }
  }

  String get typeText {
    switch (type) {
      case LessonType.video:
        return "视频";
      case LessonType.reading:
        return "阅读材料";
      case LessonType.assignment:
        return "编程作业";
      case LessonType.quiz:
        return "测验";
    }
  }
}
