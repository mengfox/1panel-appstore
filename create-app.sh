#!/usr/bin/env bash
set -euo pipefail

APP_KEY="${1:-}"
APP_NAME="${2:-}"

if [ -z "$APP_KEY" ] || [ -z "$APP_NAME" ]; then
  echo "用法：./create-app.sh app-key 应用名称"
  echo "示例：./create-app.sh my-app 我的应用"
  exit 1
fi

VERSION="1.0.0"
APP_DIR="apps/${APP_KEY}/${VERSION}"

mkdir -p "$APP_DIR/scripts"

cat > "apps/${APP_KEY}/README.md" <<EOF
# ${APP_NAME}

${APP_NAME} 1Panel 应用包。
EOF

cat > "apps/${APP_KEY}/data.yml" <<EOF
name: ${APP_NAME}
tags:
  - WebSite
title: ${APP_NAME}
description: ${APP_NAME}
additionalProperties:
  key: ${APP_KEY}
  name: ${APP_NAME}
  tags:
    - WebSite
  shortDescZh: ${APP_NAME}
  shortDescEn: ${APP_NAME}
  type: website
  crossVersionUpdate: true
  limit: 0
  website: https://example.com
  github: https://github.com/mengfox/1panel-appstore
  document: https://example.com
EOF

cat > "${APP_DIR}/data.yml" <<EOF
additionalProperties:
  formFields:
    - default: 8080
      edit: true
      envKey: PANEL_APP_PORT_HTTP
      labelZh: Web 端口
      labelEn: Web Port
      required: true
      rule: paramPort
      type: number
EOF

cat > "${APP_DIR}/docker-compose.yml" <<EOF
networks:
  1panel-network:
    external: true

services:
  ${APP_KEY}:
    image: nginx:1.27-alpine
    container_name: \${CONTAINER_NAME}
    restart: always
    labels:
      createdBy: Apps
    networks:
      - 1panel-network
    ports:
      - \${HOST_IP}:\${PANEL_APP_PORT_HTTP}:80
    environment:
      TZ: Asia/Shanghai
    deploy:
      resources:
        limits:
          cpus: \${CPUS}
          memory: \${MEMORY_LIMIT}
EOF

echo "已创建应用：apps/${APP_KEY}"
