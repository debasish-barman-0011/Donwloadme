@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

:TITLE
cls
echo ============================================
echo    Downloadme - YouTube Video Downloader
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

if !errorlevel! equ 1 (
    echo Downloading : Best Overall Quality.
    yt-dlp -f "best" -o "%%(title)s.%%(ext)s" "!url!"
)

if !errorlevel! equ 2 (
    echo Downloading : Best Video up to 1080p with Best Audio.
    yt-dlp -f "bestvideo[height<=1080]+bestaudio/best" --merge-output-format mkv -o "%%(title)s.%%(ext)s" "!url!"
)

if !errorlevel! equ 3 (
    echo Downloading : Best Video up to 2160p with Best Audio.
    yt-dlp -f "bestvideo[vcodec^=avc1][height<=2160]+bestaudio/best" --merge-output-format mkv -o "%%(title)s.%%(ext)s" "!url!"
)

if !errorlevel! equ 4 (
    echo Downloading : MP3 Audio Only.
    yt-dlp -x --audio-format mp3 -o "%%(title)s.%%(ext)s" "!url!"
)

if !errorlevel! equ 0 (
    echo.
    echo <============Downloaded Successfully=============>
) else (
    echo.
    echo ...Something Went Wrong Operation Failed...
)

echo.
echo Ready to Download Another in 3 seconds...
timeout /t 3 >nul

goto TITLE