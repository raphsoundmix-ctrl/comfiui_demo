@echo off
setlocal
cd /d "%~dp0"
if exist .venv\Scripts\activate.bat call .venv\Scripts\activate.bat
python -m orchestrator.cli dry-run --stage keyframes
if errorlevel 1 echo Command returned errorlevel %errorlevel%. Review the output above.
pause
