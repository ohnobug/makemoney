<template>
  <div class="help-feedback-page">
    <!-- App Bar -->
    <div class="app-bar">
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
          <div
            v-for="tool in tools"
            :key="tool.title"
            class="tool-item"
            @click="handleToolClick(tool)"
          >
            <div class="tool-icon">
              <span>{{ tool.icon }}</span>
            </div>
            <div class="tool-title">{{ tool.title }}</div>
          </div>
        </div>
      </div>

      <!-- Web Browser Test Section -->
      <div class="section">
        <div class="section-header">
          <h2 class="section-title">网页浏览器功能测试</h2>
        </div>
        <div class="web-browser-test">
          <div class="browser-item" @click="openWebBrowser">
            <span class="browser-icon">🌐</span>
            <span class="browser-text">测试网页浏览器功能（百度主页）</span>
            <span class="arrow">›</span>
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
            <Swiper
              :slides-per-view="'auto'"
              :space-between="0"
              :centered-slides="false"
              :initial-slide="initialTabIndex"
              :allow-touch-move="true"
              :resistance="true"
              :resistance-ratio="0.5"
              @swiper="onSwiper"
              @slide-change="onSlideChange"
              class="tabs-swiper"
            >
              <SwiperSlide
                v-for="(tab, index) in tabs"
                :key="tab.key"
                :class="['tab-slide', { active: activeTab === tab.key }]"
                @click="setActiveTab(tab.key, index)"
              >
                <div class="tab-content">
                  {{ tab.title }}
                </div>
              </SwiperSlide>
            </Swiper>
          </div>

          <!-- Questions List with Swiper -->
          <div class="questions-list">
            <Swiper
              :slides-per-view="1"
              :space-between="0"
              :initial-slide="initialTabIndex"
              :allow-touch-move="true"
              :resistance="true"
              :resistance-ratio="0.5"
              @swiper="onQuestionsSwiper"
              @slide-change="onQuestionsSlideChange"
              class="questions-swiper"
            >
              <SwiperSlide
                v-for="(tab, index) in tabs"
                :key="tab.key"
                class="questions-slide"
              >
                <div
                  v-for="question in questionsData[tab.key]"
                  :key="question"
                  class="question-item"
                  @click="navigateToFaqDetail(question)"
                >
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

const openWebBrowser = async () => {
  const baiduUrl = 'https://www.baidu.com'

  // 检查是否在 Flutter WebView 环境中
  if (window.flutter_inappwebview) {
    try {
      // 调用 Flutter 方法打开网页浏览器页面
      await window.flutter_inappwebview.callHandler('openWebBrowser', {
        url: baiduUrl,
        title: '百度'
      })
    } catch (error) {
      console.error('调用 Flutter 方法失败:', error)
      // 降级方案：直接打开链接
      window.open(baiduUrl, '_blank')
    }
  } else {
    // 不在 Flutter 环境中，直接打开链接
    window.open(baiduUrl, '_blank')
  }
}

</script>

<style scoped>
.help-feedback-page {
  min-height: 100vh;
  background-color: #f8f8f8;
  display: flex;
  flex-direction: column;
}

/* App Bar */
.app-bar {
  background-color: white;
  padding: 12px 16px;
  border-bottom: 1px solid #e0e0e0;
  position: sticky;
  top: 0;
  z-index: 100;
}

.app-bar-content {
  display: flex;
  align-items: center;
  justify-content: center;
}

.app-title {
  font-size: 18px;
  font-weight: 600;
  color: #333;
  margin: 0;
}

/* Content */
.content {
  flex: 1;
  padding: 16px;
}

/* Section */
.section {
  margin-bottom: 24px;
}

.section-header {
  margin-bottom: 12px;
}

.section-title {
  font-size: 16px;
  font-weight: 600;
  color: #333;
  margin: 0;
}

/* Tools Grid */
.tools-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 16px;
}

.tool-item {
  background-color: white;
  border-radius: 8px;
  padding: 16px 8px;
  text-align: center;
  cursor: pointer;
  transition: all 0.2s;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.tool-item:hover {
  transform: translateY(-2px);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
}

.tool-icon {
  font-size: 24px;
  margin-bottom: 8px;
}

.tool-title {
  font-size: 12px;
  color: #333;
  font-weight: 500;
}

/* Web Browser Test */
.web-browser-test {
  background-color: white;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.browser-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.browser-item:hover {
  background-color: #f5f5f5;
}

.browser-icon {
  margin-right: 12px;
  font-size: 20px;
}

.browser-text {
  flex: 1;
  font-size: 14px;
  color: #333;
}

/* Questions Container */
.questions-container {
  background-color: white;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

/* Tabs with Swiper */
.tabs-container {
  border-bottom: 1px solid #e0e0e0;
  overflow: hidden;
  height: 48px; /* 固定高度 */
}

.tabs-swiper {
  width: 100%;
  height: 100%;
}

.tab-slide {
  width: auto !important;
  height: 100%;
  cursor: pointer;
  user-select: none;
  display: flex;
  align-items: center;
}

.tab-content {
  padding: 12px 20px;
  font-size: 14px;
  color: #666;
  white-space: nowrap;
  transition: all 0.2s;
  border-bottom: 2px solid transparent;
}

.tab-slide.active .tab-content {
  color: #007AFF;
  font-weight: 600;
  border-bottom-color: #007AFF;
}

/* Questions List with Swiper */
.questions-list {
  height: 300px; /* 固定高度，确保内容不会溢出 */
  overflow: hidden;
}

.questions-swiper {
  width: 100%;
  height: 100%;
}

.questions-slide {
  height: 100%;
  overflow-y: auto; /* 允许内容滚动 */
}

.question-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 12px 16px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.question-item:hover {
  background-color: #f5f5f5;
}

.question-text {
  font-size: 14px;
  color: #333;
  flex: 1;
}

.arrow {
  color: #999;
  font-size: 16px;
  font-weight: bold;
}

/* Bottom Navigation */
.bottom-nav {
  background-color: white;
  border-top: 1px solid #e0e0e0;
  display: flex;
  align-items: center;
  padding: 12px 0;
  position: sticky;
  bottom: 0;
}

.nav-item {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 8px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.nav-item:hover {
  background-color: #f5f5f5;
}

.nav-divider {
  width: 1px;
  height: 20px;
  background-color: #e0e0e0;
}

.nav-icon {
  margin-right: 4px;
}

/* Responsive Design */
@media (max-width: 480px) {
  .tools-grid {
    grid-template-columns: repeat(2, 1fr);
  }

  .tab-content {
    padding: 12px 16px;
    font-size: 13px;
  }
}
</style>