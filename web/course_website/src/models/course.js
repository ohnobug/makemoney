// --- Model for CourseListPage ---
export class Course {
  constructor({
    id,
    universityName,
    courseTitle,
    statusText,
    isCompleted = false
  }) {
    this.id = id;
    this.universityName = universityName;
    this.courseTitle = courseTitle;
    this.statusText = statusText;
    this.isCompleted = isCompleted;
  }
}

// --- Models for CourseDetailPage & LessonContentPage ---
export const LessonType = {
  VIDEO: 'video',
  READING: 'reading',
  ASSIGNMENT: 'assignment',
  QUIZ: 'quiz'
};

export const LessonStatus = {
  COMPLETED: 'completed',
  PENDING: 'pending',
  LOCKED: 'locked',
  OVERDUE: 'overdue'
};

export class LessonItem {
  constructor({
    id,
    title,
    type,
    status,
    duration,
    dueDateInfo = null,
    contentDescription = '',
    contentTitle = ''
  }) {
    this.id = id;
    this.title = title;
    this.type = type;
    this.status = status;
    this.duration = duration;
    this.dueDateInfo = dueDateInfo;
    this.contentDescription = contentDescription;
    this.contentTitle = contentTitle;
  }

  get iconData() {
    switch (this.type) {
      case LessonType.VIDEO:
        return '▶️';
      case LessonType.READING:
        return '📄';
      case LessonType.ASSIGNMENT:
        return '💻';
      case LessonType.QUIZ:
        return '❓';
      default:
        return '📚';
    }
  }

  get typeText() {
    switch (this.type) {
      case LessonType.VIDEO:
        return "视频";
      case LessonType.READING:
        return "阅读材料";
      case LessonType.ASSIGNMENT:
        return "编程作业";
      case LessonType.QUIZ:
        return "测验";
      default:
        return "未知";
    }
  }
}

// Mock data
export const mockCourses = [
  new Course({
    id: "course_btc_princeton",
    universityName: "Princeton University",
    courseTitle: "比特币和数字货币技术",
    statusText: "课程 • 截止日期已过",
    isCompleted: true,
  }),
  new Course({
    id: "course_ml_stanford",
    universityName: "Stanford University",
    courseTitle: "机器学习入门",
    statusText: "课程 • 正在进行中",
    isCompleted: false,
  }),
];

export const mockLessons = {
  "course_btc_princeton": [
    new LessonItem({
      id: "btc_01",
      title: "课程信息",
      type: LessonType.READING,
      status: LessonStatus.COMPLETED,
      duration: "10 分钟",
    }),
    new LessonItem({
      id: "btc_02",
      title: "欢迎",
      type: LessonType.VIDEO,
      status: LessonStatus.COMPLETED,
      duration: "5 分钟",
    }),
    new LessonItem({
      id: "btc_03",
      title: "密码学历史",
      type: LessonType.VIDEO,
      status: LessonStatus.COMPLETED,
      duration: "15 分钟",
    }),
    new LessonItem({
      id: "btc_04",
      title: "哈希函数",
      type: LessonType.VIDEO,
      status: LessonStatus.PENDING,
      duration: "20 分钟",
      dueDateInfo: "截止：2024-12-01",
    }),
    new LessonItem({
      id: "btc_05",
      title: "简单密码学",
      type: LessonType.VIDEO,
      status: LessonStatus.PENDING,
      duration: "25 分钟",
      dueDateInfo: "截止：2024-12-08",
    }),
  ],
  "course_ml_stanford": [
    new LessonItem({
      id: "ml_01",
      title: "课程介绍",
      type: LessonType.VIDEO,
      status: LessonStatus.COMPLETED,
      duration: "12 分钟",
    }),
    new LessonItem({
      id: "ml_02",
      title: "监督学习基础",
      type: LessonType.VIDEO,
      status: LessonStatus.PENDING,
      duration: "30 分钟",
      dueDateInfo: "截止：2024-11-15",
    }),
    new LessonItem({
      id: "ml_03",
      title: "线性回归",
      type: LessonType.VIDEO,
      status: LessonStatus.LOCKED,
      duration: "45 分钟",
      dueDateInfo: "截止：2024-11-22",
    }),
  ]
};