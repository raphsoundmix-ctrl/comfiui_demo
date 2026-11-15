@echo off
setlocal
cd /d "%~dp0"
if "%~1"=="" (
  echo Usage: publish_to_github.bat https://github.com/OWNER/REPOSITORY.git
  echo Create an empty GitHub repository first, then pass its clone URL.
  pause
  exit /b 2
)
where git >nul 2>nul
if errorlevel 1 (
  echo Git was not found. Install Git for Windows first.
  pause
  exit /b 1
)
if not exist .git git init
if errorlevel 1 goto :error
git add .
git commit -m "Initial IRON PULSE ComfyUI production pipeline"
if errorlevel 1 echo No new commit was created; continuing.
git branch -M main
git remote get-url origin >nul 2>nul
if errorlevel 1 git remote add origin "%~1"
if errorlevel 1 goto :error
git push -u origin main
if errorlevel 1 goto :error
echo GitHub push completed.
pause
exit /b 0
:error
echo GitHub publish failed. Review Git output above.
pause
exit /b 1
