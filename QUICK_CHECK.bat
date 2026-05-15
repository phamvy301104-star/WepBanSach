@echo off
REM ============================================
REM WebBanSach Project - Quick Setup Script
REM ============================================

echo.
echo ============================================
echo   WebBanSach MVC5 - Quick Setup
echo ============================================
echo.

REM Check SQL Server
echo [1/3] Checking SQL Server connection...
sqlcmd -S .\SQLEXPRESS -E -Q "SELECT 1" >nul 2>nul
if %errorlevel% equ 0 (
    echo [OK] SQL Server SQLEXPRESS is running
) else (
    echo [ERROR] Cannot connect to SQL Server SQLEXPRESS
    echo Please start SQL Server and try again
    pause
    exit /b 1
)

REM Check Database
echo.
echo [2/3] Checking WebBanSach database...
sqlcmd -S .\SQLEXPRESS -E -Q "USE WebBanSach; SELECT COUNT(*) FROM sysobjects WHERE xtype='U'" >nul 2>nul
if %errorlevel% equ 0 (
    echo [OK] WebBanSach database exists and is accessible
) else (
    echo [ERROR] WebBanSach database not found
    pause
    exit /b 1
)

REM Check Project Files
echo.
echo [3/3] Checking project files...
if exist "c:\TH\WebBanSach.MVC5\WebBanSach.sln" (
    echo [OK] Project file found: WebBanSach.sln
) else (
    echo [ERROR] Project file not found
    pause
    exit /b 1
)

if exist "c:\TH\WebBanSach.MVC5\Web.config" (
    echo [OK] Web.config found
) else (
    echo [ERROR] Web.config not found
    pause
    exit /b 1
)

echo.
echo ============================================
echo   ✓ Setup Check Passed!
echo ============================================
echo.
echo PROJECT INFORMATION:
echo   Location: c:\TH\WebBanSach.MVC5
echo   Solution: WebBanSach.sln
echo   Database: WebBanSach (SQL Server SQLEXPRESS)
echo.
echo NEXT STEPS:
echo   1. Open Visual Studio
echo   2. File ^> Open ^> Project/Solution
echo   3. Select: c:\TH\WebBanSach.MVC5\WebBanSach.sln
echo   4. Install NuGet packages (see SETUP_GUIDE.md)
echo   5. Press F5 to run
echo.
echo DATABASE ACCOUNTS:
echo   Admin:  admin@bookstore.com / admin123
echo   User:   user@example.com / user123
echo.
echo DOCUMENTATION:
echo   - README.md              (Overview)
echo   - SETUP_GUIDE.md         (Setup instructions)
echo   - HUONG_DAN_SU_DUNG.md   (Vietnamese guide)
echo   - LAB_SUMMARY.md         (Lab details)
echo   - TEST_PAGE.html         (View in browser)
echo.
echo ============================================
pause
