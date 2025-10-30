<template>
  <div class="lesson-content">
    <div class="header">
      <button class="back-btn" @click="$router.go(-1)">
        ← 返回
      </button>
      <h1 class="title">{{ lesson?.title || '课程内容' }}</h1>
    </div>

    <div v-if="isLoading" class="loading">
      <div class="spinner"></div>
      <p>加载中...</p>
    </div>

    <div v-else-if="lesson" class="content-wrapper">
      <div class="lesson-info">
        <div class="lesson-header">
          <span class="lesson-icon">{{ lesson.iconData }}</span>
          <div class="lesson-meta">
            <h2 class="lesson-title">{{ lesson.title }}</h2>
            <div class="lesson-details">
              <span class="lesson-type">{{ lesson.typeText }}</span>
              <span class="lesson-duration">{{ lesson.duration }}</span>
              <span v-if="lesson.dueDateInfo" class="due-date">{{ lesson.dueDateInfo }}</span>
            </div>
          </div>
        </div>

        <div class="status-info">
          <span :class="['status-badge', lesson.status]">
            {{ getStatusText(lesson.status) }}
          </span>
        </div>
      </div>

      <div class="content-area">
        <div v-if="lesson.type === 'video'" class="video-content">
          <div class="video-player">
            <div class="video-placeholder">
              <div class="play-button">▶️</div>
              <p>视频播放器</p>
              <p class="video-info">{{ lesson.duration }} 课程视频</p>
            </div>
          </div>

          <div class="video-controls">
            <button class="control-btn" @click="markAsCompleted">
              ✓ 标记为完成
            </button>
            <button class="control-btn secondary" @click="downloadMaterials">
              📥 下载资料
            </button>
          </div>
        </div>

        <div v-else-if="lesson.type === 'reading'" class="reading-content">
          <div class="reading-material">
            <h3>📄 阅读材料</h3>
            <div class="material-content">
              <p>{{ lesson.contentDescription || '暂无内容描述' }}</p>
              <div v-if="lesson.contentTitle" class="document-preview">
                <h4>{{ lesson.contentTitle }}</h4>
                <div class="document-placeholder">
                  <span class="doc-icon">📄</span>
                  <span>点击查看文档内容</span>
                </div>
              </div>
            </div>
          </div>

          <div class="reading-actions">
            <button class="control-btn" @click="markAsCompleted">
              ✓ 标记为完成
            </button>
            <button class="control-btn secondary" @click="openDocument">
              🔗 打开文档
            </button>
          </div>
        </div>

        <div v-else-if="lesson.type === 'assignment'" class="assignment-content">
          <div class="assignment-info">
            <h3>💻 编程作业</h3>
            <div class="assignment-description">
              <p>{{ lesson.contentDescription || '请完成相关编程练习' }}</p>
              <div class="assignment-files">
                <h4>相关文件：</h4>
                <div class="file-list">
                  <div class="file-item">
                    <span class="file-icon">📄</span>
                    <span>作业说明.pdf</span>
                    <button class="download-btn">下载</button>
                  </div>
                  <div class="file-item">
                    <span class="file-icon">💻</span>
                    <span> starter_code.py</span>
                    <button class="download-btn">下载</button>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="assignment-actions">
            <button class="control-btn primary" @click="submitAssignment">
              📤 提交作业
            </button>
            <button class="control-btn secondary" @click="viewExamples">
              👀 查看示例
            </button>
          </div>
        </div>

        <div v-else-if="lesson.type === 'quiz'" class="quiz-content">
          <div class="quiz-info">
            <h3>❓ 测验</h3>
            <div class="quiz-description">
              <p>{{ lesson.contentDescription || '完成以下测验题目' }}</p>
              <div class="quiz-stats">
                <span>题目数量：10</span>
                <span>时间限制：30分钟</span>
                <span>及格分数：70%</span>
              </div>
            </div>
          </div>

          <div class="quiz-actions">
            <button class="control-btn primary" @click="startQuiz">
              🚀 开始测验
            </button>
            <button class="control-btn secondary" @click="reviewMaterials">
              📚 复习材料
            </button>
          </div>
        </div>
      </div>

      <div class="navigation">
        <button
          v-if="hasPreviousLesson"
          class="nav-btn prev"
          @click="navigateToPrevious"
        >
          ← 上一课
        </button>
        <button
          v-if="hasNextLesson"
          class="nav-btn next"
          @click="navigateToNext"
        >
          下一课 →
        </button>
      </div>
    </div>

    <div v-else class="error">
      <p>❌ 课程内容未找到</p>
      <button class="control-btn" @click="$router.go(-1)">
        返回上一页
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { mockLessons, LessonStatus, LessonType } from '../../models/course.js'

const router = useRouter()
const route = useRoute()

const lessonId = route.params.lessonId
const lesson = ref(null)
const isLoading = ref(true)
const allLessons = ref([])

// 获取所有课程，用于导航
const currentLessonIndex = computed(() => {
  return allLessons.value.findIndex(l => l.id === lessonId)
})

const hasPreviousLesson = computed(() => {
  return currentLessonIndex.value > 0
})

const hasNextLesson = computed(() => {
  return currentLessonIndex.value < allLessons.value.length - 1
})

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

// 加载课程内容
const loadLessonContent = () => {
  isLoading.value = true

  // 模拟网络请求
  setTimeout(() => {
    // 从所有课程中找到当前课程
    for (const courseId in mockLessons) {
      const lessons = mockLessons[courseId]
      const foundLesson = lessons.find(l => l.id === lessonId)

      if (foundLesson) {
        lesson.value = foundLesson
        allLessons.value = lessons
        break
      }
    }

    isLoading.value = false
  }, 500)
}

// 标记为完成
const markAsCompleted = () => {
  if (lesson.value) {
    lesson.value.status = LessonStatus.COMPLETED
    alert('✅ 课程已标记为完成！')
  }
}

// 下载资料
const downloadMaterials = () => {
  alert('📥 开始下载课程资料...')
}

// 打开文档
const openDocument = () => {
  alert('🔗 正在打开文档...')
}

// 提交作业
const submitAssignment = () => {
  alert('📤 作业提交功能开发中...')
}

// 查看示例
const viewExamples = () => {
  alert('👀 正在加载示例代码...')
}

// 开始测验
const startQuiz = () => {
  alert('🚀 测验功能开发中...')
}

// 复习材料
const reviewMaterials = () => {
  alert('📚 正在加载复习材料...')
}

// 导航到上一课
const navigateToPrevious = () => {
  if (hasPreviousLesson.value) {
    const prevLesson = allLessons.value[currentLessonIndex.value - 1]
    router.push({
      name: 'LessonContent',
      params: { lessonId: prevLesson.id }
    })
  }
}

// 导航到下一课
const navigateToNext = () => {
  if (hasNextLesson.value) {
    const nextLesson = allLessons.value[currentLessonIndex.value + 1]
    if (nextLesson.status !== LessonStatus.LOCKED) {
      router.push({
        name: 'LessonContent',
        params: { lessonId: nextLesson.id }
      })
    } else {
      alert('🔒 下一课尚未解锁')
    }
  }
}

onMounted(() => {
  loadLessonContent()
})
</script>

<style scoped>
.lesson-content {
  max-width: 1000px;
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

.loading {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 60px;
  background: white;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.spinner {
  width: 40px;
  height: 40px;
  border: 4px solid #f3f3f3;
  border-top: 4px solid #007aff;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-bottom: 16px;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.content-wrapper {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.lesson-info {
  background: white;
  padding: 24px;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.lesson-header {
  display: flex;
  align-items: center;
  gap: 16px;
  margin-bottom: 16px;
}

.lesson-icon {
  font-size: 32px;
}

.lesson-title {
  margin: 0 0 8px 0;
  font-size: 22px;
  font-weight: bold;
  color: #333;
}

.lesson-details {
  display: flex;
  gap: 16px;
  font-size: 14px;
  color: #666;
}

.status-badge {
  padding: 6px 12px;
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

.content-area {
  background: white;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  overflow: hidden;
}

.video-content, .reading-content, .assignment-content, .quiz-content {
  padding: 24px;
}

.video-player {
  background: #000;
  border-radius: 8px;
  aspect-ratio: 16/9;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 20px;
}

.video-placeholder {
  text-align: center;
  color: white;
}

.play-button {
  font-size: 48px;
  margin-bottom: 16px;
  cursor: pointer;
}

.video-info {
  color: #ccc;
  font-size: 14px;
}

.video-controls, .reading-actions, .assignment-actions, .quiz-actions {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
}

.control-btn {
  padding: 12px 24px;
  border: none;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s ease;
}

.control-btn.primary {
  background-color: #007aff;
  color: white;
}

.control-btn.secondary {
  background-color: #f0f0f0;
  color: #333;
}

.control-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}

.reading-material, .assignment-info, .quiz-info {
  margin-bottom: 20px;
}

.reading-material h3, .assignment-info h3, .quiz-info h3 {
  margin: 0 0 16px 0;
  font-size: 20px;
  color: #333;
}

.document-preview, .assignment-files {
  margin-top: 16px;
}

.document-placeholder, .file-list {
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 16px;
}

.document-placeholder {
  text-align: center;
  cursor: pointer;
  transition: background-color 0.2s;
}

.document-placeholder:hover {
  background-color: #f8f8f8;
}

.doc-icon, .file-icon {
  font-size: 24px;
  margin-right: 8px;
}

.file-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 8px 0;
  border-bottom: 1px solid #f0f0f0;
}

.file-item:last-child {
  border-bottom: none;
}

.download-btn {
  padding: 4px 12px;
  background-color: #007aff;
  color: white;
  border: none;
  border-radius: 4px;
  font-size: 12px;
  cursor: pointer;
}

.quiz-stats {
  display: flex;
  gap: 20px;
  margin-top: 12px;
  font-size: 14px;
  color: #666;
}

.navigation {
  display: flex;
  justify-content: space-between;
  gap: 16px;
  padding: 20px;
  background: white;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.nav-btn {
  padding: 12px 24px;
  border: 1px solid #ddd;
  background: white;
  border-radius: 8px;
  font-size: 16px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.nav-btn:hover {
  background-color: #f8f8f8;
  transform: translateY(-1px);
}

.nav-btn.next {
  margin-left: auto;
}

.error {
  background: white;
  padding: 60px;
  border-radius: 12px;
  text-align: center;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.error p {
  font-size: 18px;
  color: #e74c3c;
  margin-bottom: 20px;
}

@media (max-width: 600px) {
  .lesson-content {
    padding: 10px;
  }

  .lesson-header {
    flex-direction: column;
    text-align: center;
  }

  .lesson-details {
    flex-direction: column;
    gap: 8px;
  }

  .video-controls, .reading-actions, .assignment-actions, .quiz-actions {
    flex-direction: column;
  }

  .control-btn {
    width: 100%;
  }

  .navigation {
    flex-direction: column;
  }

  .nav-btn {
    width: 100%;
  }

  .quiz-stats {
    flex-direction: column;
    gap: 8px;
  }
}
</style>