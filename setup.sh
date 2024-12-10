#!/bin/bash

# 输出日志
echo "[INFO] 开始执行 setup.sh 脚本..."

# 检查 /tmp/setup_script 目录是否存在，若存在则删除
if [ -d "/tmp/setup_script" ]; then
    echo "[INFO] 目录 /tmp/setup_script 已存在，正在删除..."
    rm -rf /tmp/setup_script
fi

# 安装 Rust
echo "[INFO] 正在安装 Rust 工具链..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# 配置 Rust 环境变量
echo "[INFO] 配置 Rust 环境变量..."
source $HOME/.cargo/env  # 加载环境变量

# 检查 Rust 是否安装成功
echo "[INFO] 检查 Rust 是否安装成功..."
if ! command -v rustc &> /dev/null
then
    echo "[ERROR] Rust 安装失败！"
    exit 1
else
    echo "[INFO] Rust 安装成功！"
fi

# 安装 Nexus CLI
echo "[INFO] 正在安装 Nexus CLI..."
nohup curl https://cli.nexus.xyz/ | sh -s -- -y > output.log 2>&1 &

# 检查安装日志
echo "[INFO] 检查安装日志..."
tail -n 10 output.log

echo "[INFO] 脚本执行完成！"
