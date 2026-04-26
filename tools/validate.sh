#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
APPS_DIR="${ROOT_DIR}/apps"

if [ ! -d "$APPS_DIR" ]; then
  echo "错误：apps 目录不存在"
  exit 1
fi

for app in "$APPS_DIR"/*; do
  [ -d "$app" ] || continue
  app_name="$(basename "$app")"
  echo "检查应用：$app_name"

  if [ ! -f "$app/data.yml" ]; then
    echo "错误：$app_name 缺少 data.yml"
    exit 1
  fi

  version_count=0
  for ver in "$app"/*; do
    [ -d "$ver" ] || continue
    ver_name="$(basename "$ver")"

    if [ ! -f "$ver/data.yml" ]; then
      echo "错误：$app_name/$ver_name 缺少 data.yml"
      exit 1
    fi

    if [ ! -f "$ver/docker-compose.yml" ]; then
      echo "错误：$app_name/$ver_name 缺少 docker-compose.yml"
      exit 1
    fi

    version_count=$((version_count + 1))
  done

  if [ "$version_count" -eq 0 ]; then
    echo "错误：$app_name 没有版本目录"
    exit 1
  fi
done

if grep -R "privileged:[[:space:]]*true" "$APPS_DIR"; then
  echo "错误：不允许 privileged: true"
  exit 1
fi

if grep -R "/var/run/docker.sock" "$APPS_DIR"; then
  echo "错误：不允许挂载 /var/run/docker.sock"
  exit 1
fi

if grep -R "pid:[[:space:]]*host" "$APPS_DIR"; then
  echo "错误：不允许 pid: host"
  exit 1
fi

if grep -R "image:.*:latest" "$APPS_DIR"; then
  echo "错误：不建议使用 latest 镜像标签"
  exit 1
fi

echo "校验通过"
