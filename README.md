# 1Panel AppStore

这是 MengFox 的第三方 1Panel 应用商店仓库。

本仓库采用 **GitHub 单主仓库维护 + CNB 自动镜像** 模式：

```text
只维护 GitHub：
https://github.com/mengfox/1panel-appstore.git

CNB 仅作为国内镜像：
https://cnb.cool/mengfox/1panel-appstore
```

## 工作流

```text
本地修改应用包
    ↓
push 到 GitHub
    ↓
GitHub Actions 自动校验
    ↓
GitHub Actions 自动同步到 CNB
    ↓
国内服务器优先拉 CNB
海外服务器优先拉 GitHub
    ↓
1panel-appsync 同步到 /opt/1panel/resource/apps/local
```

## 目录结构

```bash
1panel-appstore/
├── README.md
├── manifest.yml
├── create-app.sh
├── apps/
│   ├── demo-nginx/
│   └── demo-redis/
├── configs/
│   └── 1panel-appsync.config.yml
├── tools/
│   ├── validate.sh
│   └── init-github.sh
├── docs/
│   ├── USAGE.md
│   ├── CONTRIBUTING.md
│   └── CNB_SYNC.md
└── .github/
    └── workflows/
        ├── validate.yml
        └── sync-cnb.yml
```

## 快速初始化

```bash
chmod +x tools/*.sh create-app.sh
./tools/validate.sh
./tools/init-github.sh
```

## 后续维护

后续只需要提交到 GitHub：

```bash
./tools/validate.sh

git add .
git commit -m "update apps"
git push origin main
```

CNB 不需要手动维护，GitHub Actions 会自动同步。

## 服务器配置

把 `configs/1panel-appsync.config.yml` 复制到服务器：

```bash
sudo mkdir -p /etc/1panel-appsync
sudo cp configs/1panel-appsync.config.yml /etc/1panel-appsync/config.yml
```

测试同步：

```bash
1panel-appsync deps --install
1panel-appsync check
1panel-appsync source
1panel-appsync sync --dry-run
1panel-appsync sync
```

同步成功后，应用会出现在：

```bash
/opt/1panel/resource/apps/local
```

## 应用提交要求

1. 应用必须放在 `apps/<app-key>/`
2. 应用根目录必须有 `data.yml`
3. 版本目录必须有 `data.yml` 和 `docker-compose.yml`
4. 镜像必须使用固定版本号，不建议使用 `latest`
5. 默认不允许 `privileged: true`
6. 默认不允许挂载 `/var/run/docker.sock`
7. 建议使用 `1panel-network`
8. 建议添加 `labels.createdBy: Apps`
