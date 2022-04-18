@echo off &TITLE 猫国建设者本地运行脚本 by hyx3179
echo main Options
echo=
echo      start        启动 本地服务器
echo      restart      重启 本地服务器
echo      stop         关闭 本地服务器
echo      install      安装开启服务所需的文件
echo      upgrade      更新概览和珂学家
echo      hosts        添加 hosts 实现域名访问（多开）
echo      hosts edit   打开 hosts 文件手动编辑
echo      kill         强制杀死所有 nginx.exe 进程
@REM echo      autostart    开机自启动（还没写）
echo=
echo 输入你要的参数，直接回车显示所有参数
set/p "Options=>"
.\scripts\main.bat %Options%
