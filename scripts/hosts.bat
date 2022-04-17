@echo off &TITLE Hosts 文件编辑 by hyx3179
setlocal enabledelayedexpansion
cd.>%WINDIR%\GetAdmin
if exist %WINDIR%\GetAdmin (del /f /q "%WINDIR%\GetAdmin") else (
echo CreateObject^("Shell.Application"^).ShellExecute "%~s0", "%*", "", "runas", 1 >> "%temp%\Admin.vbs"
"%temp%\Admin.vbs"
del /s /q "%temp%\Admin.vbs"
exit /b 2)
cls

if {%1}=={edit} goto edit
if {%1}=={} goto add
echo 127.0.0.1 %1>>%WINDIR%\System32\drivers\etc\hosts
goto end
:add
echo 输入你需要的域名 xxx.com xxx.net xxx.xyz 类似的
set/p "name=>"
echo 127.0.0.1 %name%>>%WINDIR%\System32\drivers\etc\hosts
goto end
:edit
%WINDIR%\System32\notepad.exe %WINDIR%\System32\drivers\etc\hosts
goto end

:end
exit /b 0