<template>
  <div class="course-list">
    <div class="header">
      <h1 class="title">学院</h1>
    </div>

    <div class="course-cards">
      <div
        v-for="course in courses"
        :key="course.id"
        class="course-card"
        @click="navigateToDetail(course.id)"
      >
        <div class="course-header">
          <span class="icon">🎓</span>
          <span class="university">{{ course.universityName }}</span>
        </div>

        <h2 class="course-title">{{ course.courseTitle }}</h2>

        <p class="status">{{ course.statusText }}</p>

        <button
          class="action-btn"
          @click.stop="navigateToDetail(course.id)"
        >
          {{ course.isCompleted ? '重新访问课程' : '继续学习' }}
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { mockCourses } from '../../models/course.js'

const router = useRouter()
const courses = ref(mockCourses)

const navigateToDetail = (courseId) => {
  router.push({
    name: 'CourseDetail',
    params: { courseId }
  })
}
</script>

<style scoped>
.course-list {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
  background-color: #f8f8f8;
  min-height: 100vh;
}

.header {
  display: flex;
  align-items: center;
  margin-bottom: 30px;
  background: white;
  padding: 20px;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}


.title {
  text-align: center;
  margin: 0;
  font-size: 24px;
  font-weight: bold;
  color: #333;
}

.course-cards {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.course-card {
  background: white;
  border-radius: 16px;
  padding: 30px;
  box-shadow: 0 2px 12px rgba(0,0,0,0.08);
  border: 1px solid #e0e0e0;
  cursor: pointer;
  transition: all 0.3s ease;
}

.course-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 20px rgba(0,0,0,0.12);
}

.course-header {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
}

.icon {
  font-size: 24px;
  margin-right: 12px;
}

.university {
  font-size: 18px;
  font-weight: 500;
  color: #666;
}

.course-title {
  font-size: 22px;
  font-weight: bold;
  margin: 0 0 12px 0;
  line-height: 1.4;
  color: #333;
}

.status {
  font-size: 16px;
  color: #888;
  margin: 0 0 20px 0;
}

.action-btn {
  width: 100%;
  padding: 12px 20px;
  background: white;
  border: 2px solid #007aff;
  border-radius: 12px;
  color: #007aff;
  font-size: 16px;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.2s ease;
}

.action-btn:hover {
  background-color: #007aff;
  color: white;
}

@media (max-width: 600px) {
  .course-list {
    padding: 10px;
  }

  .course-card {
    padding: 20px;
  }

  .title {
    font-size: 20px;
  }

  .course-title {
    font-size: 18px;
  }
}
</style>