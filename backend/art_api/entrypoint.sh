#!/bin/bash

# 当任何命令执行失败时，立即退出脚本
set -e

exec uvicorn main:app --host 0.0.0.0 --port 9001