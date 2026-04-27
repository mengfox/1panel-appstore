# 彩虹聚合 DNS 管理系统 - 1Panel 应用包

彩虹聚合 DNS 管理系统是一款基于 ThinkPHP 开发的多平台域名解析管理系统，可在一个后台中统一管理多个 DNS 平台账号与域名解析记录。

## 本应用包优化内容

- 接入 1Panel 数据库服务选择器，支持关联 MySQL / MariaDB 应用。
- 安装前通过 `scripts/init.sh` 自动生成 `/app/www/.env` 数据库配置。
- 首次访问 Web 安装页时，数据库连接信息由 1Panel 自动写入，页面只需要继续完成管理员账号设置。
- 修正数据库名、数据库用户默认值，避免 `rainbow-dnsmgr` 这类带横线的默认值触发参数校验或数据库兼容问题。
- 增加数据表前缀配置，默认使用官方前缀 `dnsmgr_`。

## 使用说明

1. 在 1Panel 中先安装 MySQL 或 MariaDB。
2. 安装本应用时选择对应的数据库服务。
3. 1Panel 会创建数据库、数据库用户和密码，并在安装前生成应用 `.env`。
4. 打开应用 Web 页面，根据页面提示设置管理员账号并完成安装。

## 注意事项

- 官方镜像：`netcccyun/dnsmgr:latest`
- 数据目录：`./data/rainbow-dnsmgr` → `/app/www`
- 数据库驱动固定为 MySQL 协议，MariaDB 也使用 `TYPE = mysql`。
- 如果需要重新安装，请先在 1Panel 删除应用数据目录或手动删除 `./data/rainbow-dnsmgr/.env` 与数据库表。
