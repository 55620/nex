#!/bin/bash

echo "[INFO] 开始执行 setup.sh 脚本..."

# 设置临时目录
TEMP_DIR="/tmp/setup_script"

# 删除旧的临时目录
if [ -d "$TEMP_DIR" ]; then
    echo "[INFO] 目录 $TEMP_DIR 已存在，正在删除..."
    rm -rf "$TEMP_DIR"
fi

# 创建新的临时目录
mkdir -p "$TEMP_DIR"

# 拉取最新的 setup.sh 脚本
echo "[INFO] 拉取 setup.sh 脚本..."
curl -L https://raw.githubusercontent.com/55620/bot/main/setup.sh -o "$TEMP_DIR/setup.sh"

# 执行 Rust 安装
echo "[INFO] 安装 Rust 工具链..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# 配置 Rust 环境变量
echo "[INFO] 配置 Rust 环境变量..."
echo "source \$HOME/.cargo/env" >> ~/.bashrc
source ~/.bashrc

# 下载并安装 Nexus CLI
echo "[INFO] 下载并安装 Nexus CLI..."
nohup curl https://cli.nexus.xyz/ | sh -s -- -y > /tmp/nexus_cli_install.log 2>&1 &

# 输出完成信息
echo "[INFO] 脚本执行完成！"

# 检查安装日志
echo "[INFO] 请查看 /tmp/nexus_cli_install.log 了解详细安装过程。"
