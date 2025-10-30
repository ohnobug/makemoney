import { useState, useEffect } from 'react';
import './InstituteManagement.scss';

interface Institute {
  id: string;
  name: string;
  code: string;
  type: 'university' | 'college' | 'department';
  establishedYear: number;
  location: string;
  website?: string;
  description: string;
  status: 'active' | 'inactive' | 'suspended';
  dean: string;
  contactEmail: string;
  contactPhone: string;
  studentCount: number;
  teacherCount: number;
  courseCount: number;
  createdAt: string;
  updatedAt: string;
}

interface InstituteFormData {
  name: string;
  code: string;
  type: 'university' | 'college' | 'department';
  establishedYear: string;
  location: string;
  website: string;
  description: string;
  status: 'active' | 'inactive' | 'suspended';
  dean: string;
  contactEmail: string;
  contactPhone: string;
}

export default function InstituteManagement() {
  const [institutes, setInstitutes] = useState<Institute[]>([]);
  const [loading, setLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [editingInstitute, setEditingInstitute] = useState<Institute | null>(null);
  const [searchTerm, setSearchTerm] = useState('');
  const [filterType, setFilterType] = useState<string>('all');
  const [filterStatus, setFilterStatus] = useState<string>('all');
  const [currentPage, setCurrentPage] = useState(1);
  const [pageSize] = useState(10);

  // 表单数据
  const [formData, setFormData] = useState<InstituteFormData>({
    name: '',
    code: '',
    type: 'university',
    establishedYear: '',
    location: '',
    website: '',
    description: '',
    status: 'active',
    dean: '',
    contactEmail: '',
    contactPhone: ''
  });

  // 模拟数据
  useEffect(() => {
    const mockInstitutes: Institute[] = [
      {
        id: '1',
        name: '北京大学',
        code: 'PKU',
        type: 'university',
        establishedYear: 1898,
        location: '北京市',
        website: 'https://www.pku.edu.cn',
        description: '中华人民共和国顶尖大学之一',
        status: 'active',
        dean: '郝平',
        contactEmail: 'admin@pku.edu.cn',
        contactPhone: '010-62751201',
        studentCount: 45000,
        teacherCount: 8000,
        courseCount: 2500,
        createdAt: '2024-01-15T10:30:00Z',
        updatedAt: '2024-10-28T15:20:00Z'
      },
      {
        id: '2',
        name: '清华大学',
        code: 'THU',
        type: 'university',
        establishedYear: 1911,
        location: '北京市',
        website: 'https://www.tsinghua.edu.cn',
        description: '中国顶尖综合性研究型大学',
        status: 'active',
        dean: '王希勤',
        contactEmail: 'admin@tsinghua.edu.cn',
        contactPhone: '010-62793001',
        studentCount: 42000,
        teacherCount: 7500,
        courseCount: 2300,
        createdAt: '2024-01-16T09:15:00Z',
        updatedAt: '2024-10-25T11:45:00Z'
      },
      {
        id: '3',
        name: '计算机科学与技术学院',
        code: 'CS',
        type: 'college',
        establishedYear: 2001,
        location: '北京市',
        website: '',
        description: '专注于计算机科学研究与人才培养',
        status: 'active',
        dean: '李明',
        contactEmail: 'cs@university.edu.cn',
        contactPhone: '010-12345678',
        studentCount: 2000,
        teacherCount: 120,
        courseCount: 85,
        createdAt: '2024-02-01T14:20:00Z',
        updatedAt: '2024-10-20T10:30:00Z'
      },
      {
        id: '4',
        name: '复旦大学',
        code: 'FDU',
        type: 'university',
        establishedYear: 1905,
        location: '上海市',
        website: 'https://www.fudan.edu.cn',
        description: '中国著名综合性研究型大学',
        status: 'inactive',
        dean: '金力',
        contactEmail: 'admin@fudan.edu.cn',
        contactPhone: '021-65642222',
        studentCount: 38000,
        teacherCount: 6500,
        courseCount: 2000,
        createdAt: '2024-01-20T16:45:00Z',
        updatedAt: '2024-09-15T14:25:00Z'
      }
    ];

    setTimeout(() => {
      setInstitutes(mockInstitutes);
      setLoading(false);
    }, 1000);
  }, []);

  // 过滤和搜索
  const filteredInstitutes = institutes.filter(institute => {
    const matchesSearch = institute.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         institute.code.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         institute.location.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesType = filterType === 'all' || institute.type === filterType;
    const matchesStatus = filterStatus === 'all' || institute.status === filterStatus;

    return matchesSearch && matchesType && matchesStatus;
  });

  // 分页
  const totalPages = Math.ceil(filteredInstitutes.length / pageSize);
  const paginatedInstitutes = filteredInstitutes.slice(
    (currentPage - 1) * pageSize,
    currentPage * pageSize
  );

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    if (editingInstitute) {
      // 编辑模式
      setInstitutes(prev => prev.map(institute =>
        institute.id === editingInstitute.id
          ? {
              ...institute,
              ...formData,
              establishedYear: parseInt(formData.establishedYear),
              updatedAt: new Date().toISOString()
            }
          : institute
      ));
    } else {
      // 新增模式
      const newInstitute: Institute = {
        id: Date.now().toString(),
        ...formData,
        establishedYear: parseInt(formData.establishedYear),
        studentCount: 0,
        teacherCount: 0,
        courseCount: 0,
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString()
      };
      setInstitutes(prev => [...prev, newInstitute]);
    }

    handleCloseModal();
  };

  const handleEdit = (institute: Institute) => {
    setEditingInstitute(institute);
    setFormData({
      name: institute.name,
      code: institute.code,
      type: institute.type,
      establishedYear: institute.establishedYear.toString(),
      location: institute.location,
      website: institute.website || '',
      description: institute.description,
      status: institute.status,
      dean: institute.dean,
      contactEmail: institute.contactEmail,
      contactPhone: institute.contactPhone
    });
    setShowModal(true);
  };

  const handleDelete = (id: string) => {
    if (window.confirm('确定要删除这个学院吗？')) {
      setInstitutes(prev => prev.filter(institute => institute.id !== id));
    }
  };

  const handleStatusChange = (id: string, status: 'active' | 'inactive' | 'suspended') => {
    setInstitutes(prev => prev.map(institute =>
      institute.id === id
        ? { ...institute, status, updatedAt: new Date().toISOString() }
        : institute
    ));
  };

  const handleCloseModal = () => {
    setShowModal(false);
    setEditingInstitute(null);
    setFormData({
      name: '',
      code: '',
      type: 'university',
      establishedYear: '',
      location: '',
      website: '',
      description: '',
      status: 'active',
      dean: '',
      contactEmail: '',
      contactPhone: ''
    });
  };

  const getTypeLabel = (type: string) => {
    const labels = {
      university: '大学',
      college: '学院',
      department: '系'
    };
    return labels[type as keyof typeof labels] || type;
  };

  const getStatusBadge = (status: string) => {
    const badges = {
      active: { className: 'status-active', text: '正常' },
      inactive: { className: 'status-inactive', text: '停用' },
      suspended: { className: 'status-suspended', text: '暂停' }
    };
    return badges[status as keyof typeof badges];
  };

  if (loading) {
    return (
      <div className="institute-management">
        <div className="loading">
          <div className="loading-spinner"></div>
          <p>加载中...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="institute-management">
      <div className="page-header">
        <h1>学院管理</h1>
        <div className="header-actions">
          <button
            className="btn-primary"
            onClick={() => setShowModal(true)}
          >
            ➕ 新增学院
          </button>
        </div>
      </div>

      {/* 搜索和过滤器 */}
      <div className="filters-section">
        <div className="search-box">
          <input
            type="text"
            placeholder="搜索学院名称、代码或地点..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="search-input"
          />
        </div>

        <div className="filters">
          <select
            value={filterType}
            onChange={(e) => setFilterType(e.target.value)}
            className="filter-select"
          >
            <option value="all">所有类型</option>
            <option value="university">大学</option>
            <option value="college">学院</option>
            <option value="department">系</option>
          </select>

          <select
            value={filterStatus}
            onChange={(e) => setFilterStatus(e.target.value)}
            className="filter-select"
          >
            <option value="all">所有状态</option>
            <option value="active">正常</option>
            <option value="inactive">停用</option>
            <option value="suspended">暂停</option>
          </select>
        </div>
      </div>

      {/* 统计卡片 */}
      <div className="stats-cards">
        <div className="stat-card">
          <div className="stat-icon">🏛️</div>
          <div className="stat-content">
            <h3>总学院数</h3>
            <p className="stat-number">{institutes.length}</p>
          </div>
        </div>
        <div className="stat-card">
          <div className="stat-icon">✅</div>
          <div className="stat-content">
            <h3>正常运营</h3>
            <p className="stat-number">{institutes.filter(i => i.status === 'active').length}</p>
          </div>
        </div>
        <div className="stat-card">
          <div className="stat-icon">👨‍🎓</div>
          <div className="stat-content">
            <h3>总学生数</h3>
            <p className="stat-number">{institutes.reduce((sum, i) => sum + i.studentCount, 0).toLocaleString()}</p>
          </div>
        </div>
        <div className="stat-card">
          <div className="stat-icon">👨‍🏫</div>
          <div className="stat-content">
            <h3>总教师数</h3>
            <p className="stat-number">{institutes.reduce((sum, i) => sum + i.teacherCount, 0).toLocaleString()}</p>
          </div>
        </div>
      </div>

      {/* 学院列表 */}
      <div className="institutes-table-container">
        <table className="institutes-table">
          <thead>
            <tr>
              <th>学院信息</th>
              <th>类型</th>
              <th>位置</th>
              <th>状态</th>
              <th>统计</th>
              <th>负责人</th>
              <th>联系方式</th>
              <th>操作</th>
            </tr>
          </thead>
          <tbody>
            {paginatedInstitutes.map(institute => (
              <tr key={institute.id}>
                <td>
                  <div className="institute-info">
                    <div className="institute-header">
                      <h4>{institute.name}</h4>
                      <span className="institute-code">{institute.code}</span>
                    </div>
                    <p className="institute-description">{institute.description}</p>
                    <p className="institute-year">成立于 {institute.establishedYear} 年</p>
                  </div>
                </td>
                <td>
                  <span className="type-badge">{getTypeLabel(institute.type)}</span>
                </td>
                <td>{institute.location}</td>
                <td>
                  <span className={`status-badge ${getStatusBadge(institute.status).className}`}>
                    {getStatusBadge(institute.status).text}
                  </span>
                </td>
                <td>
                  <div className="stats-info">
                    <div>👨‍🎓 {institute.studentCount.toLocaleString()}</div>
                    <div>👨‍🏫 {institute.teacherCount.toLocaleString()}</div>
                    <div>📚 {institute.courseCount}</div>
                  </div>
                </td>
                <td>
                  <div className="dean-info">
                    <div className="dean-name">{institute.dean}</div>
                  </div>
                </td>
                <td>
                  <div className="contact-info">
                    <div className="contact-item">📧 {institute.contactEmail}</div>
                    <div className="contact-item">📱 {institute.contactPhone}</div>
                  </div>
                </td>
                <td>
                  <div className="actions">
                    <button
                      className="action-btn edit"
                      onClick={() => handleEdit(institute)}
                      title="编辑"
                    >
                      ✏️
                    </button>
                    <select
                      value={institute.status}
                      onChange={(e) => handleStatusChange(institute.id, e.target.value as 'active' | 'inactive' | 'suspended')}
                      className="status-select"
                      title="更改状态"
                    >
                      <option value="active">正常</option>
                      <option value="inactive">停用</option>
                      <option value="suspended">暂停</option>
                    </select>
                    <button
                      className="action-btn delete"
                      onClick={() => handleDelete(institute.id)}
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
            第 {currentPage} 页，共 {totalPages} 页 ({filteredInstitutes.length} 条记录)
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

      {/* 添加/编辑学院弹窗 */}
      {showModal && (
        <div className="modal-overlay">
          <div className="modal">
            <div className="modal-header">
              <h2>{editingInstitute ? '编辑学院' : '新增学院'}</h2>
              <button className="modal-close" onClick={handleCloseModal}>
                ×
              </button>
            </div>

            <form onSubmit={handleSubmit} className="modal-form">
              <div className="form-grid">
                <div className="form-group">
                  <label>学院名称 *</label>
                  <input
                    type="text"
                    required
                    value={formData.name}
                    onChange={(e) => setFormData(prev => ({ ...prev, name: e.target.value }))}
                  />
                </div>

                <div className="form-group">
                  <label>学院代码 *</label>
                  <input
                    type="text"
                    required
                    value={formData.code}
                    onChange={(e) => setFormData(prev => ({ ...prev, code: e.target.value }))}
                  />
                </div>

                <div className="form-group">
                  <label>机构类型 *</label>
                  <select
                    value={formData.type}
                    onChange={(e) => setFormData(prev => ({ ...prev, type: e.target.value as any }))}
                    required
                  >
                    <option value="university">大学</option>
                    <option value="college">学院</option>
                    <option value="department">系</option>
                  </select>
                </div>

                <div className="form-group">
                  <label>成立年份 *</label>
                  <input
                    type="number"
                    required
                    min="1800"
                    max={new Date().getFullYear()}
                    value={formData.establishedYear}
                    onChange={(e) => setFormData(prev => ({ ...prev, establishedYear: e.target.value }))}
                  />
                </div>

                <div className="form-group">
                  <label>所在地点 *</label>
                  <input
                    type="text"
                    required
                    value={formData.location}
                    onChange={(e) => setFormData(prev => ({ ...prev, location: e.target.value }))}
                  />
                </div>

                <div className="form-group">
                  <label>官方网站</label>
                  <input
                    type="url"
                    value={formData.website}
                    onChange={(e) => setFormData(prev => ({ ...prev, website: e.target.value }))}
                    placeholder="https://example.com"
                  />
                </div>

                <div className="form-group">
                  <label>负责人姓名 *</label>
                  <input
                    type="text"
                    required
                    value={formData.dean}
                    onChange={(e) => setFormData(prev => ({ ...prev, dean: e.target.value }))}
                  />
                </div>

                <div className="form-group">
                  <label>联系邮箱 *</label>
                  <input
                    type="email"
                    required
                    value={formData.contactEmail}
                    onChange={(e) => setFormData(prev => ({ ...prev, contactEmail: e.target.value }))}
                  />
                </div>

                <div className="form-group">
                  <label>联系电话 *</label>
                  <input
                    type="tel"
                    required
                    value={formData.contactPhone}
                    onChange={(e) => setFormData(prev => ({ ...prev, contactPhone: e.target.value }))}
                  />
                </div>

                <div className="form-group">
                  <label>状态</label>
                  <select
                    value={formData.status}
                    onChange={(e) => setFormData(prev => ({ ...prev, status: e.target.value as any }))}
                  >
                    <option value="active">正常</option>
                    <option value="inactive">停用</option>
                    <option value="suspended">暂停</option>
                  </select>
                </div>

                <div className="form-group full-width">
                  <label>学院描述</label>
                  <textarea
                    rows={4}
                    value={formData.description}
                    onChange={(e) => setFormData(prev => ({ ...prev, description: e.target.value }))}
                    placeholder="请输入学院描述信息..."
                  />
                </div>
              </div>

              <div className="modal-footer">
                <button type="button" className="btn-secondary" onClick={handleCloseModal}>
                  取消
                </button>
                <button type="submit" className="btn-primary">
                  {editingInstitute ? '更新' : '创建'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}