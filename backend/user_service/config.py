import os
from dotenv import load_dotenv


# 检查当前环境（默认 dev）
env = os.getenv("ENV", "dev")  # 如果没有 ENV，默认是 dev

# 加载对应的 .env 文件
if env == "prod":
    load_dotenv(".env.prod")  # 生产环境
else:
    load_dotenv(".env")  # 开发环境
# load_dotenv()

# --- Security Configuration ---
SECRET_KEY = os.getenv("SECRET_KEY", "a_very_secret_key_change_this_in_production")
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 60 * 24 * 30

# --- Database Configuration ---
# 请替换成你自己的数据库信息
DB_USER = os.getenv("DB_USER", "root")
DB_PASSWORD = os.getenv("DB_PASSWORD", "Vigaviga2026")
DB_PORT = os.getenv("DB_PORT", 3306)
DB_HOST = os.getenv("DB_HOST", "156.236.75.52")
DB_NAME = os.getenv("DB_NAME", "viga")
DATABASE_URL = f"mysql+aiomysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

# --- Redis Configuration ---
RD_USER = os.getenv("RD_USER", "")
RD_PASSWORD = os.getenv("RD_PASSWORD", "Vigaviga2026")
RD_PORT = os.getenv("RD_PORT", 6379)
RD_HOST = os.getenv("RD_HOST", "156.236.75.52")
# RD_URL = f"mysql+aiomysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

# --- SMS Configuration ---
# 需求 1: 每个号码发送限制 (常量)
MAX_SMS_PER_DAY = 5
SMS_CODE_EXPIRE_MINUTES = 5

# --- RABBITMQ Configuration ---
RABBITMQ_HOST = os.getenv("RABBITMQ_USER", 'localhost')
RABBITMQ_PORT = os.getenv("RABBITMQ_PORT", '5672')
RABBITMQ_USER = os.getenv("RABBITMQ_USER", 'guest')
RABBITMQ_PASS = os.getenv("RABBITMQ_PASS", 'guest')
RABBITMQ_URL = os.getenv("RABBITMQ_URL", "amqp://{RABBITMQ_USER}:{RABBITMQ_PASS}@{RABBITMQ_HOST}:{RABBITMQ_PORT}/")
