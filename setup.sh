#!/bin/bash

echo "[INFO] 开始执行 setup.sh 脚本..."

# 定义临时目录路径
TEMP_DIR="/tmp/setup_script"

# 检查 /tmp/setup_script 目录是否存在，如果存在，删除
if [ -d "$TEMP_DIR" ]; then
    echo "[INFO] 目录 /tmp/setup_script 已存在，正在删除..."
    # 强制删除目录及其所有内容
    rm -rf "$TEMP_DIR"
    
    # 如果目录被占用，可以尝试延迟删除
    while [ -d "$TEMP_DIR" ]; do
        echo "[INFO] 等待目录删除..."
        sleep 2
        rm -rf "$TEMP_DIR"
    done
fi

# 创建新的临时目录
mkdir -p "$TEMP_DIR"

# 使用 curl 直接下载 setup.sh 脚本
echo "[INFO] 拉取 setup.sh 脚本..."
curl -L https://raw.githubusercontent.com/55620/bot/main/setup.sh -o "$TEMP_DIR/setup.sh"

# 安装 Rust 工具链
echo "[INFO] 安装 Rust 工具链..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# 加载 Rust 环境变量
echo "[INFO] 配置 Rust 环境变量..."
source "$HOME/.cargo/env"

# 确保 Rust 工具链已安装并可用
if ! command -v rustc &> /dev/null || ! command -v cargo &> /dev/null; then
    echo "[ERROR] Rust 工具链安装失败！"
    exit 1
fi

echo "[INFO] Rust 安装成功！"

# 下载并安装 Nexus CLI
echo "[INFO] 下载并安装 Nexus CLI..."
nohup curl https://cli.nexus.xyz/ | sh -s -- -y > output.log 2>&1 &

echo "[INFO] 脚本执行完成！"
