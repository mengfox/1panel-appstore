# 使用教程

## 一、初始化仓库

本模板采用 **GitHub 单主仓库维护，CNB 自动镜像** 模式。

初始化并推送到 GitHub：

```bash
chmod +x tools/*.sh create-app.sh
./tools/validate.sh
./tools/init-github.sh
```

后续不需要手动推送 CNB。

## 二、配置 CNB 自动同步

进入 GitHub 仓库：

```text
Settings
Secrets and variables
Actions
New repository secret
```

添加：

```text
Name: CNB_TOKEN
Value: 你的 CNB 访问令牌
```

然后每次 `git push origin main` 后，GitHub Actions 会自动同步到：

```text
https://cnb.cool/mengfox/1panel-appstore
```

## 三、配置 1panel-appsync

把配置复制到服务器：

```bash
sudo mkdir -p /etc/1panel-appsync
sudo cp configs/1panel-appsync.config.yml /etc/1panel-appsync/config.yml
```

执行检测：

```bash
1panel-appsync deps --install
1panel-appsync check
1panel-appsync source
```

预览同步：

```bash
1panel-appsync sync --dry-run
```

正式同步：

```bash
1panel-appsync sync
```

## 四、查看同步结果

```bash
ls -lah /opt/1panel/resource/apps/local
```

进入 1Panel 后台，刷新本地应用商店。

## 五、新增应用

```bash
./create-app.sh my-app 我的应用
```

然后修改：

```bash
apps/my-app/data.yml
apps/my-app/1.0.0/data.yml
apps/my-app/1.0.0/docker-compose.yml
```

校验：

```bash
./tools/validate.sh
```

提交：

```bash
git add .
git commit -m "add my-app"
git push origin main
```

CNB 会自动同步。
