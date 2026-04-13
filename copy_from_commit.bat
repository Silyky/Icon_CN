@echo off
setlocal enabledelayedexpansion

:: Repository URL
set "REPO_URL=https://github.com/smilekritik/Tower-of-fantasy-game-resources"

:: Prompt for commit hash
set /p "COMMIT_HASH=Enter the commit hash: "

:: Define paths
set "TEMP_REPO=%~dp0temp_repo"
set "DEST_FOLDER=%~dp0%COMMIT_HASH%"

:: Clone repository if not already cloned
if not exist "%TEMP_REPO%" (
    echo Cloning repository...
    git clone "%REPO_URL%" "%TEMP_REPO%"
    if %errorlevel% neq 0 (
        echo Error: Failed to clone the repository. Check the URL.
        exit /b
    )
)

:: Verify repository clone
if not exist "%TEMP_REPO%\.git" (
    echo Error: Repository not cloned successfully.
    exit /b
)

:: Navigate to repository and check out commit
cd /d "%TEMP_REPO%"
echo Checking out commit %COMMIT_HASH%...
git checkout --quiet %COMMIT_HASH% >nul 2>&1 || (
    echo Error: Failed to check out the commit. Verify the hash.
    exit /b
)

:: Create destination folder
if not exist "%DEST_FOLDER%" mkdir "%DEST_FOLDER%"

:: Generate list of files
echo Generating file list...
(for /f "delims=" %%F in ('git diff-tree --no-commit-id --name-only --diff-filter=A -r %COMMIT_HASH%') do (
    set "FILE_PATH=%TEMP_REPO%\%%F"
    set "FILE_PATH=!FILE_PATH:/=\!"
    if exist "!FILE_PATH!" echo !FILE_PATH!>>"%~dp0list.txt"
)) >nul 2>&1

:: Verify list creation
if not exist "%~dp0list.txt" (
    echo Error: Failed to generate file list.
    exit /b
)

:: Copy files to destination folder
echo Copying files to %DEST_FOLDER%...
(for /f "delims=" %%F in (%~dp0list.txt) do (
    set "SRC_FILE=%%F"
    set "FILENAME=%%~nxF"

    if exist "!SRC_FILE!" (
        copy "!SRC_FILE!" "%DEST_FOLDER%\!FILENAME!" /Y >nul
    ) else (
        echo File not found: !SRC_FILE! >> missing_files.log
    )
))

:: Clean up
del "%~dp0list.txt" >nul 2>&1

echo Done! Files copied to %DEST_FOLDER%.
echo Check missing_files.log for any missing files.
