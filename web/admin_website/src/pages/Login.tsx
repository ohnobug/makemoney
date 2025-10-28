import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './Login.scss';

interface LoginForm {
  username: string;
  password: string;
}

export default function Login() {
  const navigate = useNavigate();
  const [formData, setFormData] = useState<LoginForm>({
    username: '',
    password: '',
  });
  const [loading, setLoading] = useState(false);

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);

    // 模拟登录请求
    try {
      await new Promise(resolve => setTimeout(resolve, 1000));
      console.log('登录信息:', formData);
      // 这里可以添加实际的登录逻辑
      // 登录成功后跳转到管理后台
      navigate('/dashboard');
    } catch (error) {
      console.error('登录失败:', error);
      alert('登录失败，请检查用户名和密码');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="login-page">
      {/* 左侧品牌展示区 */}
      <div className="branding-panel">
        <div className="branding-content">
          <div className="brand-logo">
            <div className="logo-icon">🚀</div>
            <h1 className="brand-name">Admin Pro</h1>
          </div>
          <div className="brand-description">
            <h2 className="brand-title">企业级管理后台系统</h2>
            <p className="brand-subtitle">
              为您提供专业、高效、安全的后台管理解决方案
            </p>
          </div>
          <div className="features-list">
            <div className="feature-item">
              <span className="feature-icon">✓</span>
              <span>数据可视化分析</span>
            </div>
            <div className="feature-item">
              <span className="feature-icon">✓</span>
              <span>多维度权限管理</span>
            </div>
            <div className="feature-item">
              <span className="feature-icon">✓</span>
              <span>实时监控告警</span>
            </div>
            <div className="feature-item">
              <span className="feature-icon">✓</span>
              <span>智能报表生成</span>
            </div>
          </div>
        </div>
      </div>

      {/* 右侧登录表单区 */}
      <div className="login-panel">
        <div className="login-container">
          <div className="login-header">
            <h1 className="login-title">欢迎回来</h1>
            <p className="login-subtitle">请登录您的账户</p>
          </div>

          <form onSubmit={handleSubmit} className="login-form">
            <div className="form-group">
              <label htmlFor="username" className="form-label">
                用户名
              </label>
              <input
                type="text"
                id="username"
                name="username"
                value={formData.username}
                onChange={handleInputChange}
                className="form-input"
                placeholder="请输入用户名"
                required
              />
            </div>

            <div className="form-group">
              <label htmlFor="password" className="form-label">
                密码
              </label>
              <input
                type="password"
                id="password"
                name="password"
                value={formData.password}
                onChange={handleInputChange}
                className="form-input"
                placeholder="请输入密码"
                required
              />
            </div>

            <div className="form-options">
              <label className="remember-me">
                <input type="checkbox" />
                <span>记住我</span>
              </label>
              <a href="#" className="forgot-password">忘记密码？</a>
            </div>

            <button
              type="submit"
              className={`login-button ${loading ? 'loading' : ''}`}
              disabled={loading}
            >
              {loading ? '登录中...' : '登录'}
            </button>
          </form>

          <div className="login-footer">
            <p className="footer-text">
              还没有账户？<a href="#" className="footer-link">立即注册</a>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}