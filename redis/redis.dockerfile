# 使用官方Redis镜像
FROM redis:latest

# 设置工作目录（容器内部）
WORKDIR /data

# 设置Redis密码 + 启用AOF持久化
CMD ["redis-server", "--requirepass", "Vigaviga2026", "--appendonly", "yes"]

# 暴露Redis端口
EXPOSE 6379

# 声明数据卷（容器内的/data目录）
VOLUME /data