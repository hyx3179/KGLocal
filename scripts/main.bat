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
if not exist nginx-1.21.6\nginx.exe PowerShell -file getNginx.ps1 -Out %~dp0
echo 下载 猫国建设者
PowerShell -file getcatzh.ps1 -Out %~dp0
if not exist ..\html\NummonCalc mkdir ..\html\NummonCalc
if not exist ..\html\scientists mkdir ..\html\scientists
if not exist ..\html\scientists-inf mkdir ..\html\scientists-inf
echo 下载 概览和珂学家
PowerShell -file upgrade.ps1 -Out %~dp0
echo 安装完成 点击 start.cmd 启动 或 main start
pause
goto end

:upgrade
PowerShell -file %~dp0upgrade.ps1 -Out %~dp0
pause
goto end

:hosts
setlocal enabledelayedexpansion
cd.>%WINDIR%\GetAdmin
if exist %WINDIR%\GetAdmin (del /f /q "%WINDIR%\GetAdmin") else (
echo CreateObject^("Shell.Application"^).ShellExecute "%~s0", "%*", "", "runas", 1 >> "%temp%\Admin.vbs"
"%temp%\Admin.vbs"
del /s /q "%temp%\Admin.vbs"
exit /b 2)
cls
if {%2}=={edit} goto edit
echo 输入你需要的域名 xxx.com xxx.net xxx.xyz 类似的
set/p "name=>"
echo 127.0.0.1 %name% >> %WINDIR%\System32\drivers\etc\hosts
goto end
:edit
%WINDIR%\System32\notepad.exe %WINDIR%\System32\drivers\etc\hosts
goto end

:kill
taskkill /f /t /im nginx.exe
del /s /q %~dp0..\logs\nginx.pid
goto end

:end
exit 0