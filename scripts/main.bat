@echo off

set nginxUrl=https://gitee.com/hyx3179/cat-zh/attach_files/1031881/download/nginx-1.21.6.zip
set nginxSHA="88017dc410d98da063167f8ecccd32f5895529c43942461aa4a166a88eae3026"
set catzhUrl=https://gitee.com/hyx3179/cat-zh/attach_files/1033484/download/cat-zh.zip
set catzhSHA="ce98b72855c8b2f968c62a9fe8e2155e59e00ae8c44d2006787cbefd05c07682"
set CheneyUrl=https://gitee.com/hyx3179/cat-zh/attach_files/1033483/download/Cheney.zip
set CheneySHA="ee4a0a907a2f5bb267852baa70fa9053eeb706f99f56447cccbb7b0eb578c0a6"
set resAndlibUrl=https://gitee.com/hyx3179/cat-zh/attach_files/1033508/download/resAndlib.zip
set resAndlibSHA="4ad1a90b15ec01b68db1eea110772ed1ce8f7ee05bfa1bd267b5f5ecd0825964"
set nummoncalcUrl=https://petercheney.gitee.io/nummoncalc/NummonCalc.js
set scientistsUrl=https://petercheney.gitee.io/scientists/kitten-scientists.user.js

:main
cls
if {%1}=={start} goto start
if {%1}=={restart} goto restart
if {%1}=={stop} goto stop
if {%1}=={install} goto install
if {%1}=={upgrade} call :upgrade
if {%1}=={hosts} goto hosts
if {%1}=={kill} goto kill
pause
goto end

:start
call :taskCheck
if "%errorlevel%"=="0" goto end
start %~dp0nginx-1.21.6\nginx.exe
start http://kg.com:3179/
goto end

:restart
call :taskCheck
if not "%errorlevel%"=="0" del /s /q %~dp0..\logs\nginx.pid >nul 2>nul && goto start
%~dp0nginx-1.21.6\nginx.exe -s reload
goto end

:stop
call :taskCheck
if not "%errorlevel%"=="0" del /s /q %~dp0..\logs\nginx.pid >nul 2>nul && goto end
%~dp0nginx-1.21.6\nginx.exe -s stop
goto end

:install
cd /d %~dp0
if not exist ..\html mkdir ..\html
if not exist ..\logs mkdir ..\logs
if not exist ..\temp mkdir ..\temp
echo 下载 nginx
call :fileCheck nginx-1.21.6\nginx.exe %nginxSHA%
if "%errorlevel%"=="0" goto nginxEnd
PowerShell Invoke-WebRequest -Uri %nginxUrl% -OutFile nginx.zip
PowerShell Expand-Archive -Path nginx.zip -Force -DestinationPath .\
:nginxEnd
echo 下载 资源文件
call :fileCheck resAndlib.zip %resAndlibSHA%
if "%errorlevel%"=="0" goto resAndlibEnd
PowerShell Invoke-WebRequest -Uri %resAndlibUrl% -OutFile resAndlib.zip
if not "%errorlevel%"=="0" goto downloadError
:resAndlibEnd
PowerShell Expand-Archive -Path resAndlib.zip -Force -DestinationPath ..\html\
echo 下载 猫国建设者
call :fileCheck cat-zh.zip %catzhSHA%
if "%errorlevel%"=="0" goto catzhEnd
PowerShell Invoke-WebRequest -Uri %catzhUrl% -OutFile cat-zh.zip
if not "%errorlevel%"=="0" goto downloadError
:catzhEnd
PowerShell Expand-Archive -Path cat-zh.zip -Force -DestinationPath ..\html\
echo 下载 自动领导力
call :fileCheck Cheney.zip %CheneySHA%
if "%errorlevel%"=="0" goto CheneyEnd
PowerShell Invoke-WebRequest -Uri %CheneyUrl% -OutFile Cheney.zip
if not "%errorlevel%"=="0" goto downloadError
:CheneyEnd
PowerShell Expand-Archive -Path Cheney.zip -Force -DestinationPath ..\html\
@REM echo 下载 概览和珂学家
call :upgrade
echo 设置默认 Hosts
call hosts.bat kg.com
call hosts.bat cheney.io
echo 安装完成 点击 start.cmd 启动 或 main start
pause
goto end

:upgrade
cd /d %~dp0
if not exist ..\html\NummonCalc mkdir ..\html\NummonCalc
if not exist ..\html\scientists mkdir ..\html\scientists
echo 更新 概览
PowerShell Invoke-WebRequest -Uri %nummoncalcUrl% -OutFile %~dp0..\html\NummonCalc\NummonCalc.js
echo 更新 珂学家
PowerShell Invoke-WebRequest -Uri %scientistsUrl% -OutFile %~dp0..\html\scientists\kitten-scientists.user.js
goto:eof

:hosts
call %~dp0hosts.bat %2
goto end

:kill
taskkill /f /t /im nginx.exe
del /s /q %~dp0..\logs\nginx.pid
goto end

:downloadError
echo 下载错误请检查网络连接后重新运行
pause
exit

:end
@REM pause
exit

:fileCheck
if exist %1 ( CertUtil -hashfile %1 SHA256 | find /i %2 >nul ) else ( ? 2>nul )
goto:eof

:taskCheck
if exist %~dp0..\logs\nginx.pid ( set /p taskPid=<%~dp0..\logs\nginx.pid ) else ( set taskPid=0 )
tasklist /fi "PID eq %taskPid%" | find /i "nginx" >nul
goto:eof