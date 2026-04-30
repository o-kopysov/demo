@echo off
setlocal enabledelayedexpansion

:: Check if a path was provided
if "%~1"=="" (
    echo Usage: %~nx0 "path_to_folder"
    echo Example: %~nx0 "C:\projects"
    exit /b 1
)

set "BASE_PATH=%~1"

:: Check if the directory exists
if not exist "%BASE_PATH%" (
    echo Error: Directory "%BASE_PATH%" does not exist.
    exit /b 1
)

:: Iterate through sub-folders named with numbers (1, 2, 3, ...)
for /f "delims=" %%d in ('dir /b /ad "%BASE_PATH%" 2^>nul ^| findstr /r "^[0-9][0-9]*$"') do (
    set "subfolder=%BASE_PATH%\%%d"
    echo Starting in sub-folder: %%d
    :: Open new cmd window, cd to subfolder, and run python main.py
    start "Folder %%d - Python Script" cmd /k "cd /d "!subfolder!" && python main.py"
    :: Wait 2 seconds before starting next window
    timeout /t 2 /nobreak >nul
)

echo All sub-folders processed.
exit /b 0
