#!/usr/bin/env bash
set -euo pipefail

GITHUB_URL="https://github.com/mengfox/1panel-appstore.git"

if [ ! -d ".git" ]; then
  git init
fi

git add .
git commit -m "init 1panel appstore" || true
git branch -M main

if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "$GITHUB_URL"
else
  git remote add origin "$GITHUB_URL"
fi

echo "推送到 GitHub 主仓库：$GITHUB_URL"
git push -u origin main

echo
echo "初始化完成。"
echo "后续只需要维护 GitHub："
echo "  git add ."
echo "  git commit -m \"update apps\""
echo "  git push origin main"
echo
echo "CNB 将由 GitHub Actions 自动同步。"
