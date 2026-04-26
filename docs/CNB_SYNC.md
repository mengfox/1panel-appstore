# GitHub 自动同步到 CNB

本仓库只维护 GitHub，CNB 作为国内镜像仓库。

## 仓库地址

```text
GitHub 主仓库：
https://github.com/mengfox/1panel-appstore.git

CNB 国内镜像：
https://cnb.cool/mengfox/1panel-appstore
```

## 配置步骤

### 1. 获取 CNB Token

在 CNB 生成访问令牌。

### 2. 添加到 GitHub Secret

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
Value: 你的 CNB Token
```

### 3. 工作流文件

文件路径：

```bash
.github/workflows/sync-cnb.yml
```

每次 push 到 GitHub main 分支后，会自动同步到 CNB。

## 维护方式

只需要维护 GitHub：

```bash
git add .
git commit -m "update apps"
git push origin main
```

不要手动修改 CNB 仓库，避免两边内容不一致。
