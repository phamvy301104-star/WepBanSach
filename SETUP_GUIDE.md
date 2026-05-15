# 🚀 HƯỚNG DẪN CÀI ĐẶT & CHẠY WEBDANSACH MVC5

## ✅ Những Gì Đã Được Chuẩn Bị

- ✅ Database: **WebBanSach** (SQL Server)
- ✅ 7 Bảng + Dữ liệu mẫu (10 sách, 2 user)
- ✅ Tất cả code: Models, Controllers, Views
- ✅ Configuration: Web.config, Global.asax
- ✅ NuGet packages config

## ⚠️ Yêu Cầu Còn Cần

- Visual Studio 2015+ (hoặc Visual Studio Community - miễn phí)
- .NET Framework 4.5.2+
- NuGet Packages (sẽ tự động cài)

---

## 📋 BƯỚC 1: Cài Đặt Visual Studio (Nếu Chưa Có)

### Option A: Visual Studio Community (Miễn Phí)
1. Truy cập: https://visualstudio.microsoft.com/vs/community/
2. Tải về & chạy installer
3. Chọn: **ASP.NET và phát triển web**
4. Chọn: **.NET Framework 4.5.2 SDK**
5. Tiếp tục cài đặt

### Option B: Nếu đã có Visual Studio
- Đảm bảo có ASP.NET & Web Development Tools
- Kiểm tra: Tools → Get Tools and Features → ASP.NET

---

## 📋 BƯỚC 2: Mở Project

### Cách 1: Từ Visual Studio (Khuyên Dùng)
1. Mở Visual Studio
2. File → Open → Project/Solution
3. Chọn: `c:\TH\WebBanSach.MVC5\WebBanSach.sln`
4. Chờ project load

### Cách 2: Tạo Project Mới & Copy Code
1. Visual Studio → File → New → Project
2. Chọn: **ASP.NET Web Application** → Next
3. Chọn: **.NET Framework 4.5.2**
4. Chọn: **MVC** template
5. Copy các folder từ `c:\TH\WebBanSach.MVC5`:
   - `Models/*`
   - `Controllers/*`
   - `Views/*`
   - `App_Start/*`
   - `Web.config`
   - `Global.asax`

---

## 📋 BƯỚC 3: Cài Đặt NuGet Packages

### Phương Pháp 1: Package Manager Console (Nhanh & Đơn Giản)

1. Visual Studio → Tools → NuGet Package Manager → Package Manager Console
2. Chạy lần lượt các lệnh:

```powershell
# Install Entity Framework
Install-Package EntityFramework -Version 6.2.0

# Install PagedList
Install-Package PagedList -Version 1.17.0.0

# Install PagedList.Mvc
Install-Package PagedList.Mvc -Version 4.5.0.0
```

3. Chờ cài đặt hoàn tất (sẽ có thông báo)

### Phương Pháp 2: NuGet Package Manager UI
1. Right-click Project → Manage NuGet Packages
2. Tìm kiếm: `EntityFramework` → Cài Version 6.2.0
3. Tìm kiếm: `PagedList` → Cài Version 1.17.0.0
4. Tìm kiếm: `PagedList.Mvc` → Cài Version 4.5.0.0

---

## 📋 BƯỚC 4: Kiểm Tra Connection String

1. Mở file: `Web.config`
2. Tìm dòng:
```xml
<connectionStrings>
  <add name="WebBanSachConnection" 
       connectionString="Data Source=.\SQLEXPRESS;Initial Catalog=WebBanSach;Integrated Security=true;MultipleActiveResultSets=True;App=EntityFramework" 
       providerName="System.Data.SqlClient" />
</connectionStrings>
```

3. **Nếu SQL Server của bạn khác tên** (ví dụ: localhost hoặc tên server khác), sửa:
   - `Data Source=.\SQLEXPRESS` → Thay `SQLEXPRESS` bằng tên SQL Server của bạn
   - Ví dụ: `Data Source=(local)`
   - Hoặc: `Data Source=TENCAY\SQLEXPRESS`

4. **Lưu file**

---

## 📋 BƯỚC 5: Build Project

1. **Menu:** Build → Clean Solution
2. **Menu:** Build → Build Solution
3. **Chờ** cho đến khi thấy: "Build succeeded"

**Nếu có lỗi:**
- Kiểm tra lại Connection String
- Kiểm tra SQL Server đang chạy
- Delete folder `bin` & `obj`, rebuild

---

## 🚀 BƯỚC 6: Chạy Ứng Dụng

### Cách 1: IIS Express (Khuyên Dùng)
1. Nhấn **F5** hoặc Ctrl+F5
2. Chờ IIS Express khởi động
3. Browser sẽ mở tự động tại: `http://localhost:port/`

### Cách 2: Từ Visual Studio
1. Right-click project → Properties
2. Tab "Web"
3. Chọn: "Local IIS" hoặc "IIS Express"
4. Nhấn F5

---

## ✅ TEST CHỨC NĂNG

### 1️⃣ Trang Chủ
- **URL:** `http://localhost:port/Home/Index`
- **Kỳ vọng:**
  - Hiển thị 10 cuốn sách
  - Menu danh mục bên trái
  - Nút "Chi tiết" & "Thêm vào giỏ"

### 2️⃣ Đăng Ký
- **URL:** `http://localhost:port/Account/Register`
- **Test:**
  - Nhập thông tin: Tên, Email, Điện thoại, Ngày sinh, Mật khẩu
  - Nhấn "Đăng Ký"
  - Kiểm tra database xem người dùng được tạo

### 3️⃣ Đăng Nhập
- **URL:** `http://localhost:port/Account/Login`
- **Test Admin:**
  - Email: `admin@bookstore.com`
  - Mật khẩu: `admin123`
  - Nhấn "Đăng Nhập"

### 4️⃣ Giỏ Hàng
- Từ trang chủ → Nhấn "Thêm vào giỏ" (cần đăng nhập trước)
- **URL:** `http://localhost:port/Cart/Index`
- Xem giỏ hàng, cập nhật số lượng

### 5️⃣ Admin Dashboard
- Sau đăng nhập admin → Tự động đến: `http://localhost:port/Admin/Dashboard`
- Hoặc click: "Admin" trên navbar
- **Kỳ vọng:**
  - Hiển thị thống kê: Tổng sách, đơn hàng, người dùng, doanh thu

### 6️⃣ Quản Lý Sách
- **URL:** `http://localhost:port/Admin/Books`
- **Test:**
  - Nhấn "Thêm Sách Mới"
  - Nhập thông tin
  - Upload ảnh
  - Nhấn "Thêm Sách"

---

## 📊 DATABASE CREDENTIALS

```
Server: .\SQLEXPRESS
Database: WebBanSach
Authentication: Windows (Integrated)

Tài khoản Admin:
  Email: admin@bookstore.com
  Password: admin123
  Role: 1 (Admin)

Tài khoản User:
  Email: user@example.com
  Password: user123
  Role: 0 (User)
```

---

## ❌ KHẮC PHỤC SỰ CỐ

### Lỗi: "System.Data.SqlClient.SqlException: Cannot open database"
**Giải pháp:**
1. Kiểm tra SQL Server đang chạy: Start → SQL Server Configuration Manager
2. Kiểm tra Connection String trong Web.config
3. Kiểm tra database tên: `WebBanSach` (chính xác)

### Lỗi: "The type or namespace name 'PagedList' could not be found"
**Giải pháp:**
- Cài lại NuGet package: `Install-Package PagedList -Version 1.17.0.0`
- Hoặc: Right-click project → Manage NuGet Packages → Tìm & cài

### Lỗi: "No HTTP resource was found that matches the request URI"
**Giải pháp:**
- Kiểm tra URL có đúng không
- Kiểm tra Controllers & Views tồn tại
- Rebuild solution

### Lỗi Build: "The project file could not be loaded"
**Giải pháp:**
- Delete: `bin` & `obj` folder
- Right-click project → Unload Project
- Right-click project → Reload Project
- Rebuild

### Ứng dụng chạy chậm
**Giải pháp:**
- Chạy Release build: Build → Configuration Manager → Release
- Rebuild solution

---

## 🎯 NEXT STEPS

Sau khi chạy thành công:
1. ✅ Chụp ảnh các màn hình làm việc
2. ✅ Lấy dữ liệu từ database để chứng minh
3. ✅ Chuẩn bị file để nộp bài

---

## 📞 LIÊN HỆ HỖ TRỢ

Nếu gặp vấn đề:
1. Kiểm tra: `README.md`, `HUONG_DAN_SU_DUNG.md`
2. Kiểm tra `LAB_SUMMARY.md` để biết chi tiết từng Lab
3. Kiểm tra Connection String & Database

---

**🎉 Chúc bạn thành công!**
