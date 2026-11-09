@echo off
setlocal
cd /d "%~dp0"
title AI-Powered College Placement Portal - Launcher

echo =====================================================================
echo       AI-POWERED COLLEGE PLACEMENT PORTAL - STARTUP SYSTEM
echo =====================================================================
echo.

:: 1. Check Node.js
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Node.js is not installed or not in PATH!
    echo Please install Node.js 18+ from https://nodejs.org
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('node -v') do set NODE_VER=%%i
echo [OK] Node.js detected: %NODE_VER%

:: 2. Check Python
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Python is not installed or not in PATH!
    echo Please install Python 3.10+ from https://python.org
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('python --version') do set PY_VER=%%i
echo [OK] Python detected: %PY_VER%

:: 3. Check environment files
if not exist "backend\.env" (
    echo [INFO] Creating backend\.env from template...
    copy ".env.example" "backend\.env" >nul
)
if not exist "frontend\.env" (
    echo [INFO] Creating frontend\.env...
    echo VITE_API_URL=http://localhost:5000/api > "frontend\.env"
)

:: 4. Ensure dependencies
if not exist "backend\node_modules" (
    echo [INFO] Installing backend dependencies...
    cd /d "%~dp0backend"
    call npm install
    cd /d "%~dp0"
)

if not exist "frontend\node_modules" (
    echo [INFO] Installing frontend dependencies...
    cd /d "%~dp0frontend"
    call npm install
    cd /d "%~dp0"
)

:: 5. Check Python AI dependencies
echo [INFO] Checking Python AI dependencies...
python -c "import fastapi, uvicorn, pypdf, sklearn, multipart" >nul 2>nul
if %errorlevel% neq 0 (
    echo [INFO] Installing missing Python packages...
    pip install fastapi uvicorn python-multipart pypdf pymupdf scikit-learn
)

:: 6. Seed default Admin if MongoDB is running
echo [INFO] Verifying initial database setup...
cd /d "%~dp0backend"
node utils/seedAdmin.js >nul 2>nul
cd /d "%~dp0"

echo.
echo =====================================================================
echo  Launching Services:
echo   - Backend API:    http://localhost:5000
echo   - AI Service:     http://localhost:8000
echo   - Frontend Web:   http://localhost:5173
echo =====================================================================
echo.

:: 7. Launch Backend, AI Service, and Frontend
start "Placement Portal - Backend API [5000]" /D "%~dp0backend" cmd /k "npm run dev"
start "Placement Portal - AI Service [8000]" /D "%~dp0ai-service" cmd /k "python app.py"
start "Placement Portal - Frontend Web [5173]" /D "%~dp0frontend" cmd /k "npm run dev"

echo [INFO] All services successfully launched in background.
echo [INFO] Opening Placement Portal in your default web browser...
ping -n 3 127.0.0.1 >nul

:: 8. Directly launch website in default browser
start "" "http://localhost:5173"

echo.
echo =====================================================================
echo  Website is running and opened at: http://localhost:5173
echo.
echo  Keep the service windows open while using the application.
echo  To safely close all services, run stop.bat
echo =====================================================================
echo.
pause
