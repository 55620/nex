#!/bin/bash

echo "[INFO] 开始执行 setup.sh 脚本..."

# 定义临时目录路径
TEMP_DIR="/tmp/setup_script"

# 检查 /tmp/setup_script 目录是否存在，如果存在，删除
if [ -d "$TEMP_DIR" ]; then
    echo "[INFO] 目录 $TEMP_DIR 已存在，正在删除..."
    sudo rm -rf "$TEMP_DIR"
fi

# 创建新的临时目录
mkdir -p "$TEMP_DIR"

# 拉取最新的 setup.sh 脚本
echo "[INFO] 拉取 setup.sh 脚本..."
curl -L https://raw.githubusercontent.com/55620/bot/main/setup.sh -o "$TEMP_DIR/setup.sh"

# 运行下载的 setup.sh 脚本
echo "[INFO] 执行 setup.sh 脚本..."
bash "$TEMP_DIR/setup.sh"

# 输出完成信息
echo "[INFO] 脚本执行完成！"
