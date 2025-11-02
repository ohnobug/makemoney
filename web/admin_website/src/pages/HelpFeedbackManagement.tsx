import { useState, useEffect } from 'react';
import './HelpFeedbackManagement.scss';

interface HelpArticle {
  id: string;
  title: string;
  content: string;
  category: string;
  tags: string[];
  author: string;
  views: number;
  likes: number;
  status: 'published' | 'draft' | 'archived';
  createdAt: string;
  updatedAt: string;
}

interface Feedback {
  id: string;
  type: 'bug' | 'feature' | 'improvement' | 'other';
  title: string;
  content: string;
  user: {
    id: string;
    name: string;
    email: string;
    avatar?: string;
  };
  priority: 'low' | 'medium' | 'high' | 'urgent';
  status: 'pending' | 'in_progress' | 'resolved' | 'closed' | 'rejected';
  assignee?: string;
  tags: string[];
  attachments: string[];
  createdAt: string;
  updatedAt: string;
  resolvedAt?: string;
  response?: string;
}

type TabType = 'help' | 'feedback';

export default function HelpFeedbackManagement() {
  const [activeTab, setActiveTab] = useState<TabType>('help');
  const [helpArticles, setHelpArticles] = useState<HelpArticle[]>([]);
  const [feedbacks, setFeedbacks] = useState<Feedback[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');
  const [filterCategory, setFilterCategory] = useState<string>('all');
  const [filterStatus, setFilterStatus] = useState<string>('all');
  const [filterPriority, setFilterPriority] = useState<string>('all');
  const [currentPage, setCurrentPage] = useState(1);
  const [pageSize] = useState(10);

  // 弹窗状态
  const [showHelpModal, setShowHelpModal] = useState(false);
  const [showFeedbackModal, setShowFeedbackModal] = useState(false);
  const [editingHelp, setEditingHelp] = useState<HelpArticle | null>(null);
  const [viewingFeedback, setViewingFeedback] = useState<Feedback | null>(null);

  // 表单数据
  const [helpFormData, setHelpFormData] = useState({
    title: '',
    content: '',
    category: 'getting_started',
    tags: '',
    status: 'draft' as 'published' | 'draft' | 'archived'
  });

  const [feedbackResponse, setFeedbackResponse] = useState('');

  // 模拟数据
  useEffect(() => {
    const mockHelpArticles: HelpArticle[] = [
      {
        id: '1',
        title: '如何开始使用AI生成功能',
        content: '本文档将指导您如何快速上手使用我们的AI生成功能，包括文本生成、图像生成等各种功能。',
        category: 'getting_started',
        tags: ['AI生成', '新手指南', '基础功能'],
        author: '系统管理员',
        views: 1523,
        likes: 89,
        status: 'published',
        createdAt: '2024-10-01T10:00:00Z',
        updatedAt: '2024-10-28T15:30:00Z'
      },
      {
        id: '2',
        title: 'NFT铸造完整指南',
        content: '详细介绍如何创建、铸造和管理您的NFT作品，包括最佳实践和常见问题解答。',
        category: 'nft_guide',
        tags: ['NFT', '铸造', '数字资产'],
        author: 'NFT专家',
        views: 892,
        likes: 56,
        status: 'published',
        createdAt: '2024-10-05T14:20:00Z',
        updatedAt: '2024-10-25T09:15:00Z'
      },
      {
        id: '3',
        title: '账户安全和隐私保护',
        content: '了解如何保护您的账户安全，包括密码设置、二次验证等重要安全功能的使用。',
        category: 'security',
        tags: ['安全', '隐私', '账户保护'],
        author: '安全团队',
        views: 2341,
        likes: 167,
        status: 'published',
        createdAt: '2024-09-20T08:30:00Z',
        updatedAt: '2024-10-20T11:45:00Z'
      },
      {
        id: '4',
        title: '支付和提现问题解答',
        content: '关于平台支付流程、提现申请、手续费等常见问题的详细解答。',
        category: 'payment',
        tags: ['支付', '提现', '手续费'],
        author: '财务团队',
        views: 1876,
        likes: 92,
        status: 'draft',
        createdAt: '2024-10-10T16:45:00Z',
        updatedAt: '2024-10-26T13:20:00Z'
      }
    ];

    const mockFeedbacks: Feedback[] = [
      {
        id: '1',
        type: 'bug',
        title: 'AI生成时出现网络连接错误',
        content: '在使用AI生成文本时，经常出现网络连接超时的错误，尝试了多次都无法正常使用。',
        user: {
          id: 'user_001',
          name: '张三',
          email: 'zhangsan@example.com',
          avatar: '👤'
        },
        priority: 'high',
        status: 'in_progress',
        assignee: '技术团队',
        tags: ['AI生成', '网络错误', 'Bug'],
        attachments: ['screenshot1.png', 'error_log.txt'],
        createdAt: '2024-10-28T10:30:00Z',
        updatedAt: '2024-10-29T09:15:00Z',
        response: '我们正在调查此问题，初步判断是服务器负载过高导致，预计今日内修复。'
      },
      {
        id: '2',
        type: 'feature',
        title: '建议增加批量导出功能',
        content: '希望能够增加批量导出AI生成内容的功能，现在只能一个一个导出，不太方便。',
        user: {
          id: 'user_002',
          name: '李四',
          email: 'lisi@example.com',
          avatar: '👨'
        },
        priority: 'medium',
        status: 'pending',
        tags: ['功能建议', '批量操作', '导出'],
        attachments: [],
        createdAt: '2024-10-29T14:20:00Z',
        updatedAt: '2024-10-29T14:20:00Z'
      },
      {
        id: '3',
        type: 'improvement',
        title: '界面可以更简洁一些',
        content: '当前的界面信息有点过多，建议可以增加一个简洁模式，隐藏一些不常用的功能。',
        user: {
          id: 'user_003',
          name: '王五',
          email: 'wangwu@example.com',
          avatar: '👩'
        },
        priority: 'low',
        status: 'resolved',
        assignee: 'UI团队',
        tags: ['界面优化', '用户体验', '简洁模式'],
        attachments: ['mockup.png'],
        createdAt: '2024-10-25T16:10:00Z',
        updatedAt: '2024-10-28T11:30:00Z',
        resolvedAt: '2024-10-28T11:30:00Z',
        response: '感谢您的建议！我们已经在最新版本中增加了简洁模式，您可以在设置中开启。'
      },
      {
        id: '4',
        type: 'bug',
        title: 'NFT交易记录显示异常',
        content: '在NFT交易页面，历史交易记录显示不全，有些交易记录看不到了。',
        user: {
          id: 'user_004',
          name: '赵六',
          email: 'zhaoliu@example.com',
          avatar: '👱'
        },
        priority: 'urgent',
        status: 'in_progress',
        assignee: '区块链团队',
        tags: ['NFT', '交易记录', '数据显示'],
        attachments: [],
        createdAt: '2024-10-29T09:45:00Z',
        updatedAt: '2024-10-29T16:20:00Z',
        response: '问题已经定位，正在紧急修复中，预计2小时内恢复正常。'
      }
    ];

    setTimeout(() => {
      setHelpArticles(mockHelpArticles);
      setFeedbacks(mockFeedbacks);
      setLoading(false);
    }, 1000);
  }, []);

  // 过滤和搜索
  const filteredHelpArticles = helpArticles.filter(article => {
    const matchesSearch = article.title.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         article.content.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         article.tags.some(tag => tag.toLowerCase().includes(searchTerm.toLowerCase()));
    const matchesCategory = filterCategory === 'all' || article.category === filterCategory;
    const matchesStatus = filterStatus === 'all' || article.status === filterStatus;

    return matchesSearch && matchesCategory && matchesStatus;
  });

  const filteredFeedbacks = feedbacks.filter(feedback => {
    const matchesSearch = feedback.title.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         feedback.content.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         feedback.user.name.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesStatus = filterStatus === 'all' || feedback.status === filterStatus;
    const matchesPriority = filterPriority === 'all' || feedback.priority === filterPriority;

    return matchesSearch && matchesStatus && matchesPriority;
  });

  // 分页
  const currentData = activeTab === 'help' ? filteredHelpArticles : filteredFeedbacks;
  const totalPages = Math.ceil(currentData.length / pageSize);
  const paginatedData = currentData.slice(
    (currentPage - 1) * pageSize,
    currentPage * pageSize
  );

  const handleHelpSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    if (editingHelp) {
      setHelpArticles(prev => prev.map(article =>
        article.id === editingHelp.id
          ? {
              ...article,
              ...helpFormData,
              tags: helpFormData.tags.split(',').map(tag => tag.trim()).filter(Boolean),
              updatedAt: new Date().toISOString()
            }
          : article
      ));
    } else {
      const newArticle: HelpArticle = {
        id: Date.now().toString(),
        ...helpFormData,
        tags: helpFormData.tags.split(',').map(tag => tag.trim()).filter(Boolean),
        author: '当前管理员',
        views: 0,
        likes: 0,
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString()
      };
      setHelpArticles(prev => [newArticle, ...prev]);
    }

    handleCloseHelpModal();
  };

  const handleFeedbackResponse = () => {
    if (!viewingFeedback) return;

    setFeedbacks(prev => prev.map(feedback =>
      feedback.id === viewingFeedback.id
        ? {
            ...feedback,
            response: feedbackResponse,
            status: feedback.status === 'pending' ? 'in_progress' : feedback.status,
            updatedAt: new Date().toISOString(),
            resolvedAt: feedback.status === 'pending' ? new Date().toISOString() : feedback.resolvedAt
          }
        : feedback
    ));

    setViewingFeedback(null);
    setFeedbackResponse('');
  };

  const handleStatusChange = (id: string, status: string) => {
    if (activeTab === 'help') {
      setHelpArticles(prev => prev.map(article =>
        article.id === id
          ? { ...article, status: status as any, updatedAt: new Date().toISOString() }
          : article
      ));
    } else {
      setFeedbacks(prev => prev.map(feedback =>
        feedback.id === id
          ? {
              ...feedback,
              status: status as any,
              updatedAt: new Date().toISOString(),
              resolvedAt: (status === 'resolved' || status === 'closed') ? new Date().toISOString() : feedback.resolvedAt
            }
          : feedback
      ));
    }
  };

  const handleDeleteHelp = (id: string) => {
    if (window.confirm('确定要删除这篇帮助文章吗？')) {
      setHelpArticles(prev => prev.filter(article => article.id !== id));
    }
  };

  const handleEditHelp = (article: HelpArticle) => {
    setEditingHelp(article);
    setHelpFormData({
      title: article.title,
      content: article.content,
      category: article.category,
      tags: article.tags.join(', '),
      status: article.status
    });
    setShowHelpModal(true);
  };

  const handleViewFeedback = (feedback: Feedback) => {
    setViewingFeedback(feedback);
    setFeedbackResponse(feedback.response || '');
    setShowFeedbackModal(true);
  };

  const handleCloseHelpModal = () => {
    setShowHelpModal(false);
    setEditingHelp(null);
    setHelpFormData({
      title: '',
      content: '',
      category: 'getting_started',
      tags: '',
      status: 'draft'
    });
  };

  const handleCloseFeedbackModal = () => {
    setShowFeedbackModal(false);
    setViewingFeedback(null);
    setFeedbackResponse('');
  };

  const getCategoryLabel = (category: string) => {
    const labels = {
      getting_started: '入门指南',
      nft_guide: 'NFT指南',
      security: '安全相关',
      payment: '支付问题',
      ai_generation: 'AI生成',
      account_management: '账户管理',
      troubleshooting: '故障排除'
    };
    return labels[category as keyof typeof labels] || category;
  };

  const getStatusBadge = (status: string) => {
    const badges = {
      published: { className: 'status-published', text: '已发布' },
      draft: { className: 'status-draft', text: '草稿' },
      archived: { className: 'status-archived', text: '已归档' },
      pending: { className: 'status-pending', text: '待处理' },
      in_progress: { className: 'status-progress', text: '处理中' },
      resolved: { className: 'status-resolved', text: '已解决' },
      closed: { className: 'status-closed', text: '已关闭' },
      rejected: { className: 'status-rejected', text: '已拒绝' }
    };
    return badges[status as keyof typeof badges];
  };

  const getPriorityBadge = (priority: string) => {
    const badges = {
      low: { className: 'priority-low', text: '低' },
      medium: { className: 'priority-medium', text: '中' },
      high: { className: 'priority-high', text: '高' },
      urgent: { className: 'priority-urgent', text: '紧急' }
    };
    return badges[priority as keyof typeof badges];
  };

  const getTypeLabel = (type: string) => {
    const labels = {
      bug: 'Bug反馈',
      feature: '功能建议',
      improvement: '改进建议',
      other: '其他'
    };
    return labels[type as keyof typeof labels];
  };

  if (loading) {
    return (
      <div className="help-feedback-management">
        <div className="loading">
          <div className="loading-spinner"></div>
          <p>加载中...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="help-feedback-management">
      <div className="page-header">
        <h1>帮助与反馈管理</h1>
        <div className="header-actions">
          {activeTab === 'help' && (
            <button
              className="btn-primary"
              onClick={() => setShowHelpModal(true)}
            >
              ➕ 新增帮助文章
            </button>
          )}
        </div>
      </div>

      {/* 标签页切换 */}
      <div className="tabs">
        <button
          className={`tab-btn ${activeTab === 'help' ? 'active' : ''}`}
          onClick={() => setActiveTab('help')}
        >
          📚 帮助文档 ({helpArticles.length})
        </button>
        <button
          className={`tab-btn ${activeTab === 'feedback' ? 'active' : ''}`}
          onClick={() => setActiveTab('feedback')}
        >
          💬 用户反馈 ({feedbacks.filter(f => f.status !== 'resolved' && f.status !== 'closed').length} 未处理)
        </button>
      </div>

      {/* 搜索和过滤器 */}
      <div className="filters-section">
        <div className="search-box">
          <input
            type="text"
            placeholder={activeTab === 'help' ? '搜索文章标题、内容或标签...' : '搜索反馈标题、内容或用户...'}
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="search-input"
          />
        </div>

        <div className="filters">
          {activeTab === 'help' ? (
            <>
              <select
                value={filterCategory}
                onChange={(e) => setFilterCategory(e.target.value)}
                className="filter-select"
              >
                <option value="all">所有分类</option>
                <option value="getting_started">入门指南</option>
                <option value="nft_guide">NFT指南</option>
                <option value="security">安全相关</option>
                <option value="payment">支付问题</option>
                <option value="ai_generation">AI生成</option>
                <option value="account_management">账户管理</option>
                <option value="troubleshooting">故障排除</option>
              </select>
            </>
          ) : (
            <select
              value={filterPriority}
              onChange={(e) => setFilterPriority(e.target.value)}
              className="filter-select"
            >
              <option value="all">所有优先级</option>
              <option value="urgent">紧急</option>
              <option value="high">高</option>
              <option value="medium">中</option>
              <option value="low">低</option>
            </select>
          )}

          <select
            value={filterStatus}
            onChange={(e) => setFilterStatus(e.target.value)}
            className="filter-select"
          >
            <option value="all">所有状态</option>
            {activeTab === 'help' ? (
              <>
                <option value="published">已发布</option>
                <option value="draft">草稿</option>
                <option value="archived">已归档</option>
              </>
            ) : (
              <>
                <option value="pending">待处理</option>
                <option value="in_progress">处理中</option>
                <option value="resolved">已解决</option>
                <option value="closed">已关闭</option>
                <option value="rejected">已拒绝</option>
              </>
            )}
          </select>
        </div>
      </div>

      {/* 统计卡片 */}
      <div className="stats-cards">
        {activeTab === 'help' ? (
          <>
            <div className="stat-card">
              <div className="stat-icon">📄</div>
              <div className="stat-content">
                <h3>总文章数</h3>
                <p className="stat-number">{helpArticles.length}</p>
              </div>
            </div>
            <div className="stat-card">
              <div className="stat-icon">✅</div>
              <div className="stat-content">
                <h3>已发布</h3>
                <p className="stat-number">{helpArticles.filter(a => a.status === 'published').length}</p>
              </div>
            </div>
            <div className="stat-card">
              <div className="stat-icon">👁️</div>
              <div className="stat-content">
                <h3>总浏览量</h3>
                <p className="stat-number">{helpArticles.reduce((sum, a) => sum + a.views, 0).toLocaleString()}</p>
              </div>
            </div>
            <div className="stat-card">
              <div className="stat-icon">👍</div>
              <div className="stat-content">
                <h3>总点赞数</h3>
                <p className="stat-number">{helpArticles.reduce((sum, a) => sum + a.likes, 0).toLocaleString()}</p>
              </div>
            </div>
          </>
        ) : (
          <>
            <div className="stat-card">
              <div className="stat-icon">💬</div>
              <div className="stat-content">
                <h3>总反馈数</h3>
                <p className="stat-number">{feedbacks.length}</p>
              </div>
            </div>
            <div className="stat-card">
              <div className="stat-icon">⏳</div>
              <div className="stat-content">
                <h3>待处理</h3>
                <p className="stat-number">{feedbacks.filter(f => f.status === 'pending').length}</p>
              </div>
            </div>
            <div className="stat-card">
              <div className="stat-icon">🔥</div>
              <div className="stat-content">
                <h3>紧急反馈</h3>
                <p className="stat-number">{feedbacks.filter(f => f.priority === 'urgent').length}</p>
              </div>
            </div>
            <div className="stat-card">
              <div className="stat-icon">✅</div>
              <div className="stat-content">
                <h3>已解决</h3>
                <p className="stat-number">{feedbacks.filter(f => f.status === 'resolved').length}</p>
              </div>
            </div>
          </>
        )}
      </div>

      {/* 数据列表 */}
      <div className="table-container">
        {activeTab === 'help' ? (
          <table className="data-table">
            <thead>
              <tr>
                <th>文章标题</th>
                <th>分类</th>
                <th>作者</th>
                <th>统计</th>
                <th>状态</th>
                <th>发布时间</th>
                <th>操作</th>
              </tr>
            </thead>
            <tbody>
              {paginatedData.map((article: HelpArticle) => (
                <tr key={article.id}>
                  <td>
                    <div className="article-title">
                      <h4>{article.title}</h4>
                      <p className="article-excerpt">{article.content.substring(0, 100)}...</p>
                      <div className="article-tags">
                        {article.tags.map((tag, index) => (
                          <span key={index} className="tag">{tag}</span>
                        ))}
                      </div>
                    </div>
                  </td>
                  <td>
                    <span className="category-badge">{getCategoryLabel(article.category)}</span>
                  </td>
                  <td>{article.author}</td>
                  <td>
                    <div className="stats">
                      <div>👁️ {article.views.toLocaleString()}</div>
                      <div>👍 {article.likes}</div>
                    </div>
                  </td>
                  <td>
                    <span className={`status-badge ${getStatusBadge(article.status).className}`}>
                      {getStatusBadge(article.status).text}
                    </span>
                  </td>
                  <td>{new Date(article.createdAt).toLocaleDateString()}</td>
                  <td>
                    <div className="actions">
                      <button
                        className="action-btn edit"
                        onClick={() => handleEditHelp(article)}
                        title="编辑"
                      >
                        ✏️
                      </button>
                      <select
                        value={article.status}
                        onChange={(e) => handleStatusChange(article.id, e.target.value)}
                        className="status-select"
                        title="更改状态"
                      >
                        <option value="published">已发布</option>
                        <option value="draft">草稿</option>
                        <option value="archived">已归档</option>
                      </select>
                      <button
                        className="action-btn delete"
                        onClick={() => handleDeleteHelp(article.id)}
                        title="删除"
                      >
                        🗑️
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        ) : (
          <table className="data-table">
            <thead>
              <tr>
                <th>反馈信息</th>
                <th>用户</th>
                <th>类型</th>
                <th>优先级</th>
                <th>状态</th>
                <th>处理人</th>
                <th>创建时间</th>
                <th>操作</th>
              </tr>
            </thead>
            <tbody>
              {paginatedData.map((feedback: Feedback) => (
                <tr key={feedback.id}>
                  <td>
                    <div className="feedback-info">
                      <h4>{feedback.title}</h4>
                      <p className="feedback-excerpt">{feedback.content.substring(0, 100)}...</p>
                      <div className="feedback-tags">
                        {feedback.tags.map((tag, index) => (
                          <span key={index} className="tag">{tag}</span>
                        ))}
                      </div>
                      {feedback.attachments.length > 0 && (
                        <div className="attachments">
                          📎 {feedback.attachments.length} 个附件
                        </div>
                      )}
                    </div>
                  </td>
                  <td>
                    <div className="user-info">
                      <div className="user-avatar">{feedback.user.avatar}</div>
                      <div className="user-details">
                        <div className="user-name">{feedback.user.name}</div>
                        <div className="user-email">{feedback.user.email}</div>
                      </div>
                    </div>
                  </td>
                  <td>
                    <span className="type-badge">{getTypeLabel(feedback.type)}</span>
                  </td>
                  <td>
                    <span className={`priority-badge ${getPriorityBadge(feedback.priority).className}`}>
                      {getPriorityBadge(feedback.priority).text}
                    </span>
                  </td>
                  <td>
                    <span className={`status-badge ${getStatusBadge(feedback.status).className}`}>
                      {getStatusBadge(feedback.status).text}
                    </span>
                  </td>
                  <td>{feedback.assignee || '未分配'}</td>
                  <td>{new Date(feedback.createdAt).toLocaleDateString()}</td>
                  <td>
                    <div className="actions">
                      <button
                        className="action-btn view"
                        onClick={() => handleViewFeedback(feedback)}
                        title="查看详情"
                      >
                        👁️
                      </button>
                      <select
                        value={feedback.status}
                        onChange={(e) => handleStatusChange(feedback.id, e.target.value)}
                        className="status-select"
                        title="更改状态"
                      >
                        <option value="pending">待处理</option>
                        <option value="in_progress">处理中</option>
                        <option value="resolved">已解决</option>
                        <option value="closed">已关闭</option>
                        <option value="rejected">已拒绝</option>
                      </select>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>

      {/* 分页 */}
      {totalPages > 1 && (
        <div className="pagination">
          <button
            className="pagination-btn"
            onClick={() => setCurrentPage(prev => Math.max(1, prev - 1))}
            disabled={currentPage === 1}
          >
            上一页
          </button>

          <span className="pagination-info">
            第 {currentPage} 页，共 {totalPages} 页 ({currentData.length} 条记录)
          </span>

          <button
            className="pagination-btn"
            onClick={() => setCurrentPage(prev => Math.min(totalPages, prev + 1))}
            disabled={currentPage === totalPages}
          >
            下一页
          </button>
        </div>
      )}

      {/* 帮助文章编辑弹窗 */}
      {showHelpModal && (
        <div className="modal-overlay">
          <div className="modal">
            <div className="modal-header">
              <h2>{editingHelp ? '编辑帮助文章' : '新增帮助文章'}</h2>
              <button className="modal-close" onClick={handleCloseHelpModal}>
                ×
              </button>
            </div>

            <form onSubmit={handleHelpSubmit} className="modal-form">
              <div className="form-group">
                <label>文章标题 *</label>
                <input
                  type="text"
                  required
                  value={helpFormData.title}
                  onChange={(e) => setHelpFormData(prev => ({ ...prev, title: e.target.value }))}
                  placeholder="请输入文章标题"
                />
              </div>

              <div className="form-group">
                <label>文章分类 *</label>
                <select
                  value={helpFormData.category}
                  onChange={(e) => setHelpFormData(prev => ({ ...prev, category: e.target.value }))}
                  required
                >
                  <option value="getting_started">入门指南</option>
                  <option value="nft_guide">NFT指南</option>
                  <option value="security">安全相关</option>
                  <option value="payment">支付问题</option>
                  <option value="ai_generation">AI生成</option>
                  <option value="account_management">账户管理</option>
                  <option value="troubleshooting">故障排除</option>
                </select>
              </div>

              <div className="form-group">
                <label>文章内容 *</label>
                <textarea
                  rows={8}
                  required
                  value={helpFormData.content}
                  onChange={(e) => setHelpFormData(prev => ({ ...prev, content: e.target.value }))}
                  placeholder="请输入文章内容"
                />
              </div>

              <div className="form-group">
                <label>标签</label>
                <input
                  type="text"
                  value={helpFormData.tags}
                  onChange={(e) => setHelpFormData(prev => ({ ...prev, tags: e.target.value }))}
                  placeholder="请输入标签，用逗号分隔"
                />
              </div>

              <div className="form-group">
                <label>状态</label>
                <select
                  value={helpFormData.status}
                  onChange={(e) => setHelpFormData(prev => ({ ...prev, status: e.target.value as any }))}
                >
                  <option value="draft">草稿</option>
                  <option value="published">已发布</option>
                  <option value="archived">已归档</option>
                </select>
              </div>

              <div className="modal-footer">
                <button type="button" className="btn-secondary" onClick={handleCloseHelpModal}>
                  取消
                </button>
                <button type="submit" className="btn-primary">
                  {editingHelp ? '更新' : '创建'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* 反馈详情弹窗 */}
      {showFeedbackModal && viewingFeedback && (
        <div className="modal-overlay">
          <div className="modal feedback-modal">
            <div className="modal-header">
              <h2>反馈详情</h2>
              <button className="modal-close" onClick={handleCloseFeedbackModal}>
                ×
              </button>
            </div>

            <div className="modal-content">
              <div className="feedback-detail">
                <div className="detail-section">
                  <h3>基本信息</h3>
                  <div className="detail-grid">
                    <div className="detail-item">
                      <label>标题:</label>
                      <span>{viewingFeedback.title}</span>
                    </div>
                    <div className="detail-item">
                      <label>类型:</label>
                      <span className="type-badge">{getTypeLabel(viewingFeedback.type)}</span>
                    </div>
                    <div className="detail-item">
                      <label>优先级:</label>
                      <span className={`priority-badge ${getPriorityBadge(viewingFeedback.priority).className}`}>
                        {getPriorityBadge(viewingFeedback.priority).text}
                      </span>
                    </div>
                    <div className="detail-item">
                      <label>状态:</label>
                      <span className={`status-badge ${getStatusBadge(viewingFeedback.status).className}`}>
                        {getStatusBadge(viewingFeedback.status).text}
                      </span>
                    </div>
                  </div>
                </div>

                <div className="detail-section">
                  <h3>用户信息</h3>
                  <div className="user-detail">
                    <div className="user-avatar">{viewingFeedback.user.avatar}</div>
                    <div className="user-info">
                      <div className="user-name">{viewingFeedback.user.name}</div>
                      <div className="user-email">{viewingFeedback.user.email}</div>
                    </div>
                  </div>
                </div>

                <div className="detail-section">
                  <h3>反馈内容</h3>
                  <p className="feedback-content">{viewingFeedback.content}</p>
                </div>

                {viewingFeedback.attachments.length > 0 && (
                  <div className="detail-section">
                    <h3>附件</h3>
                    <div className="attachment-list">
                      {viewingFeedback.attachments.map((attachment, index) => (
                        <div key={index} className="attachment-item">
                          📎 {attachment}
                        </div>
                      ))}
                    </div>
                  </div>
                )}

                {viewingFeedback.tags.length > 0 && (
                  <div className="detail-section">
                    <h3>标签</h3>
                    <div className="tag-list">
                      {viewingFeedback.tags.map((tag, index) => (
                        <span key={index} className="tag">{tag}</span>
                      ))}
                    </div>
                  </div>
                )}

                {viewingFeedback.response && (
                  <div className="detail-section">
                    <h3>已有回复</h3>
                    <div className="response-content">
                      {viewingFeedback.response}
                    </div>
                  </div>
                )}

                <div className="detail-section">
                  <h3>回复反馈</h3>
                  <textarea
                    rows={4}
                    value={feedbackResponse}
                    onChange={(e) => setFeedbackResponse(e.target.value)}
                    placeholder="请输入回复内容..."
                  />
                </div>
              </div>

              <div className="modal-footer">
                <button className="btn-secondary" onClick={handleCloseFeedbackModal}>
                  关闭
                </button>
                <button className="btn-primary" onClick={handleFeedbackResponse}>
                  发送回复
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}