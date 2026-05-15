-- ============================================================
-- WebBanSach Database - Schema tiếng Việt (SQLQuery2.sql)
-- Chạy script này để tạo lại toàn bộ database sạch
-- ============================================================
USE master;
GO

-- Xóa database cũ nếu tồn tại
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'WebBanSach')
BEGIN
    ALTER DATABASE WebBanSach SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE WebBanSach;
END
GO

CREATE DATABASE WebBanSach;
GO

USE WebBanSach;
GO

-- ============================================================
-- BẢNG CHUDE (thay cho Categories)
-- ============================================================
CREATE TABLE CHUDE (
    MaCD        INT PRIMARY KEY IDENTITY(1,1),
    TenChuDe    NVARCHAR(100) NOT NULL
);

-- ============================================================
-- BẢNG NHAXUATBAN (thay cho Publishers)
-- ============================================================
CREATE TABLE NHAXUATBAN (
    MaNXB       INT PRIMARY KEY IDENTITY(1,1),
    TenNXB      NVARCHAR(100) NOT NULL,
    Diachi      NVARCHAR(200),
    DienThoai   VARCHAR(20)
);

-- ============================================================
-- BẢNG SACH (thay cho Books) - có thêm cột IsActive để hỗ trợ MVC
-- ============================================================
CREATE TABLE SACH (
    Masach      INT PRIMARY KEY IDENTITY(1,1),
    Tensach     NVARCHAR(200) NOT NULL,
    Giaban      DECIMAL(18,2) NOT NULL DEFAULT 0,
    Mota        NVARCHAR(MAX),
    Anhbia      NVARCHAR(300),
    Ngaycapnhat DATETIME DEFAULT GETDATE(),
    Soluongton  INT DEFAULT 0,
    IsActive    BIT DEFAULT 1,
    MaCD        INT NOT NULL,
    MaNXB       INT NOT NULL,
    FOREIGN KEY (MaCD)  REFERENCES CHUDE(MaCD),
    FOREIGN KEY (MaNXB) REFERENCES NHAXUATBAN(MaNXB)
);

-- ============================================================
-- BẢNG TACGIA (tác giả - từ SQLQuery2.sql)
-- ============================================================
CREATE TABLE TACGIA (
    MaTG        INT PRIMARY KEY IDENTITY(1,1),
    TenTG       NVARCHAR(100) NOT NULL,
    Diachi      NVARCHAR(200),
    Tieusu      NVARCHAR(MAX),
    Dienthoai   VARCHAR(20)
);

-- ============================================================
-- BẢNG VIETSACH (quan hệ sách - tác giả)
-- ============================================================
CREATE TABLE VIETSACH (
    MaSach      INT NOT NULL,
    MaTG        INT NOT NULL,
    Vaitro      NVARCHAR(50),
    Vitri       INT,
    PRIMARY KEY (MaSach, MaTG),
    FOREIGN KEY (MaSach) REFERENCES SACH(Masach),
    FOREIGN KEY (MaTG)   REFERENCES TACGIA(MaTG)
);

-- ============================================================
-- BẢNG Users - giữ nguyên cho hệ thống đăng nhập admin
-- ============================================================
CREATE TABLE Users (
    UserID      INT PRIMARY KEY IDENTITY(1,1),
    FullName    NVARCHAR(100) NOT NULL,
    Email       VARCHAR(100) UNIQUE NOT NULL,
    Password    VARCHAR(100) NOT NULL,
    Phone       VARCHAR(15),
    DateOfBirth DATETIME,
    Address     NVARCHAR(200),
    Role        INT DEFAULT 0,       -- 0: Khách hàng, 1: Admin
    IsActive    BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE()
);

-- ============================================================
-- BẢNG KHACHHANG (từ SQLQuery2.sql)
-- ============================================================
CREATE TABLE KHACHHANG (
    MaKH        INT PRIMARY KEY IDENTITY(1,1),
    HoTen       NVARCHAR(100) NOT NULL,
    Taikhoan    VARCHAR(50),
    Matkhau     VARCHAR(100),
    Email       VARCHAR(100),
    DiachiKH    NVARCHAR(200),
    DienthoaiKH VARCHAR(20),
    Ngaysinh    DATETIME
);

-- ============================================================
-- BẢNG Orders (giỏ hàng / đơn hàng - liên kết Users và SACH)
-- ============================================================
CREATE TABLE Orders (
    OrderID         INT PRIMARY KEY IDENTITY(1,1),
    UserID          INT NOT NULL,
    OrderDate       DATETIME DEFAULT GETDATE(),
    TotalAmount     DECIMAL(18,2) NOT NULL,
    Status          INT DEFAULT 0,   -- 0: Chờ, 1: Xác nhận, 2: Giao, 3: Hoàn, 4: Hủy
    ShippingAddress NVARCHAR(200),
    Note            NVARCHAR(MAX),
    UpdatedDate     DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- ============================================================
-- BẢNG OrderDetails (chi tiết đơn hàng - liên kết Orders và SACH)
-- ============================================================
CREATE TABLE OrderDetails (
    OrderDetailID   INT PRIMARY KEY IDENTITY(1,1),
    OrderID         INT NOT NULL,
    BookID          INT NOT NULL,
    Quantity        INT NOT NULL,
    UnitPrice       DECIMAL(18,2) NOT NULL,
    TotalPrice      DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (BookID)  REFERENCES SACH(Masach)
);

-- ============================================================
-- BẢNG CartItems (giỏ hàng tạm - liên kết Users và SACH)
-- ============================================================
CREATE TABLE CartItems (
    CartItemID  INT PRIMARY KEY IDENTITY(1,1),
    UserID      INT NOT NULL,
    BookID      INT NOT NULL,
    Quantity    INT NOT NULL,
    AddedDate   DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (BookID) REFERENCES SACH(Masach)
);

-- ============================================================
-- BẢNG DONDATHANG (từ SQLQuery2.sql - liên kết KHACHHANG)
-- ============================================================
CREATE TABLE DONDATHANG (
    MaDonHang           INT PRIMARY KEY IDENTITY(1,1),
    Dathanhtoan         BIT DEFAULT 0,
    Tinhtranggiaohang   INT DEFAULT 0,
    Ngaydat             DATETIME DEFAULT GETDATE(),
    Ngaygiao            DATETIME,
    MaKH                INT NOT NULL,
    FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH)
);

-- ============================================================
-- BẢNG CHITIETDONTHANG (từ SQLQuery2.sql)
-- ============================================================
CREATE TABLE CHITIETDONTHANG (
    MaDonHang   INT NOT NULL,
    Masach      INT NOT NULL,
    Soluong     INT NOT NULL DEFAULT 1,
    Dongia      DECIMAL(18,2) NOT NULL,
    PRIMARY KEY (MaDonHang, Masach),
    FOREIGN KEY (MaDonHang) REFERENCES DONDATHANG(MaDonHang),
    FOREIGN KEY (Masach)    REFERENCES SACH(Masach)
);

GO

-- ============================================================
-- DỮ LIỆU MẪU
-- ============================================================

-- Chủ đề (10 chủ đề)
INSERT INTO CHUDE (TenChuDe) VALUES
(N'Ngoại ngữ'),
(N'Công nghệ thông tin'),
(N'Luật'),
(N'Văn học'),
(N'Khoa học kỹ thuật'),
(N'Công Nghệ ÔTÔ'),
(N'Truyền Thông Đa phương tiện'),
(N'Quản Trị Kinh Doanh'),
(N'Dược'),
(N'Quan Hệ Công Chúng');

-- Nhà xuất bản (10 NXB)
INSERT INTO NHAXUATBAN (TenNXB, Diachi, DienThoai) VALUES
(N'Nhà xuất bản Trẻ',               N'124 Nguyễn Văn Cừ Q1.Tp.HCM',            '19001560'),
(N'NXB Thống kê',                   N'Đồng Nai',                                 '19001511'),
(N'Kim Đồng',                       N'Tp.HCM',                                   '19001570'),
(N'Đại học quốc gia',               N'Tp.HCM',                                   '0908419981'),
(N'Văn hóa nghệ thuật',             N'Đà Nẵng',                                  '0903118833'),
(N'Giáo dục',                       N'81 Trần Hưng Đạo, Hà Nội',                '02438220801'),
(N'Lao động',                       N'175 Giảng Võ, Đống Đa, Hà Nội',           '02438515380'),
(N'Chính trị Quốc gia Sự thật',     N'24 Quang Trung, Hoàn Kiếm, Hà Nội',       '02438221581'),
(N'Phụ nữ Việt Nam',                N'39 Hàng Chuối, Hai Bà Trưng, Hà Nội',     '02439433236'),
(N'Thông tin và Truyền thông',      N'115 Trần Duy Hưng, Cầu Giấy, Hà Nội',    '02435563453');

-- Sách (10 cuốn)
INSERT INTO SACH (Tensach, Giaban, Mota, Anhbia, Soluongton, MaCD, MaNXB, IsActive) VALUES
(N'Lập trình SQL Server',       150000, N'Sách hướng dẫn SQL cơ bản và nâng cao',        NULL, 50,  2, 4, 1),
(N'Tiếng Anh cho người mới',    120000, N'Học giao tiếp tiếng Anh cơ bản',               NULL, 30,  1, 3, 1),
(N'Kỹ năng sống hiện đại',       95000, N'Cải thiện tư duy và kỹ năng sống',             NULL, 100, 4, 1, 1),
(N'Lịch sử văn hóa Việt Nam',   210000, N'Tìm hiểu lịch sử và cội nguồn văn hóa',       NULL, 20,  4, 5, 1),
(N'Cơ sở dữ liệu nâng cao',     185000, N'Tối ưu hóa truy vấn và thiết kế CSDL',        NULL, 15,  2, 4, 1),
(N'Luật dân sự 2024',           130000, N'Cập nhật thông tin các văn bản luật mới nhất', NULL, 40,  3, 2, 1),
(N'Vật lý nguyên tử',           250000, N'Khoa học chuyên sâu về vật lý nguyên tử',      NULL, 10,  5, 4, 1),
(N'Giải thuật và cấu trúc dữ liệu', 170000, N'Cấu trúc dữ liệu và thuật toán cơ bản',  NULL, 60,  2, 3, 1),
(N'Tiếng Nhật N5',              145000, N'Sách học tiếng Nhật trình độ N5 cho người mới',NULL, 25,  1, 1, 1),
(N'Thiết kế đồ họa cơ bản',     300000, N'Hướng dẫn sử dụng các công cụ thiết kế',      NULL, 12,  2, 5, 1);

-- Tác giả mẫu
INSERT INTO TACGIA (TenTG, Dienthoai) VALUES
(N'Nguyễn Nhật Ánh',    '0901234567'),
(N'Huy Cận',            '0907654321'),
(N'Xuân Quỳnh',         '0912345678'),
(N'Nam Cao',            '0934567890'),
(N'Nguyễn Du',          '0956789012');

-- Liên kết sách - tác giả
INSERT INTO VIETSACH (MaSach, MaTG, Vaitro, Vitri) VALUES
(1, 1, N'Tác giả chính', 1),
(2, 2, N'Tác giả chính', 1),
(3, 3, N'Tác giả chính', 1),
(4, 5, N'Tác giả chính', 1),
(5, 1, N'Tác giả chính', 1),
(8, 4, N'Tác giả chính', 1);

-- Tài khoản Admin
INSERT INTO Users (FullName, Email, Password, Phone, DateOfBirth, Address, Role, IsActive)
VALUES (N'Admin Manager', 'admin@bookstore.com', 'admin123', '0987654321', '1990-01-01', N'Hà Nội', 1, 1);

-- Khách hàng mẫu (trong bảng Users cho đăng nhập web)
INSERT INTO Users (FullName, Email, Password, Phone, DateOfBirth, Address, Role, IsActive)
VALUES (N'Nguyễn Văn A', 'user@example.com', 'user123', '0912345678', '1995-05-15', N'TP.HCM', 0, 1);

-- Khách hàng mẫu (trong bảng KHACHHANG của SQLQuery2.sql)
INSERT INTO KHACHHANG (HoTen, Taikhoan, Matkhau, Email, DiachiKH, DienthoaiKH, Ngaysinh) VALUES
(N'Nguyễn Thị Hoa',  'hoa123',   'pass123', 'hoa@email.com',  N'Hà Nội',  '0901111111', '1998-03-15'),
(N'Trần Văn Minh',   'minh456',  'pass456', 'minh@email.com', N'TP.HCM',  '0902222222', '1997-07-20'),
(N'Lê Thị Lan',      'lan789',   'pass789', 'lan@email.com',  N'Đà Nẵng', '0903333333', '1999-11-05');

PRINT N'Database WebBanSach đã được tạo thành công với schema tiếng Việt!';
PRINT N'Bảng chính: SACH, CHUDE, NHAXUATBAN';
PRINT N'Bảng phụ (SQLQuery2): TACGIA, VIETSACH, KHACHHANG, DONDATHANG, CHITIETDONTHANG';
PRINT N'Bảng hệ thống MVC: Users, Orders, OrderDetails, CartItems';
PRINT N'Tài khoản admin: admin@bookstore.com / admin123';
GO
