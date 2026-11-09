@echo off
setlocal
cd /d "%~dp0"
title AI-Powered College Placement Portal - Process Stopper

powershell -ExecutionPolicy Bypass -NoProfile -File "%~dp0stop.ps1"

echo.
pause
