@echo off &TITLE Hosts �ļ��༭ by hyx3179

find /i "%1" %WINDIR%\System32\drivers\etc\hosts >nul
if "%errorlevel%"=="0" goto end

setlocal enabledelayedexpansion
copy nul %WINDIR%\GetAdmin >nul 2>nul
if exist %WINDIR%\GetAdmin (del /f /q "%WINDIR%\GetAdmin" >nul) else (
echo CreateObject^("Shell.Application"^).ShellExecute "%~s0", "%*", "", "runas", 1 >> "%temp%\Admin.vbs"
"%temp%\Admin.vbs"
del /s /q "%temp%\Admin.vbs" >nul
exit /b 2)
cls

if {%1}=={edit} goto edit
if {%1}=={} goto add
echo 127.0.0.1 %1>>%WINDIR%\System32\drivers\etc\hosts
goto end
:add
echo ��������Ҫ������ xxx.com xxx.net xxx.xyz ���Ƶ�
set/p "name=>"
echo 127.0.0.1 %name%>>%WINDIR%\System32\drivers\etc\hosts
goto end
:edit
%WINDIR%\System32\notepad.exe %WINDIR%\System32\drivers\etc\hosts
goto end

:end
exit /b 0