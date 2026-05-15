@echo off
chcp 65001 >nul
echo ============================================
echo  Cap nhat WebBanSach - Pull + Khoi tao DB
echo ============================================
echo.

cd /d "%~dp0.."

echo [1/3] Pulling latest code from GitHub...
git pull origin main
if %ERRORLEVEL% NEQ 0 (
    echo FAILED: git pull. Kiem tra ket noi mang hoac qua trinh cai dat Git.
    pause
    exit /b 1
)
echo Done.
echo.

echo [2/3] Running Database_fixed.sql on local SQLEXPRESS...
sqlcmd -S .\SQLEXPRESS -i "Data\Database_fixed.sql"
if %ERRORLEVEL% NEQ 0 (
    echo FAILED: Khong the ket noi SQL Server.
    echo Thu chay: sqlcmd -S TEN_MAY\SQLEXPRESS -i "Data\Database_fixed.sql"
    pause
    exit /b 1
)
echo Done.
echo.

echo [3/3] Hoan thanh!
echo  - Database WebBanSach da duoc cap nhat voi schema tieng Viet (SACH/CHUDE/NHAXUATBAN)
echo  - Admin login: admin@bookstore.com / admin123
echo  - Chay website: START_SERVER.bat
echo.
pause
