import { useState, useEffect } from 'react';
import './Dashboard.scss';
import UserList from './UserList';

interface SubMenuItem {
  id: string;
  name: string;
}

interface MenuItem {
  id: string;
  name: string;
  icon: string;
  active?: boolean;
  expanded?: boolean;
  subItems?: SubMenuItem[];
}

interface Tab {
  id: string;
  name: string;
  component: React.ReactNode;
  closable: boolean;
}

export default function Dashboard() {
  const [menuItems, setMenuItems] = useState<MenuItem[]>([
    {
      id: 'dashboard',
      name: '平台总览',
      icon: '📈',
      active: true,
      expanded: false
    },
    {
      id: 'user-management',
      name: '用户管理',
      icon: '👤',
      expanded: false,
      subItems: [
        { id: 'user-list', name: '用户列表' },
        { id: 'user-growth', name: '用户增长分析' },
        { id: 'user-behavior', name: '用户行为分析' },
        { id: 'user-reports', name: '用户举报处理' },
        { id: 'vip-management', name: 'VIP会员管理' }
      ]
    },
    {
      id: 'content-management',
      name: '内容管理',
      icon: '📝',
      expanded: false,
      subItems: [
        { id: 'content-list', name: '内容列表' },
        { id: 'content-review', name: '内容审核' },
        { id: 'ai-generated', name: 'AI生成内容' },
        { id: 'content-categories', name: '内容分类' },
        { id: 'content-tags', name: '标签管理' },
        { id: 'content-reports', name: '内容举报' }
      ]
    },
    {
      id: 'nft-management',
      name: 'NFT管理',
      icon: '🖼️',
      expanded: false,
      subItems: [
        { id: 'nft-list', name: 'NFT列表' },
        { id: 'nft-minting', name: '铸造记录' },
        { id: 'nft-trading', name: '交易记录' },
        { id: 'nft-collections', name: '合集管理' },
        { id: 'nft-analytics', name: 'NFT数据分析' }
      ]
    },
    {
      id: 'ai-management',
      name: 'AI管理',
      icon: '🤖',
      expanded: false,
      subItems: [
        { id: 'ai-tasks', name: 'AI任务管理' },
        { id: 'ai-models', name: 'AI模型管理' },
        { id: 'ai-usage', name: '使用量统计' },
        { id: 'ai-performance', name: '性能监控' },
        { id: 'ai-config', name: 'AI配置管理' }
      ]
    },
    {
      id: 'finance-management',
      name: '财务管理',
      icon: '💰',
      expanded: false,
      subItems: [
        { id: 'revenue-stats', name: '收入统计' },
        { id: 'withdrawal-requests', name: '提现申请' },
        { id: 'payment-records', name: '支付记录' },
        { id: 'reward-management', name: '打赏管理' },
        { id: 'financial-reports', name: '财务报表' },
        { id: 'tax-management', name: '税务管理' }
      ]
    },
    {
      id: 'social-management',
      name: '社交管理',
      icon: '💬',
      expanded: false,
      subItems: [
        { id: 'comment-management', name: '评论管理' },
        { id: 'message-management', name: '消息管理' },
        { id: 'follow-management', name: '关注管理' },
        { id: 'social-analytics', name: '社交分析' },
        { id: 'community-rules', name: '社区规则' }
      ]
    },
    {
      id: 'blockchain-management',
      name: '区块链管理',
      icon: '⛓️',
      expanded: false,
      subItems: [
        { id: 'blockchain-status', name: '区块链状态' },
        { id: 'smart-contracts', name: '智能合约' },
        { id: 'gas-fee-management', name: 'Gas费管理' },
        { id: 'transaction-monitoring', name: '交易监控' },
        { id: 'wallet-management', name: '钱包管理' }
      ]
    },
    {
      id: 'security-management',
      name: '安全管理',
      icon: '🔐',
      expanded: false,
      subItems: [
        { id: 'security-logs', name: '安全日志' },
        { id: 'risk-control', name: '风控管理' },
        { id: 'fraud-detection', name: '欺诈检测' },
        { id: 'access-control', name: '访问控制' },
        { id: 'security-audit', name: '安全审计' }
      ]
    },
    {
      id: 'system-management',
      name: '系统管理',
      icon: '⚙️',
      expanded: false,
      subItems: [
        { id: 'system-config', name: '系统配置' },
        { id: 'notification-center', name: '通知中心' },
        { id: 'data-backup', name: '数据备份' },
        { id: 'performance-monitoring', name: '性能监控' },
        { id: 'api-management', name: 'API管理' },
        { id: 'log-management', name: '日志管理' }
      ]
    },
  ]);

  const [tabs, setTabs] = useState<Tab[]>([
    {
      id: 'dashboard',
      name: '平台总览',
      component: renderDashboardContent(),
      closable: false
    }
  ]);
  const [activeTab, setActiveTab] = useState('dashboard');

  // 渲染仪表板内容
  function renderDashboardContent() {
    return (
      <div className="dashboard-content">
        <div className="dashboard-header">
          <h1>平台总览</h1>
          <div className="dashboard-actions">
            <button className="action-btn">📊 刷新数据</button>
            <button className="action-btn">📢 发布公告</button>
          </div>
        </div>

        {/* 核心数据统计 */}
        <div className="stats-section">
          <h2>核心数据统计</h2>
          <div className="stats-grid">
            <div className="stat-card">
              <div className="stat-header">
                <h3>今日新增用户</h3>
                <span className="stat-badge">实时</span>
              </div>
              <p className="stat-number">1,234</p>
              <div className="stat-details">
                <span className="stat-change positive">+12%</span>
                <span className="stat-label">较昨日</span>
              </div>
            </div>
            <div className="stat-card">
              <div className="stat-header">
                <h3>活跃用户 (DAU)</h3>
                <span className="stat-badge">今日</span>
              </div>
              <p className="stat-number">56,789</p>
              <div className="stat-details">
                <span className="stat-change positive">+8%</span>
                <span className="stat-label">较昨日</span>
              </div>
            </div>
            <div className="stat-card">
              <div className="stat-header">
                <h3>AI生成任务</h3>
                <span className="stat-badge">今日</span>
              </div>
              <p className="stat-number">8,765</p>
              <div className="stat-details">
                <span className="stat-change positive">+15%</span>
                <span className="stat-label">较昨日</span>
              </div>
            </div>
            <div className="stat-card">
              <div className="stat-header">
                <h3>NFT铸造数</h3>
                <span className="stat-badge">今日</span>
              </div>
              <p className="stat-number">432</p>
              <div className="stat-details">
                <span className="stat-change positive">+23%</span>
                <span className="stat-label">较昨日</span>
              </div>
            </div>
            <div className="stat-card">
              <div className="stat-header">
                <h3>今日交易额</h3>
                <span className="stat-badge">实时</span>
              </div>
              <p className="stat-number">¥1,234,567</p>
              <div className="stat-details">
                <span className="stat-change positive">+18%</span>
                <span className="stat-label">较昨日</span>
              </div>
            </div>
            <div className="stat-card">
              <div className="stat-header">
                <h3>打赏金额</h3>
                <span className="stat-badge">今日</span>
              </div>
              <p className="stat-number">¥89,012</p>
              <div className="stat-details">
                <span className="stat-change positive">+7%</span>
                <span className="stat-label">较昨日</span>
              </div>
            </div>
          </div>
        </div>

        {/* 关键指标趋势 */}
        <div className="trends-section">
          <h2>关键指标趋势</h2>
          <div className="trends-grid">
            <div className="trend-card">
              <h3>用户增长曲线</h3>
              <div className="trend-placeholder">📈 图表区域 - 用户增长趋势图</div>
              <div className="trend-stats">
                <span>7日增长: +5.2%</span>
                <span>30日增长: +21.8%</span>
              </div>
            </div>
            <div className="trend-card">
              <h3>内容发布趋势</h3>
              <div className="trend-placeholder">📊 图表区域 - 内容发布趋势图</div>
              <div className="trend-stats">
                <span>AI生成: 65%</span>
                <span>用户原创: 35%</span>
              </div>
            </div>
            <div className="trend-card">
              <h3>交易额变化</h3>
              <div className="trend-placeholder">💰 图表区域 - 交易额变化图</div>
              <div className="trend-stats">
                <span>NFT交易: 72%</span>
                <span>打赏收入: 28%</span>
              </div>
            </div>
          </div>
        </div>

        {/* 待处理事务 */}
        <div className="pending-section">
          <h2>待处理事务提醒</h2>
          <div className="pending-grid">
            <div className="pending-card warning">
              <h3>待审核内容</h3>
              <p className="pending-number">128</p>
              <span className="pending-action">立即处理</span>
            </div>
            <div className="pending-card danger">
              <h3>待处理提现</h3>
              <p className="pending-number">45</p>
              <span className="pending-action">立即处理</span>
            </div>
            <div className="pending-card info">
              <h3>用户举报</h3>
              <p className="pending-number">23</p>
              <span className="pending-action">立即处理</span>
            </div>
            <div className="pending-card success">
              <h3>系统通知</h3>
              <p className="pending-number">5</p>
              <span className="pending-action">查看详情</span>
            </div>
          </div>
        </div>
      </div>
    );
  }

  // 渲染开发中页面
  function renderDevelopingPage(name: string) {
    return (
      <div className="dashboard-content">
        <h1>{name}</h1>
        <p>{name}功能开发中...</p>
      </div>
    );
  }

  const handleMenuClick = (menuId: string) => {
    const menuItem = menuItems.find(item => item.id === menuId);

    if (menuItem?.subItems) {
      // 如果有子菜单，切换展开状态
      setMenuItems(prev => prev.map(item =>
        item.id === menuId
          ? { ...item, expanded: !item.expanded }
          : item
      ));
    } else {
      // 如果没有子菜单，直接设置激活状态
      setMenuItems(prev => prev.map(item => ({
        ...item,
        active: item.id === menuId
      })));
    }
  };

  const handleSubMenuClick = (parentId: string, subMenuId: string, subMenuName: string) => {
    // 检查标签页是否已存在
    const existingTab = tabs.find(tab => tab.id === subMenuId);

    if (!existingTab) {
      // 创建新标签页
      let component: React.ReactNode;

      switch (subMenuId) {
        case 'user-list':
          component = <UserList />;
          break;
        default:
          component = renderDevelopingPage(subMenuName);
          break;
      }

      const newTab: Tab = {
        id: subMenuId,
        name: subMenuName,
        component,
        closable: true
      };

      setTabs(prev => [...prev, newTab]);
    }

    // 激活标签页
    setActiveTab(subMenuId);

    // 更新菜单激活状态
    setMenuItems(prev => prev.map(item => ({
      ...item,
      active: item.id === parentId
    })));
  };

  const handleTabClick = (tabId: string) => {
    setActiveTab(tabId);
  };

  const handleTabClose = (tabId: string, e: React.MouseEvent) => {
    e.stopPropagation();

    if (tabs.length <= 1) return; // 至少保留一个标签页

    const tabIndex = tabs.findIndex(tab => tab.id === tabId);
    const newTabs = tabs.filter(tab => tab.id !== tabId);

    setTabs(newTabs);

    // 如果关闭的是当前激活的标签页，激活前一个标签页
    if (activeTab === tabId) {
      const newActiveTab = tabIndex > 0 ? tabs[tabIndex - 1].id : newTabs[0].id;
      setActiveTab(newActiveTab);
    }
  };

  // 获取当前激活的标签页内容
  const getActiveTabContent = () => {
    const activeTabData = tabs.find(tab => tab.id === activeTab);
    return activeTabData ? activeTabData.component : null;
  };

  // 计算当前页面标题
  const getCurrentTitle = () => {
    const activeTabData = tabs.find(tab => tab.id === activeTab);
    return activeTabData ? activeTabData.name : '管理后台';
  };

  return (
    <div className="admin-dashboard">
      {/* 左侧菜单栏 */}
      <div className="sidebar">
        <div className="sidebar-header">
          <div className="logo">
            <span className="logo-icon">🚀</span>
            <span className="logo-text">Admin Pro</span>
          </div>
        </div>

        <nav className="sidebar-nav">
          {menuItems.map(item => (
            <div key={item.id}>
              <div
                className={`nav-item ${item.active ? 'active' : ''}`}
                onClick={() => handleMenuClick(item.id)}
              >
                <span className="nav-icon">{item.icon}</span>
                <span className="nav-text">{item.name}</span>
                {item.subItems && (
                  <span className="nav-arrow">
                    {item.expanded ? '▼' : '▶'}
                  </span>
                )}
              </div>
              {item.subItems && item.expanded && (
                <div className="submenu">
                  {item.subItems.map(subItem => (
                    <div
                      key={subItem.id}
                      className={`submenu-item ${activeTab === subItem.id ? 'active' : ''}`}
                      onClick={() => handleSubMenuClick(item.id, subItem.id, subItem.name)}
                    >
                      <span className="submenu-text">{subItem.name}</span>
                    </div>
                  ))}
                </div>
              )}
            </div>
          ))}
        </nav>

        <div className="sidebar-footer">
          <div className="user-info">
            <div className="user-avatar">👤</div>
            <div className="user-details">
              <div className="user-name">管理员</div>
              <div className="user-role">超级管理员</div>
            </div>
          </div>
          <div className="sidebar-actions">
            <button className="sidebar-action-btn">
              <span className="action-icon">🔔</span>
              <span className="action-text">通知</span>
            </button>
            <button className="sidebar-action-btn">
              <span className="action-icon">⚙️</span>
              <span className="action-text">设置</span>
            </button>
            <button className="sidebar-action-btn logout">
              <span className="action-icon">🚪</span>
              <span className="action-text">退出</span>
            </button>
          </div>
        </div>
      </div>

      {/* 右侧内容区 */}
      <div className="main-content">
        {/* 标签页栏 */}
        <div className="tab-bar">
          {tabs.map(tab => (
            <div
              key={tab.id}
              className={`tab-item ${activeTab === tab.id ? 'active' : ''}`}
              onClick={() => handleTabClick(tab.id)}
            >
              <span className="tab-name">{tab.name}</span>
              {tab.closable && (
                <button
                  className="tab-close"
                  onClick={(e) => handleTabClose(tab.id, e)}
                >
                  ×
                </button>
              )}
            </div>
          ))}
        </div>

        <div className="content-body">
          {getActiveTabContent()}
        </div>
      </div>
    </div>
  );
}