# reward_api/models.py

from sqlalchemy import (
    CheckConstraint,
    Column,
    Integer,
    BigInteger,
    String,
    TIMESTAMP,
    Numeric,
    ForeignKey,
    func
)
from sqlalchemy.orm import relationship
# 从我们分离出的 database.py 文件中导入 Base
from .database import Base

# --- 模型优化：创建一个 Mixin 类来统一定义表参数 ---
class TableArgsMixin:
    """
    一个可复用的 Mixin 类，为所有表提供通用的 __table_args__。
    这确保了所有表都使用 InnoDB 引擎和 utf8mb4 字符集。
    """
    __table_args__ = {
        'mysql_engine': 'InnoDB',      # 明确指定使用 InnoDB 引擎
        'mysql_charset': 'utf8mb4',     # 支持 emoji 等特殊字符
        'mysql_collate': 'utf8mb4_0900_ai_ci'
    }

# ----------------------------------------------------------------
# 1. 奖励模块 - 公排配置表
# ----------------------------------------------------------------
class RewardArtRewardConfig(Base, TableArgsMixin):
    """ORM模型：艺术品公排的全局配置。"""
    __tablename__ = "reward_art_reward_config"
    __table_args__ = (
        CheckConstraint("multiple > 1", name="ck_reward_art_reward_config_multiple"),
        {
            **TableArgsMixin.__table_args__,
            'comment': '[奖励] 公排配置表'
        }
    )

    id = Column(Integer, primary_key=True, comment="自增主键")
    art_id = Column(Integer, unique=True, nullable=False, comment="艺术品ID")
    exit_layer = Column(Integer, nullable=False, comment="出局层级")
    multiple = Column(Numeric(10, 2), nullable=False, comment="倍数")
    
    reward_rate_1 = Column(Numeric(10, 5), nullable=False, server_default='0.0', comment="升1奖励比例")
    reward_rate_2 = Column(Numeric(10, 5), nullable=False, server_default='0.0', comment="升2奖励比例")
    reward_rate_3 = Column(Numeric(10, 5), nullable=False, server_default='0.0', comment="升3奖励比例")
    reward_rate_4 = Column(Numeric(10, 5), nullable=False, server_default='0.0', comment="升4奖励比例")
    reward_rate_5 = Column(Numeric(10, 5), nullable=False, server_default='0.0', comment="升5奖励比例")
    reward_rate_6 = Column(Numeric(10, 5), nullable=False, server_default='0.0', comment="升6奖励比例")
    reward_rate_7 = Column(Numeric(10, 5), nullable=False, server_default='0.0', comment="升7奖励比例")
    reward_rate_8 = Column(Numeric(10, 5), nullable=False, server_default='0.0', comment="升8奖励比例")
    reward_rate_9 = Column(Numeric(10, 5), nullable=False, server_default='0.0', comment="升9奖励比例")
    reward_rate_10 = Column(Numeric(10, 5), nullable=False, server_default='0.0', comment="升10奖励比例")

    created_at = Column(TIMESTAMP, nullable=False, server_default=func.now(), comment="创建时间")
    updated_at = Column(TIMESTAMP, nullable=False, server_default=func.now(), onupdate=func.now(), comment="更新时间")
    summaries = relationship("RewardLayerSummary", back_populates="config")


# ----------------------------------------------------------------
# 2. 奖励模块 - 升级概况表
# ----------------------------------------------------------------
class RewardLayerSummary(Base, TableArgsMixin):
    """ORM模型：记录每个艺术品在不同层级的用户数量统计。"""
    __tablename__ = "reward_layer_summary"
    # 将唯一约束和表参数合并到一个元组中
    __table_args__ = (
        # UniqueConstraint('art_id', 'layer_capacity', name='uk_art_layer'),
        {**TableArgsMixin.__table_args__, 'comment': '[奖励] 升级概况表'}
    )

    id = Column(BigInteger, primary_key=True, comment="自增主键")
    art_id = Column(Integer, ForeignKey("reward_art_reward_config.art_id", ondelete="CASCADE"), nullable=False, comment="艺术品ID")
    relative_layer = Column(Integer, nullable=False, comment="相对层数")
    layer_capacity = Column(BigInteger, nullable=False, comment="绝对层数 (层级容量)")
    actual_user_count = Column(BigInteger, nullable=False, server_default='0', comment="真实人数")
    calculated_user_count = Column(Numeric(20, 5), nullable=False, server_default='0', comment="计算用人数")
    updated_at = Column(TIMESTAMP, nullable=False, server_default=func.now(), onupdate=func.now(), comment="更新时间")

    config = relationship("RewardArtRewardConfig", back_populates="summaries")



# ----------------------------------------------------------------
# 3. 奖励模块 - 点赞记录表
# ----------------------------------------------------------------
class RewardEndorsementLog(Base, TableArgsMixin):
    """ORM模型：记录用户的每一次点赞或参与行为。"""
    __tablename__ = "reward_endorsement_log"
    __table_args__ = {
        **TableArgsMixin.__table_args__,
        'comment': '[奖励] 点赞记录表'
    }

    id = Column(BigInteger, primary_key=True, comment="记录ID")
    art_id = Column(Integer, nullable=False, index=True, comment="艺术品ID")
    user_id = Column(BigInteger, nullable=False, index=True, comment="用户ID")
    current_layer_capacity = Column(BigInteger, nullable=False, comment="当前所在绝对层")
    transaction_hash = Column(String(255), nullable=True, comment="关联交易哈希")
    created_at = Column(TIMESTAMP, nullable=False, server_default=func.now(), comment="创建时间")

# ----------------------------------------------------------------
# 4. 奖励模块 - 奖励记录表
# ----------------------------------------------------------------
class RewardLog(Base, TableArgsMixin):
    """ORM模型：记录系统发放给用户的每一次奖励详情。"""
    __tablename__ = "reward_log"
    __table_args__ = {
        **TableArgsMixin.__table_args__,
        'comment': '[奖励] 奖励记录表'
    }
    
    id = Column(BigInteger, primary_key=True, comment="奖励记录ID") # 统一主键命名为 id
    user_id = Column(BigInteger, nullable=False, index=True, comment="用户ID")
    upgrade_remark = Column(String(255), nullable=True, comment="升级备注 (例如: 2->1, 1->out)")
    reward_amount = Column(Numeric(20, 8), nullable=False, comment="奖励金额")
    created_at = Column(TIMESTAMP, nullable=False, server_default=func.now(), comment="创建时间")