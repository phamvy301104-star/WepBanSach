@echo off
REM Script để chạy WebBanSach MVC5 Project

echo.
echo ===============================================
echo   WebBanSach - ASP.NET MVC5 Book Store
echo ===============================================
echo.

REM Kiểm tra xem có Visual Studio không
where devenv >nul 2>nul
if %errorlevel% equ 0 (
    echo [OK] Visual Studio được tìm thấy
    echo.
    echo Mở project trong Visual Studio...
    start devenv "c:\TH\WebBanSach.MVC5\WebBanSach.csproj"
    echo.
    echo Hướng dẫn:
    echo 1. Nhấn F5 để chạy ứng dụng
    echo 2. Hoặc vào Tools ^> NuGet Package Manager ^> Package Manager Console
    echo 3. Chạy: Install-Package EntityFramework -Version 6.2.0
    echo 4. Chạy: Install-Package PagedList -Version 1.17.0.0
    echo 5. Chạy: Install-Package PagedList.Mvc -Version 4.5.0.0
    echo.
) else (
    echo [X] Visual Studio không được tìm thấy
    echo.
    echo Giải pháp: Bạn có thể:
    echo 1. Mở folder c:\TH\WebBanSach.MVC5 bằng Visual Studio
    echo 2. Tạo ASP.NET MVC5 project mới và copy các folder Models, Controllers, Views
    echo.
)

REM Kiểm tra Visual Studio Code
where code >nul 2>nul
if %errorlevel% equ 0 (
    echo [OK] Visual Studio Code được tìm thấy
    echo.
    set /p openVSCode="Bạn có muốn mở trong VS Code không (y/n)? "
    if /i "%openVSCode%"=="y" (
        code "c:\TH\WebBanSach.MVC5"
    )
)

echo.
echo Database: WebBanSach (SQL Server)
echo Connection String: Data Source=.\SQLEXPRESS;Initial Catalog=WebBanSach;Integrated Security=true;
echo.
echo Tài khoản Admin:
echo   Email: admin@bookstore.com
echo   Password: admin123
echo.
echo Tài khoản User:
echo   Email: user@example.com
echo   Password: user123
echo.
echo ===============================================
pause
