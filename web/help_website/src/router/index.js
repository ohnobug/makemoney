import { createRouter, createWebHistory } from 'vue-router'
import HelpAndFeedback from '../views/HelpAndFeedback.vue'
import FaqDetail from '../views/FaqDetail.vue'

const routes = [
  {
    path: '/',
    name: 'HelpAndFeedback',
    component: HelpAndFeedback
  },
  {
    path: '/faq/:id',
    name: 'FaqDetail',
    component: FaqDetail,
    props: true
  }
]

const router = createRouter({
  history: createWebHistory(import.meta.env.VITE_BASE_URL || '/'),
  routes
})

export default router