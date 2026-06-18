#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="$ROOT/images/OneUI-5.0-TabS6-Fixed-sparse.img.gz"
PARTS=( "$ROOT"/images/OneUI-5.0-TabS6-Fixed-sparse.img.gz.part-* )

if ls "${PARTS[0]}" >/dev/null 2>&1; then
  echo "正在合并分卷..."
  cat "${PARTS[@]}" > "$OUT"
  echo "合并完成: $OUT"
else
  echo "未找到分卷文件，跳过合并。" >&2
  exit 1
fi

if [[ "${1:-}" == "--extract" ]]; then
  echo "正在解压 system 镜像..."
  gzip -dk "$OUT"
  echo "完成: ${OUT%.gz}"
fi
