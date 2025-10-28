<template>
  <div class="faq-detail-page">
    <!-- App Bar -->
    <div class="app-bar" :style="{ paddingTop: statusBarHeight }">
      <div class="app-bar-content">
        <button class="back-button" @click="goBack">‹</button>
        <h1 class="app-title">问题详情</h1>
        <div class="spacer"></div>
      </div>
    </div>

    <!-- Main Content -->
    <div class="content">
      <!-- Question Header -->
      <div class="question-header">
        <div class="category-chip">
          <span class="category-icon">🏷️</span>
          <span class="category-text">{{ category }}</span>
        </div>
        <h2 class="question-text">{{ question }}</h2>
      </div>

      <!-- Answer Card -->
      <div class="answer-card">
        <div class="answer-content" v-html="htmlAnswer"></div>
      </div>

      <!-- Feedback Section -->
      <div class="feedback-section">
        <transition name="fade" mode="out-in">
          <div v-if="!feedbackSubmitted" key="feedback-buttons" class="feedback-buttons">
            <p class="feedback-question">这个问题有帮助吗？</p>
            <div class="button-group">
              <button class="feedback-button helpful" @click="submitFeedback(true)">
                <span class="button-icon">👍</span>
                <span>有帮助</span>
              </button>
              <button class="feedback-button not-helpful" @click="submitFeedback(false)">
                <span class="button-icon">👎</span>
                <span>没帮助</span>
              </button>
            </div>
          </div>
          <div v-else key="thank-you" class="thank-you">
            <span class="thank-you-icon">👍</span>
            <p class="thank-you-text">感谢您的反馈！</p>
          </div>
        </transition>
      </div>

      <!-- Footer Actions -->
      <div class="footer-actions">
        <p class="footer-title">还需要其他帮助？</p>
        <div class="action-list">
          <div class="action-item" @click="contactCustomerService">
            <span class="action-icon">👤</span>
            <span class="action-text">联系在线客服</span>
            <span class="action-arrow">›</span>
          </div>
          <div class="action-item" @click="navigateToComplain">
            <span class="action-icon">💬</span>
            <span class="action-text">提交意见反馈</span>
            <span class="action-arrow">›</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'

const route = useRoute()
const router = useRouter()

const question = ref('')
const category = ref('')
const feedbackSubmitted = ref(false)

// Generate HTML answer based on question
const htmlAnswer = ref('')

// Status bar height handling
const statusBarHeight = ref('0px')

// Load question and answer when component mounts
onMounted(async () => {
  // Listen for Flutter status bar height event
  window.addEventListener('flutterStatusBarHeightReady', function (event) {
    const statusBarHeightPx = event.detail.statusBarHeightPx
    console.log('状态栏高度:', statusBarHeightPx)
    statusBarHeight.value = `${statusBarHeightPx}px`
  })
  question.value = decodeURIComponent(route.params.id)
  // For demo purposes, set category based on question content
  if (question.value.includes('账号') || question.value.includes('密码')) {
    category.value = '帐号问题'
  } else if (question.value.includes('笔记')) {
    category.value = '热门问题'
  } else if (question.value.includes('主页')) {
    category.value = '个人主页问题'
  } else if (question.value.includes('流量')) {
    category.value = '流量问题'
  } else {
    category.value = '常见问题'
  }

  // Load answer data
  const answerData = await getAnswerData(question.value)
  htmlAnswer.value = generateHtmlAnswer(answerData)
})

// Methods
const goBack = () => {
  router.back()
}

const submitFeedback = (isHelpful) => {
  console.log('Feedback submitted:', { question: question.value, isHelpful })
  feedbackSubmitted.value = true
}

const contactCustomerService = () => {
  alert('正在为您转接客服...')
}

const navigateToComplain = () => {
  alert('跳转到意见反馈页面')
}

// Simulate API request for FAQ data
const getAnswerData = async (question) => {
  // Simulate API delay
  await new Promise(resolve => setTimeout(resolve, 100))

  const faqData = [
    {
      question: '笔记审核时效是多久',
      answer: `
        <div class="faq-content">
          <p>笔记审核通常需要<strong>1-3个工作日</strong>完成。</p>
          <div class="faq-important">
            <div class="important-title">💡 重要提示</div>
            <p>在高峰期或节假日期间，审核时间可能会有所延长。</p>
          </div>
          <p>如果您的笔记超过3个工作日仍未审核完成，建议您：</p>
          <ul>
            <li>联系客服查询具体进度</li>
            <li>检查笔记内容是否符合社区规范</li>
            <li>避免重复提交相同内容</li>
          </ul>
        </div>
      `
    },
    {
      question: '视频互动栏怎么切换到底部？',
      answer: `
        <div class="faq-content">
          <p>请按照以下步骤操作：</p>
          <div class="faq-step">
            <div class="step-number">1</div>
            <div class="step-text">在视频播放页面，点击右上角的<strong>设置按钮</strong></div>
          </div>
          <div class="faq-step">
            <div class="step-number">2</div>
            <div class="step-text">在设置菜单中找到<strong>"互动栏位置"</strong>选项</div>
          </div>
          <div class="faq-step">
            <div class="step-number">3</div>
            <div class="step-text">选择<strong>"底部"</strong>即可将互动栏切换到视频下方</div>
          </div>
          <div class="faq-tip">
            <p><strong>提示：</strong>切换后，互动栏会显示在视频播放器下方，方便您查看评论和点赞。</p>
          </div>
        </div>
      `
    },
    {
      question: '如何开通直播权限？',
      answer: `
        <div class="faq-content">
          <p>开通直播权限需要满足以下条件：</p>
          <ul>
            <li>账号已完成<strong>实名认证</strong></li>
            <li>账号注册时间超过<strong>30天</strong></li>
            <li>最近30天内无违规记录</li>
          </ul>
          <p>申请流程：</p>
          <div class="faq-step">
            <div class="step-number">1</div>
            <div class="step-text">进入<strong>个人中心</strong></div>
          </div>
          <div class="faq-step">
            <div class="step-number">2</div>
            <div class="step-text">找到<strong>"直播管理"</strong>入口</div>
          </div>
          <div class="faq-step">
            <div class="step-number">3</div>
            <div class="step-text">按照提示完成直播权限申请</div>
          </div>
          <div class="faq-step">
            <div class="step-number">4</div>
            <div class="step-text">等待<strong>1-3个工作日</strong>审核</div>
          </div>
          <div class="faq-important">
            <div class="important-title">💡 重要提示</div>
            <p>审核通过后，您需要先完成直播功能的学习和测试，才能正式开始直播。</p>
          </div>
        </div>
      `
    },
    {
      question: '如何修改密码？',
      answer: `
        <div class="faq-content">
          <p>修改密码的步骤如下：</p>
          <div class="faq-step">
            <div class="step-number">1</div>
            <div class="step-text">进入<strong>设置</strong>页面</div>
          </div>
          <div class="faq-step">
            <div class="step-number">2</div>
            <div class="step-text">找到<strong>"账号与安全"</strong>选项</div>
          </div>
          <div class="faq-step">
            <div class="step-number">3</div>
            <div class="step-text">选择<strong>"修改密码"</strong></div>
          </div>
          <div class="faq-step">
            <div class="step-number">4</div>
            <div class="step-text">输入<strong>原密码</strong>和<strong>新密码</strong></div>
          </div>
          <div class="faq-step">
            <div class="step-number">5</div>
            <div class="step-text">确认修改</div>
          </div>
          <div class="faq-security">
            <p><strong>安全建议：</strong></p>
            <ul>
              <li>密码长度建议8位以上</li>
              <li>包含字母、数字和特殊字符</li>
              <li>定期更换密码</li>
              <li>不要使用与其他平台相同的密码</li>
            </ul>
          </div>
        </div>
      `
    },
    {
      question: '账号被盗了怎么办？',
      answer: `
        <div class="faq-content">
          <div class="faq-emergency">
            <div class="emergency-title">🚨 紧急处理</div>
            <p>如果发现账号被盗，请立即采取以下措施：</p>
          </div>
          <div class="faq-step">
            <div class="step-number">1</div>
            <div class="step-text">立即通过<strong>找回密码</strong>功能重置密码</div>
          </div>
          <div class="faq-step">
            <div class="step-number">2</div>
            <div class="step-text">联系客服<strong>冻结账号</strong>防止进一步损失</div>
          </div>
          <div class="faq-step">
            <div class="step-number">3</div>
            <div class="step-text">检查账号绑定信息是否被修改</div>
          </div>
          <div class="faq-step">
            <div class="step-number">4</div>
            <div class="step-text">开启<strong>二次验证</strong>增强安全性</div>
          </div>
          <div class="faq-prevention">
            <div class="prevention-title">💡 预防措施</div>
            <ul>
              <li>不要点击不明链接</li>
              <li>不要泄露验证码</li>
              <li>定期检查账号安全状态</li>
              <li>绑定手机和邮箱</li>
            </ul>
          </div>
        </div>
      `
    }
  ]

  // Find the matching FAQ item
  const faqItem = faqData.find(item => item.question === question)

  // Return the answer if found, otherwise return default content
  return faqItem ? faqItem.answer : `
    <div class="faq-content">
      <p>这个问题我们正在完善解答内容。</p>
      <p>您可以：</p>
      <ul>
        <li>联系在线客服获取帮助</li>
        <li>稍后再来查看更新</li>
        <li>提交意见反馈告诉我们您的需求</li>
      </ul>
    </div>
  `
}

// Generate HTML content
const generateHtmlAnswer = (answerData) => {
  // 在实际项目中，这里应该添加HTML内容安全处理
  // 例如使用DOMPurify或其他HTML清理库
  // 这里为了演示，直接返回内容
  return answerData
}
</script>

<style scoped lang="scss">
@use '@/assets/scss/faq-detail.scss';
</style>

