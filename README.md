# 📚 WebBanSach - Dự Án Website Bán Sách ASP.NET MVC5

## Giới Thiệu
**WebBanSach** là một ứng dụng web bán sách hoàn chỉnh được xây dựng với **ASP.NET MVC5** và **Entity Framework 6**, được thiết kế để hoàn thành các bài Lab từ **Lab 5 đến Lab 12** của khóa học Lập Trình Web.

## Tính Năng Chính

### 🏠 Trang Chủ (LAB 5)
- ✅ Hiển thị danh sách sách với phân trang (10 sách/trang)
- ✅ Menu danh mục sách theo chủ đề
- ✅ Menu danh mục sách theo nhà xuất bản
- ✅ Trang chi tiết sản phẩm đầy đủ

### 👤 Người Dùng (LAB 7-8)
- ✅ Trang đăng ký người dùng mới
- ✅ Lưu trữ thông tin: Tên, Email, Điện thoại, Ngày sinh, Địa chỉ
- ✅ Trang đăng nhập với kiểm tra thông tin đăng nhập
- ✅ Quản lý phiên (Session)
- ✅ Phân quyền: Người dùng thường & Admin

### 🛒 Giỏ Hàng & Thanh Toán (LAB 9-10)
- ✅ Thêm sách vào giỏ hàng
- ✅ Cập nhật số lượng sách
- ✅ Xóa sách khỏi giỏ hàng
- ✅ Hiển thị tổng tiền
- ✅ Xác nhận đơn hàng (checkout)
- ✅ Lưu trữ đơn hàng trong database

### ⚙️ Quản Lý Admin (LAB 11-12)
- ✅ Dashboard với thống kê
- ✅ Quản lý sách (CRUD)
- ✅ Thêm/sửa/xóa sách
- ✅ Upload hình ảnh sách
- ✅ Trình soạn thảo TinyMCE cho mô tả sách
- ✅ Phân trang danh sách sách
- ✅ Quản lý đơn hàng
- ✅ Cập nhật trạng thái đơn hàng

## Công Nghệ Sử Dụng

| Công Nghệ | Phiên Bản | Mục Đích |
|-----------|----------|---------|
| ASP.NET MVC | 5.2.7 | Framework web |
| Entity Framework | 6.2.0 | ORM - Truy cập database |
| SQL Server | 2012+ | Database |
| Bootstrap | 4.5.2 | Front-end CSS |
| jQuery | 3.5.1 | JavaScript |
| Font Awesome | 5.15.4 | Icon |
| TinyMCE | 4 | Trình soạn thảo rich text |
| PagedList | 1.17.0 | Phân trang |

## Cấu Trúc Dự Án

```
WebBanSach.MVC5/
│
├── Models/                    # Entity Models
│   ├── Category.cs
│   ├── Publisher.cs
│   ├── Book.cs
│   ├── User.cs
│   ├── Order.cs
│   ├── OrderDetail.cs
│   ├── CartItem.cs
│   └── WebBanSachContext.cs  # DbContext
│
├── Controllers/               # MVC Controllers
│   ├── HomeController.cs      # Trang chủ & chi tiết
│   ├── AccountController.cs   # Đăng ký & đăng nhập
│   ├── CartController.cs      # Giỏ hàng & thanh toán
│   └── AdminController.cs     # Quản lý admin
│
├── Views/                     # Razor Views
│   ├── Home/
│   │   ├── Index.cshtml       # Trang chủ
│   │   └── Details.cshtml     # Chi tiết sách
│   ├── Account/
│   │   ├── Register.cshtml    # Đăng ký
│   │   └── Login.cshtml       # Đăng nhập
│   ├── Cart/
│   │   └── Index.cshtml       # Giỏ hàng
│   ├── Admin/
│   │   ├── Dashboard.cshtml   # Bảng điều khiển
│   │   ├── Books.cshtml       # Danh sách sách
│   │   ├── CreateBook.cshtml  # Thêm sách
│   │   ├── EditBook.cshtml    # Sửa sách
│   │   ├── Orders.cshtml      # Danh sách đơn hàng
│   │   └── OrderDetails.cshtml # Chi tiết đơn hàng
│   └── Shared/
│       └── _Layout.cshtml     # Master layout
│
├── Content/
│   └── Images/                # Upload ảnh sách
│
├── Data/
│   └── Database.sql           # Script tạo database
│
├── App_Start/
│   ├── FilterConfig.cs
│   └── RouteConfig.cs
│
├── Web.config                 # Cấu hình IIS
├── Global.asax.cs             # Application events
├── packages.config            # NuGet packages
└── HUONG_DAN_SU_DUNG.md       # Hướng dẫn chi tiết
```

## Mô Hình Database

### Sơ Đồ Quan Hệ (ERD)

```
Categories (1) ──── (N) Books
                      │
                      ├── (N) OrderDetails
                      └── (N) CartItems

Publishers (1) ──── (N) Books

Users (1) ──── (N) Orders
        │
        └── (N) CartItems

Orders (1) ──── (N) OrderDetails
               └── (N) Books
```

### Bảng Dữ Liệu Chính

**Categories** - Danh mục sách
- CategoryID (PK)
- CategoryName
- Description
- CreatedDate

**Publishers** - Nhà xuất bản
- PublisherID (PK)
- PublisherName
- Address
- Phone
- Email

**Books** - Sách
- BookID (PK)
- BookTitle
- Author
- Description
- Price
- Quantity
- ImagePath
- CategoryID (FK)
- PublisherID (FK)
- PublishedDate
- IsActive

**Users** - Người dùng
- UserID (PK)
- FullName
- Email (UNIQUE)
- Password
- Phone
- DateOfBirth
- Address
- Role (0=User, 1=Admin)
- IsActive

**Orders** - Đơn hàng
- OrderID (PK)
- UserID (FK)
- OrderDate
- TotalAmount
- Status (0=Pending, 1=Confirmed, 2=Shipped, 3=Delivered, 4=Cancelled)
- ShippingAddress
- Note
- UpdatedDate

**OrderDetails** - Chi tiết đơn hàng
- OrderDetailID (PK)
- OrderID (FK)
- BookID (FK)
- Quantity
- UnitPrice
- TotalPrice

**CartItems** - Giỏ hàng
- CartItemID (PK)
- UserID (FK)
- BookID (FK)
- Quantity
- AddedDate

## Hướng Dẫn Cài Đặt

### Yêu Cầu
- Visual Studio 2015+ hoặc Visual Studio Code
- SQL Server 2012+ hoặc SQL Server Express
- .NET Framework 4.5.2+

### Bước 1: Clone/Download Project
```bash
# Clone repository hoặc download project
cd WebBanSach.MVC5
```

### Bước 2: Tạo Database
1. Mở SQL Server Management Studio
2. Chạy script từ `Data/Database.sql`

### Bước 3: Cấu Hình Connection String
Cập nhật `Web.config`:
```xml
<connectionStrings>
  <add name="WebBanSachConnection" 
       connectionString="Data Source=.\SQLEXPRESS;Initial Catalog=WebBanSach;Integrated Security=true;MultipleActiveResultSets=True;App=EntityFramework" 
       providerName="System.Data.SqlClient" />
</connectionStrings>
```

### Bước 4: Cài Đặt NuGet Packages
Mở Package Manager Console:
```powershell
Install-Package EntityFramework -Version 6.2.0
Install-Package PagedList -Version 1.17.0.0
Install-Package PagedList.Mvc -Version 4.5.0.0
```

### Bước 5: Chạy Ứng Dụng
- Nhấn F5 hoặc Ctrl+F5
- Ứng dụng sẽ khởi động tại `http://localhost:port/`

## Tài Khoản Mặc Định

### Admin
- **Email:** admin@bookstore.com
- **Mật khẩu:** admin123
- **Vai trò:** Quản trị viên

### Người Dùng Mẫu
- **Email:** user@example.com
- **Mật khẩu:** user123
- **Vai trò:** Người dùng thường

## Hướng Dẫn Sử Dụng

### Cho Người Dùng Thường

#### Duyệt Sách
1. Vào trang chủ: `http://localhost/Home/Index`
2. Xem danh sách sách hoặc tìm theo danh mục
3. Click vào sách để xem chi tiết

#### Mua Sách
1. Từ trang chi tiết: Nhấn "Thêm vào giỏ hàng"
2. Vào giỏ hàng: `http://localhost/Cart/Index`
3. Cập nhật số lượng nếu cần
4. Nhấn "Thanh Toán"
5. Nhập thông tin giao hàng
6. Xác nhận đơn hàng

#### Đăng Ký/Đăng Nhập
1. Đăng ký: `http://localhost/Account/Register`
2. Đăng nhập: `http://localhost/Account/Login`

### Cho Quản Trị Viên

#### Vào Admin Dashboard
1. Đăng nhập với tài khoản admin
2. Tự động chuyển đến: `http://localhost/Admin/Dashboard`

#### Quản Lý Sách
1. Vào: `http://localhost/Admin/Books`
2. **Thêm sách:** Nhấn "Thêm Sách Mới"
   - Nhập thông tin
   - Upload ảnh
   - Nhập mô tả (TinyMCE)
   - Nhấn "Thêm Sách"
3. **Sửa sách:** Nhấn "Sửa" → Thay đổi → "Cập Nhật"
4. **Xóa sách:** Nhấn "Xóa" → Xác nhận

#### Quản Lý Đơn Hàng
1. Vào: `http://localhost/Admin/Orders`
2. Xem danh sách đơn hàng
3. Nhấn "Chi Tiết" để xem chi tiết
4. Cập nhật trạng thái đơn hàng

## Các Tính Năng Nâng Cao

### 📊 Phân Trang
- Trang chủ: 10 sách/trang
- Admin danh sách sách: 10 sách/trang
- Admin đơn hàng: 10 đơn/trang

### 📸 Upload Hình Ảnh
- Hỗ trợ: JPG, PNG, GIF, BMP
- Thư mục lưu: `Content/Images/`
- Tự động đặt tên: `filename_timestamp.ext`

### 📝 Trình Soạn Thảo TinyMCE
- Hỗ trợ định dạng văn bản: Bold, Italic, Underline
- Chèn link và ảnh
- Xem mã HTML

### 🔒 Quản Lý Phiên (Session)
- Timeout: 20 phút
- Lưu thông tin: UserID, FullName, Email, Role
- Tự động logout khi hết phiên

### 💳 Trạng Thái Đơn Hàng
- 0: Chờ Xác Nhận (Pending)
- 1: Đã Xác Nhận (Confirmed)
- 2: Đang Giao (Shipped)
- 3: Đã Giao (Delivered)
- 4: Đã Hủy (Cancelled)

## Khắc Phục Sự Cố

### Lỗi: "Database connection failed"
**Giải pháp:**
1. Kiểm tra SQL Server đang chạy
2. Kiểm tra connection string trong Web.config
3. Kiểm tra quyền truy cập database

### Lỗi: "Entity Framework not installed"
**Giải pháp:**
```powershell
Install-Package EntityFramework -Version 6.2.0
```

### Lỗi: "Folder Images not found"
**Giải pháp:**
1. Tạo folder `Content/Images`
2. Cho phép quyền ghi

### Lỗi: "TinyMCE not loading"
**Giải pháp:**
1. Kiểm tra kết nối internet (CDN)
2. Thêm defer trong tag script

## Cải Tiến Có Thể Thực Hiện

- [ ] Mã hóa mật khẩu (bcrypt/hash)
- [ ] Email verification
- [ ] Payment gateway (Stripe, PayPal)
- [ ] Forget password functionality
- [ ] User profile management
- [ ] Product reviews & ratings
- [ ] Search & filter advanced
- [ ] Multi-language support
- [ ] API endpoints (RESTful)
- [ ] Mobile responsive optimization
- [ ] Performance optimization
- [ ] Logging & error handling

## Tác Giả & Liên Hệ

**Dự án:** Hoàn thành bài tập Lập Trình Web (MVC5)
**Trường:** [Tên trường/Lớp học]
**Ngày tạo:** 2024

## Giấy Phép

Dự án này dành cho mục đích giáo dục. Vui lòng liên hệ tác giả để được phép sử dụng trong các dự án khác.

## Tài Liệu Tham Khảo

- [Microsoft ASP.NET MVC 5 Documentation](https://learn.microsoft.com/en-us/aspnet/mvc/overview/getting-started/introduction/index)
- [Entity Framework 6 Documentation](https://learn.microsoft.com/en-us/ef/ef6/)
- [Bootstrap 4 Documentation](https://getbootstrap.com/docs/4.5/)
- [TinyMCE 4 Documentation](https://www.tiny.cloud/develop/tinymce-4/)
- [jQuery Documentation](https://jquery.com/)

---

📘 **Xem tệp `HUONG_DAN_SU_DUNG.md` để biết hướng dẫn chi tiết!**

💡 **Hãy thử chạy ứng dụng và khám phá các tính năng!**
