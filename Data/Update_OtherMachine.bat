@echo off
chcp 65001 >nul
echo ============================================
echo  Cap nhat WebBanSach - Pull + Build + DB
echo ============================================
echo.

cd /d "%~dp0.."

echo [0/4] Stopping IIS Express (neu dang chay)...
taskkill /F /IM iisexpress.exe >nul 2>&1
echo Done.
echo.

echo [1/4] Pulling latest code from GitHub...
git pull origin main
if %ERRORLEVEL% NEQ 0 (
    echo FAILED: git pull. Kiem tra ket noi mang.
    pause
    exit /b 1
)
echo Done.
echo.

echo [2/4] Rebuilding project (MSBuild)...
set MSBUILD=
for %%p in (
    "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
    "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe"
    "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSBuild.exe"
    "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
) do (
    if exist %%p set MSBUILD=%%p
)

REM Copy DLL quan trong tu packages vao bin truoc khi build
if not exist "bin" mkdir bin
for /r "packages" %%f in (System.Web.WebPages.Razor.dll System.Web.Mvc.dll System.Web.Razor.dll System.Web.WebPages.dll System.Web.WebPages.Deployment.dll Microsoft.Web.Infrastructure.dll EntityFramework.dll EntityFramework.SqlServer.dll) do (
    if exist "%%f" copy /Y "%%f" "bin\" >nul 2>&1
)
echo  - Da copy DLL tu packages vao bin.

if defined MSBUILD (
    %MSBUILD% "WebBanSach.csproj" /p:Configuration=Debug /t:Rebuild /v:minimal
    if %ERRORLEVEL% NEQ 0 (
        echo FAILED: MSBuild error. Mo Visual Studio va chon Rebuild Solution.
        pause
        exit /b 1
    )
    echo Done - Build thanh cong.
) else (
    echo WARNING: Khong tim thay MSBuild. Dung Visual Studio de rebuild thu cong.
)
echo.

echo [3/4] Running Database_fixed.sql on local SQLEXPRESS...
sqlcmd -S .\SQLEXPRESS -i "Data\Database_fixed.sql"
if %ERRORLEVEL% NEQ 0 (
    echo FAILED: Khong the ket noi SQL Server (.\SQLEXPRESS).
    echo Thu chay lenh sau bang tay:
    echo   sqlcmd -S TEN_MAY\SQLEXPRESS -i "Data\Database_fixed.sql"
    pause
    exit /b 1
)
echo Done.
echo.

echo [4/4] Hoan thanh!
echo  - Code da duoc rebuild voi schema tieng Viet (SACH/CHUDE/NHAXUATBAN)
echo  - Database WebBanSach da duoc tao lai sach
echo  - Admin login: admin@bookstore.com / admin123
echo  - Chay website: mo Visual Studio va nhan F5, hoac chay START_SERVER.bat
echo.
pause
