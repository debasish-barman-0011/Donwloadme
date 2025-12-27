@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

REM ============================================
REM   Downloadme - YouTube Video Downloader
REM   WITH ERROR HANDLING FOR OTHER MACHINES
REM ============================================

:CHECK_PREREQUISITES
REM Check if yt-dlp is installed
where yt-dlp >nul 2>nul
if %errorlevel% neq 0 (
    cls
    echo ============================================
    echo    ERROR: yt-dlp is not installed!
    echo ============================================
    echo.
    echo To install yt-dlp, follow these steps:
    echo 1. Open Command Prompt as Administrator
    echo 2. Type: pip install yt-dlp
    echo 3. Press Enter and wait for installation
    echo.
    echo If pip is not found, install Python first from python.org
    echo Make sure to check "Add Python to PATH" during installation.
    echo.
    pause
    exit /b 1
)

REM Optional: Check if ffmpeg is installed (for merging)
REM where ffmpeg >nul 2>nul
REM if %errorlevel% neq 0 (
REM     echo.
REM     echo WARNING: FFmpeg is not installed or not in PATH.
REM     echo Some features may not work properly.
REM     echo Download from: https://ffmpeg.org/download.html
REM     echo.
REM     timeout /t 5 >nul
REM )

:TITLE
cls
echo ============================================
echo    Downloadme - YouTube Video Downloader
echo ============================================
echo.
echo NOTE: Make sure you have installed:
echo       1. Python (with PATH)
echo       2. yt-dlp (pip install yt-dlp)
echo       3. FFmpeg (optional, for best results)
echo ============================================
echo.

:INPUT
set "url="
set /p "url=Please Paste YouTube URL : "

if "!url!"=="" (
    echo.
    echo Error: No URL Pasted...!
    timeout /t 2 >nul
    goto INPUT
)

echo.
echo Select Quality By Pressing Number 1 - 4:
echo 1 - Best Quality (Video + Audio)
echo 2 - Best Video up to 1080p
echo 3 - Best Video up to 2160p (4K)
echo 4 - Audio Only (MP3)
echo.
choice /c 1234 /N /M "Select Quality (1 - 4): "

REM Store choice in variable
set "quality=!errorlevel!"

echo.
echo ============================================
echo Starting download...
echo URL: !url!
echo Quality Option: !quality!
echo ============================================
echo.

REM Add a pause before download so user can see what's happening
timeout /t 2 >nul

if !quality! equ 1 (
    echo Downloading : Best Overall Quality...
    echo.
    yt-dlp -f "best" -o "%%(title)s.%%(ext)s" "!url!"
    call :CHECK_ERROR
)

if !quality! equ 2 (
    echo Downloading : Best Video up to 1080p with Best Audio...
    echo.
    yt-dlp -f "bestvideo[height<=1080]+bestaudio/best" --merge-output-format mkv -o "%%(title)s.%%(ext)s" "!url!"
    call :CHECK_ERROR
)

if !quality! equ 3 (
    echo Downloading : Best Video up to 2160p with Best Audio...
    echo.
    yt-dlp -f "bestvideo[vcodec^=avc1][height<=2160]+bestaudio/best" --merge-output-format mkv -o "%%(title)s.%%(ext)s" "!url!"
    call :CHECK_ERROR
)

if !quality! equ 4 (
    echo Downloading : MP3 Audio Only...
    echo.
    yt-dlp -x --audio-format mp3 -o "%%(title)s.%%(ext)s" "!url!"
    call :CHECK_ERROR
)

REM Skip to end if we already handled the error
if defined ERROR_HANDLED goto :POST_DOWNLOAD

:POST_DOWNLOAD
echo.
echo ============================================
if !errorlevel! equ 0 (
    echo <============ Downloaded Successfully =============>
) else (
    echo ... Something Went Wrong - Operation Failed ...
    echo.
    echo TROUBLESHOOTING:
    echo 1. Check if yt-dlp is installed: Open CMD and type "yt-dlp --version"
    echo 2. Check if Python is in PATH: Open CMD and type "python --version"
    echo 3. Try updating yt-dlp: pip install --upgrade yt-dlp
    echo 4. Make sure the URL is correct and video is accessible
    echo.
    echo Press any key to see the error details...
    pause >nul
    echo.
    echo Last command error code: !errorlevel!
)
echo ============================================

echo.
echo Ready to Download Another in 5 seconds...
echo Press CTRL+C to exit now.
timeout /t 5 >nul

goto TITLE

REM ============================================
REM ERROR HANDLING SUBROUTINE
REM ============================================
:CHECK_ERROR
if !errorlevel! neq 0 (
    echo.
    echo ============================================
    echo ERROR: Download failed with code !errorlevel!
    echo ============================================
    echo.
    echo Possible reasons:
    echo 1. yt-dlp not installed or not in PATH
    echo 2. Python not installed or not in PATH
    echo 3. FFmpeg needed but not installed (for merging)
    echo 4. Invalid URL or video not accessible
    echo 5. Network connection issue
    echo.
    echo FIXES:
    echo - Install Python from python.org (check "Add to PATH")
    echo - Install yt-dlp: pip install yt-dlp
    echo - Install FFmpeg from ffmpeg.org
    echo - Restart computer after installations
    echo.
    echo Press any key to continue...
    pause >nul
    set "ERROR_HANDLED=1"
)
exit /b

REM ============================================
REM END OF SCRIPT
REM ============================================