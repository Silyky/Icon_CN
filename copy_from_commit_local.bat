@echo off
setlocal enabledelayedexpansion

:: Set paths
set "REPO_PATH=D:\Tof\zz_Tof_Git\Tower-of-fantasy-game-resources"
set "DEST_FOLDER=D:\Tof\zz_Tof_Git\new_files"

:: Ask for commit hash
set /p COMMIT_HASH=Enter commit hash: 

:: Verify if inside a Git repository
git rev-parse --is-inside-work-tree >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: This is not a Git repository!
    pause
    exit /b
)

:: Clear the destination folder before copying new files
if exist "%DEST_FOLDER%" (
    echo Cleaning up %DEST_FOLDER%...
    del /q "%DEST_FOLDER%\*.*"
) else (
    mkdir "%DEST_FOLDER%"
)

:: Generate list.txt with absolute paths (fixing slashes)
echo Generating list of files...
(for /f "delims=" %%F in ('git diff-tree --no-commit-id --name-only --diff-filter=A -r %COMMIT_HASH%') do (
    set "FILE_PATH=%REPO_PATH%\%%F"
    set "FILE_PATH=!FILE_PATH:/=\!"
    echo !FILE_PATH!
)) > list.txt

:: Verify if list.txt was created
if not exist list.txt (
    echo Error: list.txt was not created. Check the commit hash.
    pause
    exit /b
)

:: Copy files to DEST_FOLDER without keeping folder structure
echo Copying files to %DEST_FOLDER%...
(for /f "delims=" %%F in (list.txt) do (
    set "SRC_FILE=%%F"
    set "FILENAME=%%~nxF"

    if exist "!SRC_FILE!" (
        copy "!SRC_FILE!" "%DEST_FOLDER%\!FILENAME!" /Y >nul
    ) else (
        echo File not found: !SRC_FILE! >> missing_files.log
    )
))

:: Delete list.txt after script execution
:: if exist list.txt del list.txt

echo Done! Files copied to %DEST_FOLDER%.
echo Check missing_files.log if some files were not found.
pause
