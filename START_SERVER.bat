@echo off
cd /d "c:\TH\WebBanSach.MVC5"
echo ===================================================
echo  WebBanSach MVC5 - Starting IIS Express
echo ===================================================
echo.
echo Starting server on http://localhost:8080
echo.
"C:\Program Files\IIS Express\iisexpress.exe" /path:. /port:8080
pause
