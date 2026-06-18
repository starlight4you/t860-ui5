#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
VBMETA="$ROOT/images/vbmeta_disabled.img"
SYSTEM="$ROOT/images/OneUI-5.0-TabS6-Fixed-sparse.img"

if ! command -v heimdall >/dev/null 2>&1; then
  echo "错误: 未找到 heimdall，请先安装：" >&2
  echo "  Debian/Ubuntu: sudo apt install heimdall-flash" >&2
  echo "  Arch:          sudo pacman -S heimdall" >&2
  exit 1
fi

if [[ ! -f "$VBMETA" ]]; then
  echo "错误: 找不到 vbmeta 镜像: $VBMETA" >&2
  exit 1
fi

if [[ ! -f "$SYSTEM" ]]; then
  GZ="$SYSTEM.gz"
  if [[ -f "$GZ" ]]; then
    echo "正在解压 $GZ ..."
    gzip -dk "$GZ"
  else
    echo "错误: 找不到 system 镜像: $SYSTEM" >&2
    echo "请从 Releases 下载并解压到 images/ 目录" >&2
    exit 1
  fi
fi

echo "============================================"
echo "  SM-T860 One UI 5 GSI 刷机"
echo "============================================"
echo
echo "请确认："
echo "  1. 平板已进入 Download 模式（Odin 模式）"
echo "  2. 已备份重要数据"
echo "  3. Bootloader 已解锁"
echo
read -r -p "按 Enter 继续，Ctrl+C 取消..."

echo "[1/3] 刷入 vbmeta (禁用 AVB)..."
heimdall flash --VBMETA "$VBMETA" --no-reboot

echo "[2/3] 刷入 system (One UI 5 GSI)..."
heimdall flash --SYSTEM "$SYSTEM" --no-reboot

echo "[3/3] 重启设备..."
heimdall reboot

echo
echo "刷机完成！首次启动可能需要 5-15 分钟，请耐心等待。"
