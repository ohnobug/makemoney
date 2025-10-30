import { useState, useMemo } from 'react';
import './UserList.scss';

interface User {
  id: string;
  avatar: string;
  nickname: string;
  username: string;
  email: string;
  phone: string;
  status: 'active' | 'inactive' | 'banned';
  vipLevel: number;
  registrationDate: string;
  lastLogin: {
    time: string;
    ip: string;
  };
  statistics: {
    worksCount: number;
    collectionsCount: number;
    likesCount: number;
    followersCount: number;
    followingCount: number;
  };
  wallet: {
    balance: number;
    nftCount: number;
  };
}

export default function UserList() {
  const [users, setUsers] = useState<User[]>([
    {
      id: '1',
      avatar: '👤',
      nickname: '创意设计师',
      username: 'designer001',
      email: 'designer001@example.com',
      phone: '138****1234',
      status: 'active',
      vipLevel: 3,
      registrationDate: '2024-01-15',
      lastLogin: {
        time: '2024-10-28 14:30:25',
        ip: '192.168.1.100'
      },
      statistics: {
        worksCount: 156,
        collectionsCount: 89,
        likesCount: 2345,
        followersCount: 1234,
        followingCount: 567
      },
      wallet: {
        balance: 12800,
        nftCount: 23
      }
    },
    {
      id: '2',
      avatar: '👩‍💻',
      nickname: 'AI艺术家',
      username: 'ai_artist',
      email: 'ai_artist@example.com',
      phone: '139****5678',
      status: 'active',
      vipLevel: 5,
      registrationDate: '2024-02-20',
      lastLogin: {
        time: '2024-10-28 13:15:42',
        ip: '192.168.1.101'
      },
      statistics: {
        worksCount: 289,
        collectionsCount: 156,
        likesCount: 5678,
        followersCount: 2345,
        followingCount: 789
      },
      wallet: {
        balance: 25600,
        nftCount: 45
      }
    },
    {
      id: '3',
      avatar: '🎨',
      nickname: '数字创作者',
      username: 'digital_creator',
      email: 'digital_creator@example.com',
      phone: '137****9012',
      status: 'inactive',
      vipLevel: 2,
      registrationDate: '2024-03-10',
      lastLogin: {
        time: '2024-10-27 09:45:18',
        ip: '192.168.1.102'
      },
      statistics: {
        worksCount: 78,
        collectionsCount: 45,
        likesCount: 1234,
        followersCount: 678,
        followingCount: 234
      },
      wallet: {
        balance: 5600,
        nftCount: 12
      }
    },
    {
      id: '4',
      avatar: '🤖',
      nickname: '智能创作者',
      username: 'smart_creator',
      email: 'smart_creator@example.com',
      phone: '136****3456',
      status: 'banned',
      vipLevel: 1,
      registrationDate: '2024-04-05',
      lastLogin: {
        time: '2024-10-26 16:20:33',
        ip: '192.168.1.103'
      },
      statistics: {
        worksCount: 34,
        collectionsCount: 23,
        likesCount: 456,
        followersCount: 234,
        followingCount: 123
      },
      wallet: {
        balance: 2300,
        nftCount: 8
      }
    },
    {
      id: '5',
      avatar: '🌟',
      nickname: '明星创作者',
      username: 'star_creator',
      email: 'star_creator@example.com',
      phone: '135****7890',
      status: 'active',
      vipLevel: 4,
      registrationDate: '2024-05-12',
      lastLogin: {
        time: '2024-10-28 10:05:27',
        ip: '192.168.1.104'
      },
      statistics: {
        worksCount: 432,
        collectionsCount: 267,
        likesCount: 9876,
        followersCount: 4567,
        followingCount: 1234
      },
      wallet: {
        balance: 18900,
        nftCount: 67
      }
    }
  ]);

  const [selectedUser, setSelectedUser] = useState<User | null>(null);
  const [showUserDetail, setShowUserDetail] = useState(false);
  const [searchQuery, setSearchQuery] = useState('');
  const [currentPage, setCurrentPage] = useState(1);
  const [pageSize, setPageSize] = useState(10);

  const handleViewUser = (user: User) => {
    setSelectedUser(user);
    setShowUserDetail(true);
  };

  const handleCloseDetail = () => {
    setShowUserDetail(false);
    setSelectedUser(null);
  };

  const handleSearchChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setSearchQuery(e.target.value);
  };

  // 过滤用户列表
  const filteredUsers = useMemo(() => {
    if (!searchQuery.trim()) {
      return users;
    }

    const query = searchQuery.toLowerCase();
    return users.filter(user =>
      user.nickname.toLowerCase().includes(query) ||
      user.username.toLowerCase().includes(query) ||
      user.email.toLowerCase().includes(query) ||
      user.phone.includes(query)
    );
  }, [users, searchQuery]);

  // 分页计算
  const totalUsers = filteredUsers.length;
  const totalPages = Math.ceil(totalUsers / pageSize);
  const startIndex = (currentPage - 1) * pageSize;
  const endIndex = startIndex + pageSize;
  const paginatedUsers = filteredUsers.slice(startIndex, endIndex);

  // 分页处理函数
  const handlePageChange = (page: number) => {
    setCurrentPage(page);
  };

  const handlePageSizeChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
    const newSize = parseInt(e.target.value);
    setPageSize(newSize);
    setCurrentPage(1); // 重置到第一页
  };

  const getStatusConfig = (status: string) => {
    switch (status) {
      case 'active':
        return {
          text: '活跃',
          bgColor: '#D1FAE5',
          textColor: '#065F46',
          icon: '✓'
        };
      case 'inactive':
        return {
          text: '非活跃',
          bgColor: '#F3F4F6',
          textColor: '#6B7280',
          icon: '⏸️'
        };
      case 'banned':
        return {
          text: '已封禁',
          bgColor: '#FEE2E2',
          textColor: '#B91C1C',
          icon: '⚠️'
        };
      default:
        return {
          text: '未知',
          bgColor: '#F3F4F6',
          textColor: '#6B7280',
          icon: '?'
        };
    }
  };

  return (
    <div className="user-list-page">
      <div className="page-header">
        <div className="search-section">
          <div className="search-input-container">
            <span className="search-icon">🔍</span>
            <input
              type="text"
              className="search-input"
              placeholder="搜索用户昵称、用户名、邮箱或手机号..."
              value={searchQuery}
              onChange={handleSearchChange}
            />
          </div>
        </div>
        <div className="header-actions">
          <button className="action-btn primary">
            <span>➕</span>
            添加用户
          </button>
          <button className="action-btn">
            <span>📊</span>
            导出数据
          </button>
          <button className="action-btn">
            <span>⚙️</span>
            高级搜索
          </button>
        </div>
      </div>

      <div className="page-content">
        <div className="user-table-container">
          <table className="user-table">
            <thead>
              <tr>
                <th>用户信息</th>
                <th>账号信息</th>
                <th>创作统计</th>
                <th>登录信息</th>
                <th>钱包信息</th>
                <th>状态</th>
                <th>操作</th>
              </tr>
            </thead>
            <tbody>
              {paginatedUsers.map(user => (
                <tr key={user.id}>
                  <td>
                    <div className="user-info-cell">
                      <div className="user-avatar">{user.avatar}</div>
                      <div className="user-details">
                        <div className="user-nickname">{user.nickname}</div>
                        <div className="user-username">@{user.username}</div>
                      </div>
                    </div>
                  </td>
                  <td>
                    <div className="account-info-cell">
                      <div className="info-line">
                        <span className="label">邮箱:</span>
                        <span className="value">{user.email}</span>
                      </div>
                      <div className="info-line">
                        <span className="label">手机:</span>
                        <span className="value">{user.phone}</span>
                      </div>
                      <div className="info-line">
                        <span className="label">注册:</span>
                        <span className="value">{user.registrationDate}</span>
                      </div>
                    </div>
                  </td>
                  <td>
                    <div className="statistics-grid">
                      <div className="stat-item">
                        <div className="stat-number">{user.statistics.worksCount}</div>
                        <div className="stat-label">作品</div>
                      </div>
                      <div className="stat-item">
                        <div className="stat-number">{user.statistics.collectionsCount}</div>
                        <div className="stat-label">收藏</div>
                      </div>
                      <div className="stat-item">
                        <div className="stat-number">{user.statistics.likesCount}</div>
                        <div className="stat-label">点赞</div>
                      </div>
                      <div className="stat-item">
                        <div className="stat-number">{user.statistics.followersCount}</div>
                        <div className="stat-label">粉丝</div>
                      </div>
                    </div>
                  </td>
                  <td>
                    <div className="login-info-cell">
                      <div className="info-line">
                        <span className="label">时间:</span>
                        <span className="value">{user.lastLogin.time}</span>
                      </div>
                      <div className="info-line">
                        <span className="label">IP:</span>
                        <span className="value">{user.lastLogin.ip}</span>
                      </div>
                    </div>
                  </td>
                  <td>
                    <div className="wallet-info-cell">
                      <div className="info-line">
                        <span className="label">余额:</span>
                        <span className="value balance">¥{user.wallet.balance.toLocaleString()}</span>
                      </div>
                      <div className="info-line">
                        <span className="label">NFT:</span>
                        <span className="value">{user.wallet.nftCount}个</span>
                      </div>
                      <div className="info-line">
                        <span className="label">VIP:</span>
                        <span className="value vip-level" title={`VIP 等级: ${user.vipLevel}`}>
                          {'⭐'.repeat(user.vipLevel)}
                        </span>
                      </div>
                    </div>
                  </td>
                  <td>
                    <div className="status-cell">
                      <span
                        className="status-badge"
                        style={{
                          backgroundColor: getStatusConfig(user.status).bgColor,
                          color: getStatusConfig(user.status).textColor
                        }}
                      >
                        <span className="status-icon">{getStatusConfig(user.status).icon}</span>
                        {getStatusConfig(user.status).text}
                      </span>
                    </div>
                  </td>
                  <td>
                    <div className="action-cell">
                      <button
                        className="action-btn text-btn view-btn"
                        onClick={() => handleViewUser(user)}
                      >
                        查看
                      </button>
                      <button className="action-btn text-btn edit-btn">编辑</button>
                      <div className="dropdown-container">
                        <button className="action-btn icon-btn more-btn">⋯</button>
                        <div className="dropdown-menu">
                          <button className="dropdown-item">冻结账户</button>
                          <button className="dropdown-item danger">封禁</button>
                        </div>
                      </div>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        {/* 分页组件 */}
        <div className="pagination-section">
          <div className="pagination-info">
            显示第 {startIndex + 1}-{Math.min(endIndex, totalUsers)} 条，共 {totalUsers} 条记录
          </div>
          <div className="pagination-controls">
            <div className="page-size-selector">
              <span>每页显示：</span>
              <select value={pageSize} onChange={handlePageSizeChange}>
                <option value={5}>5</option>
                <option value={10}>10</option>
                <option value={20}>20</option>
                <option value={50}>50</option>
              </select>
            </div>
            <div className="pagination-buttons">
              <button
                className="pagination-btn"
                disabled={currentPage === 1}
                onClick={() => handlePageChange(currentPage - 1)}
              >
                上一页
              </button>

              {/* 页码按钮 */}
              {Array.from({ length: totalPages }, (_, i) => i + 1).map(page => (
                <button
                  key={page}
                  className={`pagination-btn ${currentPage === page ? 'active' : ''}`}
                  onClick={() => handlePageChange(page)}
                >
                  {page}
                </button>
              ))}

              <button
                className="pagination-btn"
                disabled={currentPage === totalPages}
                onClick={() => handlePageChange(currentPage + 1)}
              >
                下一页
              </button>
            </div>
          </div>
        </div>
      </div>

      {/* 用户详情弹窗 */}
      {showUserDetail && selectedUser && (
        <div className="user-detail-modal">
          <div className="modal-overlay" onClick={handleCloseDetail}></div>
          <div className="modal-content">
            <div className="modal-header">
              <h2>用户详情</h2>
              <button className="close-btn" onClick={handleCloseDetail}>×</button>
            </div>
            <div className="modal-body">
              <div className="user-detail-section">
                <div className="user-basic-info">
                  <div className="user-avatar-large">{selectedUser.avatar}</div>
                  <div className="user-main-info">
                    <h3>{selectedUser.nickname}</h3>
                    <p>@{selectedUser.username}</p>
                    <div className="user-status">
                      <span
                        className="status-badge"
                        style={{
                          backgroundColor: getStatusConfig(selectedUser.status).bgColor,
                          color: getStatusConfig(selectedUser.status).textColor
                        }}
                      >
                        <span className="status-icon">{getStatusConfig(selectedUser.status).icon}</span>
                        {getStatusConfig(selectedUser.status).text}
                      </span>
                    </div>
                  </div>
                </div>
              </div>

              <div className="user-detail-grid">
                <div className="detail-group">
                  <h4>账号信息</h4>
                  <div className="detail-item">
                    <span className="label">邮箱:</span>
                    <span className="value">{selectedUser.email}</span>
                  </div>
                  <div className="detail-item">
                    <span className="label">手机:</span>
                    <span className="value">{selectedUser.phone}</span>
                  </div>
                  <div className="detail-item">
                    <span className="label">注册时间:</span>
                    <span className="value">{selectedUser.registrationDate}</span>
                  </div>
                </div>

                <div className="detail-group">
                  <h4>创作统计</h4>
                  <div className="detail-item">
                    <span className="label">作品数量:</span>
                    <span className="value">{selectedUser.statistics.worksCount}</span>
                  </div>
                  <div className="detail-item">
                    <span className="label">收藏数量:</span>
                    <span className="value">{selectedUser.statistics.collectionsCount}</span>
                  </div>
                  <div className="detail-item">
                    <span className="label">点赞数量:</span>
                    <span className="value">{selectedUser.statistics.likesCount}</span>
                  </div>
                  <div className="detail-item">
                    <span className="label">粉丝数量:</span>
                    <span className="value">{selectedUser.statistics.followersCount}</span>
                  </div>
                </div>

                <div className="detail-group">
                  <h4>登录信息</h4>
                  <div className="detail-item">
                    <span className="label">最近登录:</span>
                    <span className="value">{selectedUser.lastLogin.time}</span>
                  </div>
                  <div className="detail-item">
                    <span className="label">登录IP:</span>
                    <span className="value">{selectedUser.lastLogin.ip}</span>
                  </div>
                </div>

                <div className="detail-group">
                  <h4>钱包信息</h4>
                  <div className="detail-item">
                    <span className="label">账户余额:</span>
                    <span className="value">¥{selectedUser.wallet.balance.toLocaleString()}</span>
                  </div>
                  <div className="detail-item">
                    <span className="label">NFT数量:</span>
                    <span className="value">{selectedUser.wallet.nftCount}个</span>
                  </div>
                  <div className="detail-item">
                    <span className="label">VIP等级:</span>
                    <span className="value vip-level">
                      {'⭐'.repeat(selectedUser.vipLevel)}
                    </span>
                  </div>
                </div>
              </div>
            </div>
            <div className="modal-footer">
              <button className="btn secondary" onClick={handleCloseDetail}>关闭</button>
              <button className="btn primary">编辑用户</button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}