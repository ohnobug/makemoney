<template>
  <div class="course-detail">
    <div class="header">
      <button class="back-btn" @click="$router.go(-1)">
        ← 返回
      </button>
      <h1 class="title">{{ courseTitle }}</h1>
    </div>

    <div class="course-info">
      <p class="university">{{ universityName }}</p>
      <p class="status">{{ courseStatus }}</p>
    </div>

    <div class="tabs">
      <button
        v-for="(tab, index) in tabs"
        :key="index"
        :class="['tab-btn', { active: selectedTab === index }]"
        @click="selectedTab = index"
      >
        {{ tab }}
      </button>
    </div>

    <div class="tab-content">
      <div class="unit-selector">
        <label for="unit-select">选择单元:</label>
        <select id="unit-select" v-model="selectedUnit" @change="loadUnitLessons">
          <option v-for="n in 5" :key="n" :value="n">第 {{ n }} 单元</option>
        </select>
      </div>

      <div class="lessons-list">
        <div
          v-for="lesson in currentLessons"
          :key="lesson.id"
          class="lesson-item"
          @click="navigateToLesson(lesson.id)"
        >
          <div class="lesson-icon">{{ lesson.iconData }}</div>

          <div class="lesson-info">
            <h3 class="lesson-title">{{ lesson.title }}</h3>
            <div class="lesson-meta">
              <span class="lesson-type">{{ lesson.typeText }}</span>
              <span class="lesson-duration">{{ lesson.duration }}</span>
              <span v-if="lesson.dueDateInfo" class="due-date">{{ lesson.dueDateInfo }}</span>
            </div>
          </div>

          <div class="lesson-status">
            <span :class="['status-badge', lesson.status]">
              {{ getStatusText(lesson.status) }}
            </span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { mockCourses, mockLessons, LessonStatus } from '../../models/course.js'

const router = useRouter()
const route = useRoute()

const courseId = route.params.courseId
const selectedTab = ref(0)
const selectedUnit = ref(1)
const currentLessons = ref([])
const isLoading = ref(true)

const tabs = ['概览', '课程', '作业', '测验', '资源']

// 根据courseId获取课程信息
const course = computed(() => {
  return mockCourses.find(c => c.id === courseId) || {}
})

const courseTitle = computed(() => course.value.courseTitle || '课程详情')
const universityName = computed(() => course.value.universityName || '')
const courseStatus = computed(() => course.value.statusText || '')

// 获取状态文本
const getStatusText = (status) => {
  switch (status) {
    case LessonStatus.COMPLETED:
      return '已完成'
    case LessonStatus.PENDING:
      return '待完成'
    case LessonStatus.LOCKED:
      return '未解锁'
    case LessonStatus.OVERDUE:
      return '已逾期'
    default:
      return '未知'
  }
}

// 加载单元课程
const loadUnitLessons = () => {
  isLoading.value = true

  // 模拟加载延迟
  setTimeout(() => {
    const lessons = mockLessons[courseId] || []

    // 模拟按单元分组课程
    const unitSize = Math.ceil(lessons.length / 5)
    const startIndex = (selectedUnit.value - 1) * unitSize
    const endIndex = Math.min(startIndex + unitSize, lessons.length)

    currentLessons.value = lessons.slice(startIndex, endIndex)
    isLoading.value = false
  }, 300)
}

// 导航到课程内容页面
const navigateToLesson = (lessonId) => {
  const lesson = currentLessons.value.find(l => l.id === lessonId)
  if (lesson && lesson.status !== LessonStatus.LOCKED) {
    router.push({
      name: 'LessonContent',
      params: { lessonId }
    })
  }
}

onMounted(() => {
  loadUnitLessons()
})
</script>

<style scoped>
.course-detail {
  max-width: 900px;
  margin: 0 auto;
  padding: 20px;
  background-color: #f8f8f8;
  min-height: 100vh;
}

.header {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
  background: white;
  padding: 20px;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.back-btn {
  background: none;
  border: none;
  font-size: 16px;
  cursor: pointer;
  padding: 8px 12px;
  border-radius: 6px;
  transition: background-color 0.2s;
}

.back-btn:hover {
  background-color: #f0f0f0;
}

.title {
  flex: 1;
  text-align: center;
  margin: 0;
  font-size: 24px;
  font-weight: bold;
  color: #333;
}

.course-info {
  background: white;
  padding: 20px;
  border-radius: 12px;
  margin-bottom: 20px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.university {
  font-size: 18px;
  color: #666;
  margin: 0 0 8px 0;
}

.status {
  font-size: 16px;
  color: #888;
  margin: 0;
}

.tabs {
  display: flex;
  background: white;
  border-radius: 12px;
  margin-bottom: 20px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.tab-btn {
  flex: 1;
  padding: 15px;
  border: none;
  background: white;
  cursor: pointer;
  transition: all 0.2s;
  font-size: 16px;
}

.tab-btn.active {
  background-color: #007aff;
  color: white;
}

.tab-btn:hover:not(.active) {
  background-color: #f0f0f0;
}

.tab-content {
  background: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.unit-selector {
  margin-bottom: 20px;
  display: flex;
  align-items: center;
  gap: 10px;
}

.unit-selector label {
  font-weight: bold;
  color: #333;
}

.unit-selector select {
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 6px;
  font-size: 16px;
  cursor: pointer;
}

.lessons-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.lesson-item {
  display: flex;
  align-items: center;
  padding: 16px;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.lesson-item:hover:not(.locked) {
  background-color: #f8f8f8;
  transform: translateX(4px);
}

.lesson-item.locked {
  opacity: 0.6;
  cursor: not-allowed;
}

.lesson-icon {
  font-size: 24px;
  margin-right: 16px;
}

.lesson-info {
  flex: 1;
}

.lesson-title {
  margin: 0 0 8px 0;
  font-size: 18px;
  font-weight: 600;
  color: #333;
}

.lesson-meta {
  display: flex;
  gap: 12px;
  font-size: 14px;
  color: #666;
}

.lesson-type {
  font-weight: 500;
}

.lesson-duration {
  color: #888;
}

.due-date {
  color: #e74c3c;
  font-weight: 500;
}

.lesson-status {
  margin-left: 12px;
}

.status-badge {
  padding: 4px 12px;
  border-radius: 12px;
  font-size: 12px;
  font-weight: 600;
}

.status-badge.completed {
  background-color: #d4edda;
  color: #155724;
}

.status-badge.pending {
  background-color: #fff3cd;
  color: #856404;
}

.status-badge.locked {
  background-color: #e2e3e5;
  color: #383d41;
}

.status-badge.overdue {
  background-color: #f8d7da;
  color: #721c24;
}

@media (max-width: 600px) {
  .course-detail {
    padding: 10px;
  }

  .tabs {
    flex-wrap: wrap;
  }

  .tab-btn {
    font-size: 14px;
    padding: 12px 8px;
  }

  .lesson-item {
    padding: 12px;
  }

  .lesson-meta {
    flex-direction: column;
    gap: 4px;
  }
}
</style>