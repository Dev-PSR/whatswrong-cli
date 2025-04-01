@echo off
setlocal EnableDelayedExpansion

echo Installing 'whatswrong' CLI...

:: Step 1: Check for Git Bash
set "GIT_BASH=%ProgramFiles%\Git\bin\bash.exe"
if not exist "%GIT_BASH%" (
    set "GIT_BASH=%ProgramFiles(x86)%\Git\bin\bash.exe"
)

if not exist "%GIT_BASH%" (
    echo.
    echo [✗] Git Bash is not installed!
    echo.
    echo Please install it from:
    echo https://git-scm.com/download/win
    echo.
    echo After installing Git Bash, re-run this installer.
    pause
    exit /b
)

:: Step 2: Define paths
set "INSTALL_DIR=%USERPROFILE%\.whatswrong"
set "SCRIPT_URL=https://raw.githubusercontent.com/dev-psr/whatswrong-cli/main/whatswrong"
set "SCRIPT_PATH=%INSTALL_DIR%\whatswrong"
set "WRAPPER_DIR=C:\dev-tools"
set "WRAPPER_PATH=%WRAPPER_DIR%\whatswrong.bat"

:: Step 3: Create folders
mkdir "%INSTALL_DIR%" >nul 2>&1
mkdir "%WRAPPER_DIR%" >nul 2>&1

:: Step 4: Download the script
echo Downloading 'whatswrong' script...
powershell -Command "Invoke-WebRequest -Uri '%SCRIPT_URL%' -OutFile '%SCRIPT_PATH%'"

:: Step 5: Create the wrapper with forward slashes
echo Creating launcher...
(
echo @echo off
echo "%GIT_BASH%" "C:/Users/%USERNAME%/.whatswrong/whatswrong" %%*
) > "%WRAPPER_PATH%"

:: Step 6: Add wrapper to PATH if missing
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
echo You can now use 'whatswrong' from any terminal window.
pause
