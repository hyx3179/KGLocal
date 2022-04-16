@echo off &TITLE è�������߱������нű� by hyx3179

:main
cls
if {%1}=={start} goto start
if {%1}=={restart} goto restart
if {%1}=={stop} goto stop
if {%1}=={install} goto install
if {%1}=={upgrade} goto upgrade
if {%1}=={hosts} goto hosts
if {%1}=={kill} goto kill
echo è�������߱������нű� by hyx3179
echo=
echo main Options
echo=
echo      start        ���� ���ط�����
echo      restart      ���� ���ط�����
echo      stop         �ر� ���ط�����
echo      install      ��װ��������������ļ�
echo      upgrade      ���¸�������ѧ��
echo      hosts        ��� hosts ʵ���������ʣ��࿪��
echo      hosts edit   �� hosts �ļ��ֶ��༭
echo      kill         ǿ��ɱ������ nginx.exe ����
@REM echo      autostart    ��������������ûд��
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
if not exist nginx-1.21.6\nginx.exe PowerShell -file getNginx.ps1 -Out %~dp0
PowerShell -file getcatzh.ps1 -Out %~dp0
PowerShell -file upgrade.ps1 -Out %~dp0
echo ��װ��� ��� start.cmd ���� �� main start
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
echo ��������Ҫ������ xxx.com xxx.net xxx.xyz ���Ƶ�
set/p "name=>"
echo 127.0.0.1 %name% >> %WINDIR%\System32\drivers\etc\hosts
goto end
:edit
%WINDIR%\System32\notepad.exe %WINDIR%\System32\drivers\etc\hosts
goto end

:kill
taskkill /f /t /im nginx.exe
goto end

:end
exit 0