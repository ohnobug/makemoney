import { createRouter, createWebHistory } from 'vue-router'
import CourseList from '../views/course/CourseList.vue'
import CourseDetail from '../views/course/CourseDetail.vue'
import LessonContent from '../views/course/LessonContent.vue'

const routes = [
  {
    path: '/',
    name: 'CourseList',
    component: CourseList
  },
  {
    path: '/course/detail/:courseId',
    name: 'CourseDetail',
    component: CourseDetail,
    props: true
  },
  {
    path: '/course/lesson/:lessonId',
    name: 'LessonContent',
    component: LessonContent,
    props: true
  }
]

const router = createRouter({
  history: createWebHistory(import.meta.env.VITE_BASE_URL || '/'),
  routes
})

export default router