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
echo ���� nginx
if exist nginx-1.21.6\nginx.exe goto nginxEnd
PowerShell Invoke-WebRequest -Uri https://gitee.com/hyx3179/cat-zh/attach_files/1031881/download/nginx-1.21.6.zip -OutFile %~dp0nginx.zip
PowerShell Expand-Archive -Path %~dp0nginx.zip -Force -DestinationPath %~dp0
:nginxEnd
echo ���� è��������
PowerShell Invoke-WebRequest -Uri https://gitee.com/hyx3179/cat-zh/attach_files/1031755/download/cat-zh.zip -OutFile %~dp0cat-zh.zip
PowerShell Expand-Archive -Path %~dp0cat-zh.zip -Force -DestinationPath %~dp0..\html\
echo ���� ��������ѧ��
call %~dp0upgrade.bat
echo ���� kg.com Hosts
call %~dp0hosts.bat kg.com
echo ��װ��� ��� start.cmd ���� �� main start
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