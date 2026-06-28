@echo off
setlocal enabledelayedexpansion

set SCRIPT_NAME=lister_z_gui.py
set APP_NAME=Lister Z
set EXEC_NAME=Lister_Z.exe
set ICON_FILE=icon_lister_z.ico

:: Always work relative to where this .bat file lives
cd /d "%~dp0"

echo ===========================================
echo  Building Lister Z for Windows
echo ===========================================

:: Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python not found. Please install Python and add it to PATH.
    pause
    exit /b 1
)

:: Check script exists
if not exist "%SCRIPT_NAME%" (
    echo [ERROR] %SCRIPT_NAME% not found in current directory.
    pause
    exit /b 1
)

:: Install pyinstaller if needed
python -m pip show pyinstaller >nul 2>&1
if errorlevel 1 (
    echo [INFO] Installing PyInstaller...
    python -m pip install pyinstaller
)

:: Pillow is needed to draw the high-res icon
python -m pip show pillow >nul 2>&1
if errorlevel 1 (
    echo [INFO] Installing Pillow...
    python -m pip install pillow
)

:: python-docx is needed by the GUI
python -m pip show python-docx >nul 2>&1
if errorlevel 1 (
    echo [INFO] Installing python-docx...
    python -m pip install python-docx
)

:: ── BUILD HIGH-RES ICON ─────────────────────────────────────────────────────
echo [INFO] Generating high-resolution icon...
python "%SCRIPT_NAME%" --make-icon "%ICON_FILE%"
if errorlevel 1 (
    echo [ERROR] Icon generation failed.
    pause
    exit /b 1
)
:: ─────────────────────────────────────────────────────────────────────────────

:: Build — output goes straight into this folder, not a dist\ subfolder
echo [INFO] Building executable...
python -m PyInstaller --onefile --windowed --name "Lister_Z" --icon "%ICON_FILE%" ^
    --hidden-import=docx ^
    --distpath "." --workpath ".\build" --specpath "." "%SCRIPT_NAME%"

if errorlevel 1 (
    echo [ERROR] Build failed.
    pause
    exit /b 1
)

:: ── CREATE DESKTOP + START MENU SHORTCUTS ───────────────────────────────────
echo [INFO] Creating Desktop shortcut...
set "DESKTOP_LNK=%USERPROFILE%\Desktop\%APP_NAME%.lnk"
call :MakeShortcut "%DESKTOP_LNK%" "%~dp0%EXEC_NAME%" "%~dp0%EXEC_NAME%" "%~dp0"

echo [INFO] Creating Start Menu shortcut...
set "STARTMENU_DIR=%APPDATA%\Microsoft\Windows\Start Menu\Programs"
if not exist "%STARTMENU_DIR%" mkdir "%STARTMENU_DIR%"
set "STARTMENU_LNK=%STARTMENU_DIR%\%APP_NAME%.lnk"
call :MakeShortcut "%STARTMENU_LNK%" "%~dp0%EXEC_NAME%" "%~dp0%EXEC_NAME%" "%~dp0"
:: ─────────────────────────────────────────────────────────────────────────────

:: ── CLEAN UP BUILD ARTIFACTS ─────────────────────────────────────────────────
echo [INFO] Removing temporary build files...
del /f /q "%~dp0%ICON_FILE%" >nul 2>&1
if exist "%~dp0build" rd /s /q "%~dp0build"
if exist "%~dp0Lister_Z.spec" del /f /q "%~dp0Lister_Z.spec"
:: ─────────────────────────────────────────────────────────────────────────────

:: ── LAUNCH THE APP ────────────────────────────────────────────────────────────
echo [INFO] Launching Lister Z...
start "" "%~dp0%EXEC_NAME%"
:: ─────────────────────────────────────────────────────────────────────────────

echo.
echo [OK] Done!
echo    Local:        %~dp0%EXEC_NAME%
echo    Desktop:      %DESKTOP_LNK%
echo    Start Menu:   %STARTMENU_LNK%
pause
exit /b 0

:MakeShortcut
:: %1 = shortcut path, %2 = target exe, %3 = icon path, %4 = working dir
set "PS_TMP=%TEMP%\lister_z_mkshortcut_%RANDOM%.ps1"
> "%PS_TMP%" echo $ws = New-Object -ComObject WScript.Shell
>> "%PS_TMP%" echo $sc = $ws.CreateShortcut('%~1')
>> "%PS_TMP%" echo $sc.TargetPath = '%~2'
>> "%PS_TMP%" echo $sc.WorkingDirectory = '%~4'
>> "%PS_TMP%" echo $sc.IconLocation = '%~3'
>> "%PS_TMP%" echo $sc.Description = 'Lister Z - file and folder listing tool'
>> "%PS_TMP%" echo $sc.Save()
powershell -NoProfile -ExecutionPolicy Bypass -File "%PS_TMP%" >nul 2>&1
del "%PS_TMP%" >nul 2>&1
exit /b 0
