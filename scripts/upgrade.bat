@echo off &TITLE ���¸�������ѧ�� by hyx3179
cd /d %~dp0
if not exist ..\html\NummonCalc mkdir ..\html\NummonCalc
if not exist ..\html\scientists mkdir ..\html\scientists
if not exist ..\html\scientists-inf mkdir ..\html\scientists-inf
@REM if not exist ..\html\scientists-hyx3179 mkdir ..\html\scientists-hyx3179
echo ���� ����
PowerShell Invoke-WebRequest -Uri https://petercheney.gitee.io/nummoncalc/NummonCalc.js -OutFile %~dp0..\html\NummonCalc\NummonCalc.js
echo ���� ��ѧ��
PowerShell Invoke-WebRequest -Uri https://petercheney.gitee.io/scientists/kitten-scientists.user.js -OutFile %~dp0..\html\scientists\kitten-scientists.user.js
echo ���� �Զ��쵼����ѧ��
PowerShell Invoke-WebRequest -Uri https://petercheney.gitee.io/cheney/kitten-scientists.user.js -OutFile %~dp0..\html\scientists-inf\kitten-scientists.user.js
@REM PowerShell Invoke-WebRequest -Uri https://github.com/hyx3179/cat-zh-load-old/raw/master-hyx/scientists/kitten-scientists.user.js -OutFile %~dp0..\html\scientists-hyx3179\kitten-scientists.user.js
exit /b 0