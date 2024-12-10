#!/bin/bash

echo "[INFO] 开始执行 setup.sh 脚本..."

# 确保临时目录为空
TEMP_DIR="/tmp/setup_script_$(date +%s)"

# 如果 /tmp/setup_script 存在，先删除它
if [ -d "/tmp/setup_script" ]; then
    echo "[INFO] 目录 /tmp/setup_script 已存在，正在删除..."
    rm -rf /tmp/setup_script
fi

# 创建新的临时目录
mkdir -p $TEMP_DIR

# 拉取最新的 setup.sh 脚本
echo "[INFO] 拉取 setup.sh 脚本..."
git clone https://github.com/55620/bot/raw/refs/heads/main/setup.sh $TEMP_DIR

# 检查 git 克隆是否成功
if [ $? -ne 0 ]; then
    echo "[ERROR] 拉取 setup.sh 脚本失败，请检查 URL 或网络连接！"
    exit 1
fi

# 进入临时目录并执行脚本
echo "[INFO] 执行 setup.sh 脚本..."
cd $TEMP_DIR
chmod +x setup.sh

# 执行脚本
./setup.sh

# 检查执行状态
if [ $? -eq 0 ]; then
    echo "[INFO] 脚本执行成功！"
else
    echo "[ERROR] 脚本执行失败！"
    exit 1
fi

# 清理临时目录
echo "[INFO] 清理临时目录..."
rm -rf $TEMP_DIR

echo "[INFO] 脚本执行完成！"
