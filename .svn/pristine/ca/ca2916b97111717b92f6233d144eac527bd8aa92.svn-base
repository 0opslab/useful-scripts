@echo off
title 一键删除OneDrive
::获取管理员权限
%Windir%\System32\FLTMC.exe >nul 2>&1 || (
    IF EXIST "%TEMP%\AdminRun.vbs" DEL /f /q "%TEMP%\AdminRun.vbs" 2>nul
    ECHO CreateObject^("Shell.Application"^).ShellExecute "%~f0", "%1", "", "runas", 1 >> "%TEMP%\AdminRun.vbs"
    ECHO CreateObject^("Scripting.filesystemobject"^).DeleteFile ^(WScript.ScriptFullName^) >> "%TEMP%\AdminRun.vbs"
    %Windir%\System32\CSCRIPT.exe //Nologo "%TEMP%\AdminRun.vbs"
    Exit /b
)
echo.
echo 即将删除OneDrive，是否继续？
echo.
echo 是：请按任意键继续。
echo 否：点击右上角，关闭本窗口。
echo.
echo 如有安全软件弹出拦截提示，放行即可。
pause
echo 正在调用OneDrive自带卸载功能，请稍后。
for /d %%f in (%localappdata%\Microsoft\OneDrive\*) do (if exist "%%f\OneDriveSetup.exe" %%f\OneDriveSetup.exe /uninstall)
echo OneDrive卸载完成！
del /f /s /q %localappdata%\Microsoft\OneDrive\*.*
rd /s /q %localappdata%\Microsoft\OneDrive\
echo OneDrive残留文件删除完成！
reg add "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /v Attributes /t REG_DWORD /d "0xf090004d" /f
echo OneDrive导航栏选项删除完成！
echo 删除导航栏OneDrive图标将会在重启Windows资源管理器后生效。
echo.
echo.
echo 已将OneDrive彻底卸载。如有残留文件无法删除，重启后手工删除即可。
echo 请按任意键退出本程序。
pause