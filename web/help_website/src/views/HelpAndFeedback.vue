<template>
  <div class="help-feedback-page">
    <!-- App Bar -->
    <div class="app-bar" :style="{ paddingTop: statusBarHeight }">
      <div class="app-bar-content">
        <h1 class="app-title">帮助与反馈</h1>
      </div>
    </div>

    <!-- Main Content -->
    <div class="content">
      <!-- Self-service Tools Section -->
      <div class="section">
        <div class="section-header">
          <h2 class="section-title">自助工具</h2>
        </div>
        <div class="tools-grid">
          <div v-for="tool in tools" :key="tool.title" class="tool-item" @click="handleToolClick(tool)">
            <div class="tool-icon">
              <span>{{ tool.icon }}</span>
            </div>
            <div class="tool-title">{{ tool.title }}</div>
          </div>
        </div>
      </div>


      <!-- Questions Section -->
      <div class="section">
        <div class="section-header">
          <h2 class="section-title">猜你想问</h2>
        </div>
        <div class="questions-container">
          <!-- Tabs with Swiper -->
          <div class="tabs-container">
            <Swiper :slides-per-view="'auto'" :space-between="0" :centered-slides="false"
              :initial-slide="initialTabIndex" :allow-touch-move="true" :resistance="true" :resistance-ratio="0.5"
              @swiper="onSwiper" @slide-change="onSlideChange" class="tabs-swiper">
              <SwiperSlide v-for="(tab, index) in tabs" :key="tab.key"
                :class="['tab-slide', { active: activeTab === tab.key }]" @click="setActiveTab(tab.key, index)">
                <div class="tab-content">
                  {{ tab.title }}
                </div>
              </SwiperSlide>
            </Swiper>
          </div>

          <!-- Questions List with Swiper -->
          <div class="questions-list">
            <Swiper :slides-per-view="1" :space-between="0" :initial-slide="initialTabIndex" :allow-touch-move="true"
              :resistance="true" :resistance-ratio="0.5" @swiper="onQuestionsSwiper"
              @slide-change="onQuestionsSlideChange" class="questions-swiper">
              <SwiperSlide v-for="(tab, index) in tabs" :key="tab.key" class="questions-slide">
                <div v-for="question in questionsData[tab.key]" :key="question" class="question-item"
                  @click="navigateToFaqDetail(question)">
                  <span class="question-text">{{ question }}</span>
                  <span class="arrow">›</span>
                </div>
              </SwiperSlide>
            </Swiper>
          </div>
        </div>
      </div>
    </div>

    <!-- Bottom Navigation -->
    <div class="bottom-nav">
      <div class="nav-item" @click="navigateToComplain">
        <span>意见反馈</span>
      </div>
      <div class="nav-divider"></div>
      <div class="nav-item" @click="contactCustomerService">
        <span class="nav-icon">🎤</span>
        <span>联系官方客服</span>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { Swiper, SwiperSlide } from 'swiper/vue'
import 'swiper/css'

const router = useRouter()

// Swiper instances
const tabsSwiper = ref(null)
const questionsSwiper = ref(null)

// Set swiper instances
const onSwiper = (swiper) => {
  tabsSwiper.value = swiper
}

const onQuestionsSwiper = (swiper) => {
  questionsSwiper.value = swiper
}

// Tools data
const tools = [
  { title: '账号检测', icon: '🔍' },
  { title: '笔记申诉', icon: '📝' },
  { title: '开通店铺', icon: '🏪' },
  { title: '售后退款', icon: '💳' },
  { title: '券和福利', icon: '🎫' },
  { title: '找回账号', icon: '🔑' },
  { title: '账号与安全', icon: '🛡️' },
  { title: '查看物流', icon: '🚚' }
]

// Tabs and questions data
const tabs = [
  { key: 'hot', title: '热门问题' },
  { key: 'account', title: '帐号问题' },
  { key: 'profile', title: '个人主页问题' },
  { key: 'traffic', title: '流量问题' }
]

const questionsData = {
  hot: [
    '笔记审核时效是多久',
    '视频互动栏怎么切换到底部？',
    '如何开通直播权限？',
    '笔记被判定违反社区规范第四条是什么意思？',
    '如何变更或解绑小红书的实名认证？'
  ],
  account: [
    '如何修改密码？',
    '账号被盗了怎么办？',
    '怎么注销账号？',
    '如何绑定手机号？',
    '如何解除绑定手机号？'
  ],
  profile: [
    '个人主页可以设置什么？',
    '如何更换头像？',
    '怎么修改昵称？',
    '怎么修改简介？'
  ],
  traffic: [
    '如何增加笔记曝光？',
    '为什么我的笔记没有流量？'
  ]
}

const activeTab = ref('hot')

// Get initial tab index
const initialTabIndex = computed(() => {
  return tabs.findIndex(tab => tab.key === activeTab.value)
})

const activeQuestions = computed(() => {
  return questionsData[activeTab.value] || []
})

// Status bar height handling
const statusBarHeight = ref('0px')

onMounted(() => {
  // Listen for Flutter status bar height event
  window.addEventListener('flutterStatusBarHeightReady', function (event) {
    const statusBarHeightPx = event.detail.statusBarHeightPx
    console.log('状态栏高度:', statusBarHeightPx)
    statusBarHeight.value = `${statusBarHeightPx}px`
  })
})

// Swiper Methods
const onSlideChange = (swiper) => {
  const activeIndex = swiper.activeIndex
  if (tabs[activeIndex]) {
    activeTab.value = tabs[activeIndex].key
    // 同步questions swiper
    if (questionsSwiper.value && questionsSwiper.value.slideTo) {
      questionsSwiper.value.slideTo(activeIndex)
    }
  }
}

const onQuestionsSlideChange = (swiper) => {
  const activeIndex = swiper.activeIndex
  if (tabs[activeIndex]) {
    activeTab.value = tabs[activeIndex].key
    // 同步tabs swiper
    if (tabsSwiper.value && tabsSwiper.value.slideTo) {
      tabsSwiper.value.slideTo(activeIndex)
    }
  }
}

const setActiveTab = (tabKey, index) => {
  activeTab.value = tabKey
  // 同步两个swiper
  if (tabsSwiper.value && tabsSwiper.value.slideTo) {
    tabsSwiper.value.slideTo(index)
  }
  if (questionsSwiper.value && questionsSwiper.value.slideTo) {
    questionsSwiper.value.slideTo(index)
  }
}

// Methods
const handleToolClick = (tool) => {
  console.log('Tool clicked:', tool.title)
  // Here you would implement the actual tool functionality
}

const navigateToFaqDetail = (question) => {
  const questionId = encodeURIComponent(question)
  router.push(`/faq/${questionId}`)
}

const navigateToComplain = () => {
  alert('跳转到意见反馈页面')
}

const contactCustomerService = () => {
  alert('正在为您转接官方客服...')
}

</script>

<style scoped>
@import '@/assets/scss/help-feedback.scss';
</style>