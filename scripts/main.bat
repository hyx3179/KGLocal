@echo off &TITLE 猫国建设者本地运行脚本 by hyx3179

:main
cls
if {%1}=={start} goto start
if {%1}=={restart} goto restart
if {%1}=={stop} goto stop
if {%1}=={install} goto install
if {%1}=={upgrade} goto upgrade
if {%1}=={hosts} goto hosts
if {%1}=={kill} goto kill
echo 猫国建设者本地运行脚本 by hyx3179
echo=
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
pause
goto end

:start
start http://kg.com:3179/
cd /d %~dp0..
if exist .\logs\nginx.pid goto end
start %~dp0nginx-1.21.6\nginx.exe
goto end

:restart
cd /d %~dp0..
if not exist .\logs\nginx.pid goto end
%~dp0nginx-1.21.6\nginx.exe -s reload
goto end

:stop
cd /d %~dp0..
if not exist .\logs\nginx.pid goto end
%~dp0nginx-1.21.6\nginx.exe -s stop
goto end

:install
cd /d %~dp0
if not exist ..\logs mkdir ..\logs
if not exist ..\temp mkdir ..\temp
echo 下载 nginx
if exist nginx-1.21.6\nginx.exe goto nginxEnd
PowerShell Invoke-WebRequest -Uri https://gitee.com/hyx3179/cat-zh/attach_files/1031881/download/nginx-1.21.6.zip -OutFile %~dp0nginx.zip
PowerShell Expand-Archive -Path %~dp0nginx.zip -Force -DestinationPath %~dp0
:nginxEnd
echo 下载 猫国建设者
PowerShell Invoke-WebRequest -Uri https://gitee.com/hyx3179/cat-zh/attach_files/1031755/download/cat-zh.zip -OutFile %~dp0cat-zh.zip
PowerShell Expand-Archive -Path %~dp0cat-zh.zip -Force -DestinationPath %~dp0..\html\
echo 下载 自动领导力
PowerShell Invoke-WebRequest -Uri https://gitee.com/hyx3179/cat-zh/attach_files/1032506/download/Cheney.zip -OutFile %~dp0Cheney.zip
PowerShell Expand-Archive -Path %~dp0Cheney.zip -Force -DestinationPath %~dp0..\html\
echo 下载 概览和珂学家
call %~dp0upgrade.bat
echo 设置 kg.com Hosts
call %~dp0hosts.bat kg.com
call %~dp0hosts.bat cheney.io
echo 安装完成 点击 start.cmd 启动 或 main start
pause
goto end

:upgrade
call %~dp0upgrade.bat
pause
goto end

:hosts
call %~dp0hosts.bat %2
goto end

:kill
taskkill /f /t /im nginx.exe
del /s /q %~dp0..\logs\nginx.pid
goto end

:end
exit