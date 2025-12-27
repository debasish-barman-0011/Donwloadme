# YouTube Video Downloader PC — One-Click Solution

## Quick Start for Non-Technical Users

### Step 1: Download the File

- Click the green **Code** button above
- Click **Download ZIP**
- Extract the ZIP file to your Desktop or any folder

### Step 2: Install Required Software (One-Time Setup)

#### A. Install Python — THE MOST IMPORTANT STEP

- Download Python: https://www.python.org/downloads/
- Run the installer
- CRITICAL: Check ✅ **Add Python to PATH**
- Click **Install Now**

#### B. Install yt-dlp (YouTube Downloader)

- Press **Windows Key + R**
- Type `cmd` and press Enter
- Copy and paste this exact command and press Enter:

```
pip install yt-dlp
```

#### C. Install FFmpeg (Video/Audio Merger)

- Download FFmpeg: https://ffmpeg.org/download.html
- Extract the ZIP file to `C:\ffmpeg\`
- Set up FFmpeg PATH:
  1.  Right-click on "This PC" → **Properties**
  2.  Click **Advanced system settings**
  3.  Click **Environment Variables**
  4.  Under **System variables**, find and click **Path**
  5.  Click **Edit** → **New**
  6.  Type exactly: `C:\ffmpeg\bin`
  7.  Click **OK** on all windows

### Verification (optional)

Run these commands to verify installations:

```
python --version
yt-dlp --version
ffmpeg -version
```

If any step fails, ensure you checked **Add Python to PATH**, restart your terminal, and try again.

---
