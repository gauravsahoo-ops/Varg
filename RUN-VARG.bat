@echo off
setlocal
title Varg Medical Platform
color 0A

cd /d "%~dp0"

echo ========================================
echo   VARG MEDICAL PLATFORM - QUICK START
echo ========================================
echo.

REM Refresh PATH for double-click launches (Explorer often has a shorter PATH)
set "PATH=%PATH%;%ProgramFiles%\nodejs;%ProgramFiles(x86)%\nodejs;%LOCALAPPDATA%\Programs\Python\Python313;%LOCALAPPDATA%\Programs\Python\Python312;C:\Python313;C:\Python312"

echo Checking Python...
python --version >nul 2>&1
if errorlevel 1 (
  echo.
  echo ERROR: Python not found. Install Python 3.11+ and add it to PATH.
  echo Download: https://www.python.org/downloads/
  pause
  exit /b 1
)

echo Checking Node.js...
node --version >nul 2>&1
if errorlevel 1 (
  echo.
  echo ERROR: Node.js not found. Install Node.js LTS and add it to PATH.
  echo Download: https://nodejs.org/
  pause
  exit /b 1
)

echo.
echo Freeing ports 3000 and 8000...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :3000 ^| findstr LISTENING') do taskkill /PID %%a /F >nul 2>&1
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :8000 ^| findstr LISTENING') do taskkill /PID %%a /F >nul 2>&1

echo.
echo Starting backend on http://localhost:8000 ...
start "Varg Backend" cmd /k "cd /d %~dp0backend && python main-simple.py"

echo Waiting 4 seconds for backend...
timeout /t 4 /nobreak >nul

echo Starting frontend on http://localhost:3000 ...
start "Varg Frontend" cmd /k "cd /d %~dp0frontend && npm run dev"

echo.
echo ========================================
echo   SERVERS STARTED
echo ========================================
echo   Frontend: http://localhost:3000
echo   Backend : http://localhost:8000
echo   API Docs: http://localhost:8000/docs
echo ========================================
echo.
echo Opening browser...
timeout /t 3 /nobreak >nul
start http://localhost:3000
echo.
echo Keep the two server windows open while using the app.
echo You can close this window now.
pause
