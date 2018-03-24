---
title: MySQL安全与配置
date: 2018-01-19 00:28:21
toc: true
tags: [数据库]
---

# CentOS 7
## 安装
- `yum install mariadb-server mariadb`
- 重置mysql密码
    - ` mysql -u root  //直接回车进入mysql控制台`
    - 
    ```
    mysql > use mysql;
    mysql > update user set password=password('123456') where user='root';
    mysql > exit;
    ```
- 启动mysql `service mariadb start`
- 停止mysql `service mariadb stop`
- 查看mysql运行状态 `service mariadb status`
- 重启mysql `service mariadb restart`

## 配置
- 编辑文件`vi /etc/my.cnf`
- 在`[mysqld]`的项下添加配置内容
    - 配置最大连接数`max_connections=1000`
    - 配置字符编码`character_set_server=utf8`
    - 配置不区分大小写`lower_case_table_names=1`
    - 最大等待时间`wait_timeout=31536000`
    - 最大释放时间`interactive_timeout=31536000`
    ```
    character_set_server=utf8
    max_connections=1000
    lower_case_table_names=1
    wait_timeout=31536000
    interactive_timeout=31536000
    ```
- 配置允许远程访问
    - `grant all privileges on *.* to root@"%"  identified by "12345a" with grant option;`
    - `FLUSH PRIVILEGES;`


## 重置密码
- 先停止数据库服务`service mysqld  stop`
- 以安全模式启动MySQL`mysqld_safe --skip-grant-tables --skip-networking &`
    - 注意我们加了`--skip-networking`，避免远程无密码登录`MySQL`。
- 直接root免密登录`mysql -uroot`
- 重设密码
    - `use mysql`
    - MySQL 5.7.6 以及最新版本：`update user set authentication_string=PASSWORD('12345a') where User='root';`
    - MySQL 5.7.5 或更早之前的版本:`update user set password=PASSWORD('12345a') where User='root';`
- 停止安全模式`service mysqld stop`
- 正常启动`service mysqld start`
- Done~