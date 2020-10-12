@echo off
::每一秒执行一次redis命令
:start
choice /t 1 /d y /n >nul
redis-cli info | findstr connected_clients:
choice /t 1 /d y /n >nul
goto start
pause