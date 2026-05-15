#!/bin/bash

# Script để chạy WebBanSach MVC5 Project trên Linux/Mac

echo "======================================="
echo "   WebBanSach - ASP.NET MVC5"
echo "======================================="
echo ""

# Kiểm tra xem có Mono/Dotnet không
if command -v dotnet &> /dev/null; then
    echo "[OK] .NET Framework được tìm thấy"
    echo ""
    echo "Hướng dẫn chạy:"
    echo "1. Mở project folder: cd c:/TH/WebBanSach.MVC5"
    echo "2. Restore NuGet packages"
    echo "3. Build project"
    echo "4. Run with IIS Express"
else
    echo "[X] .NET Framework không được tìm thấy"
fi

echo ""
echo "Database: WebBanSach (SQL Server)"
echo ""
echo "Tài khoản Admin:"
echo "  Email: admin@bookstore.com"
echo "  Password: admin123"
echo ""
