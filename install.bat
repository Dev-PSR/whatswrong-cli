@echo off
setlocal EnableDelayedExpansion

echo Installing 'whatswrong'...

:: Define locations
set "INSTALL_DIR=%USERPROFILE%\.whatswrong"
set "WRAPPER_DIR=C:\dev-tools"
set "WRAPPER_PATH=%WRAPPER_DIR%\whatswrong.bat"
set "SCRIPT_URL=https://raw.githubusercontent.com/dev-psr/whatswrong-cli/main/whatswrong"
set "SCRIPT_PATH=%INSTALL_DIR%\whatswrong"

:: Create folders
mkdir "%INSTALL_DIR%" >nul 2>&1
mkdir "%WRAPPER_DIR%" >nul 2>&1

:: Download script
echo Downloading whatswrong...
powershell -Command "Invoke-WebRequest -Uri '%SCRIPT_URL%' -OutFile '%SCRIPT_PATH%'"

:: Make wrapper .bat file
echo Creating PowerShell wrapper...
echo @echo off>"%WRAPPER_PATH%"
echo "C:\Program Files\Git\bin\bash.exe" "%SCRIPT_PATH%" %%*>>"%WRAPPER_PATH%"

:: Add wrapper dir to PATH if missing
echo Ensuring %WRAPPER_DIR% is in PATH...
echo %PATH% | find /I "%WRAPPER_DIR%" >nul
if errorlevel 1 (
    setx PATH "%PATH%;%WRAPPER_DIR%"
    echo Added %WRAPPER_DIR% to PATH.
) else (
    echo Already in PATH.
)

echo.
echo [✓] Installation complete.
echo You can now run 'whatswrong' from any PowerShell or CMD window.
pause
