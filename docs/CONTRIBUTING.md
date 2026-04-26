# 应用提交规范

## 目录规范

```bash
apps/<app-key>/
├── logo.png
├── README.md
├── data.yml
└── <version>/
    ├── data.yml
    ├── docker-compose.yml
    └── scripts/
        └── init.sh
```

## 必需文件

```bash
apps/<app-key>/data.yml
apps/<app-key>/<version>/data.yml
apps/<app-key>/<version>/docker-compose.yml
```

## Compose 规范

建议使用：

```yaml
networks:
  1panel-network:
    external: true

services:
  app:
    image: your/image:1.0.0
    container_name: ${CONTAINER_NAME}
    restart: always
    labels:
      createdBy: Apps
    networks:
      - 1panel-network
    ports:
      - ${HOST_IP}:${PANEL_APP_PORT_HTTP}:80
    deploy:
      resources:
        limits:
          cpus: ${CPUS}
          memory: ${MEMORY_LIMIT}
```

## 安全要求

1. 不允许 `privileged: true`
2. 不允许挂载 `/var/run/docker.sock`
3. 不允许 `pid: host`
4. 不建议使用 `network_mode: host`
5. 不允许使用 `image: xxx:latest`
6. 建议使用固定版本镜像
7. 建议添加 `labels.createdBy: Apps`
8. 建议使用 `1panel-network`
9. 端口建议使用 `${HOST_IP}:${PANEL_APP_PORT_HTTP}:容器端口`
10. 数据目录建议使用表单变量
