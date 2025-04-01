@echo off
setlocal EnableDelayedExpansion

echo Installing 'whatswrong'...

:: Define install locations
set "INSTALL_DIR=%USERPROFILE%\.whatswrong"
set "SCRIPT_URL=https://raw.githubusercontent.com/dev-psr/whatswrong-cli/main/whatswrong"
set "SCRIPT_PATH=%INSTALL_DIR%\whatswrong"
set "WRAPPER_DIR=C:\dev-tools"
set "WRAPPER_PATH=%WRAPPER_DIR%\whatswrong.bat"

:: Create folders
mkdir "%INSTALL_DIR%" >nul 2>&1
mkdir "%WRAPPER_DIR%" >nul 2>&1

:: Download script
echo Downloading script...
powershell -Command "Invoke-WebRequest -Uri '%SCRIPT_URL%' -OutFile '%SCRIPT_PATH%'"

:: Create wrapper that runs bash with the script
echo Creating wrapper...
(
echo @echo off
echo "C:\Program Files\Git\bin\bash.exe" "%SCRIPT_PATH%" %%*
) > "%WRAPPER_PATH%"

:: Add wrapper dir to PATH if needed
echo Checking PATH...
echo %PATH% | find /I "%WRAPPER_DIR%" >nul
if errorlevel 1 (
    setx PATH "%PATH%;%WRAPPER_DIR%"
    echo Added %WRAPPER_DIR% to PATH.
) else (
    echo Already in PATH.
)

echo.
echo [✓] Installed successfully!
echo You can now run 'whatswrong' from any terminal.
pause

