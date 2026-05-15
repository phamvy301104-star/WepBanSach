-- ============================================================
-- QLBANSACH Database - Dữ liệu từ SQLQuery2.sql
-- Chạy script này để tạo lại toàn bộ database
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
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'QLBANSACH')
BEGIN
    ALTER DATABASE QLBANSACH SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE QLBANSACH;
END
GO

CREATE DATABASE QLBANSACH;
GO

USE QLBANSACH;
GO

-- ============================================================
-- BẢNG CHUDE
-- ============================================================
CREATE TABLE CHUDE (
    MaCD        INT IDENTITY(1,1),
    TenChuDe    NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_ChuDe PRIMARY KEY(MaCD)
);

INSERT INTO CHUDE(TenChuDe) VALUES
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
GO

-- ============================================================
-- BẢNG NHAXUATBAN
-- ============================================================
CREATE TABLE NHAXUATBAN (
    MaNXB       INT IDENTITY(1,1),
    TenNXB      NVARCHAR(50) NOT NULL,
    Diachi      NVARCHAR(200),
    DienThoai   VARCHAR(50),
    CONSTRAINT PK_NhaXuatBan PRIMARY KEY(MaNXB)
);

INSERT INTO NHAXUATBAN(TenNXB, Diachi, DienThoai) VALUES
(N'Nhà xuất bản Trẻ',           N'124 Nguyễn Văn Cừ Q1.Tp.HCM',            '19001560'),
(N'NXB Thống kê',               N'Đồng Nai',                                 '19001511'),
(N'Kim Đồng',                   N'Tp.HCM',                                   '19001570'),
(N'Đại học quốc gia',           N'Tp.HCM',                                   '0908419981'),
(N'Văn hóa nghệ thuật',         N'Đà Nẵng',                                  '0903118833'),
(N'Giáo dục',                   N'81 Trần Hưng Đạo, Hà Nội',                '02438220801'),
(N'Lao động',                   N'175 Giảng Võ, Đống Đa, Hà Nội',           '02438515380'),
(N'Chính trị Quốc gia Sự thật', N'24 Quang Trung, Hoàn Kiếm, Hà Nội',       '02438221581'),
(N'Phụ nữ Việt Nam',            N'39 Hàng Chuối, Hai Bà Trưng, Hà Nội',     '02439433236'),
(N'Thông tin và Truyền thông',  N'115 Trần Duy Hưng, Cầu Giấy, Hà Nội',    '02435563453');
GO

-- ============================================================
-- BẢNG KHACHHANG (dữ liệu đầy đủ từ SQLQuery2.sql)
-- ============================================================
CREATE TABLE KHACHHANG (
    MaKH        INT IDENTITY(1,1),
    HoTen       NVARCHAR(50) NOT NULL,
    Taikhoan    VARCHAR(50) UNIQUE,
    Matkhau     VARCHAR(50) NOT NULL,
    Email       VARCHAR(100) UNIQUE,
    DiachiKH    NVARCHAR(200),
    DienthoaiKH VARCHAR(50),
    Ngaysinh    DATETIME,
    CONSTRAINT PK_Khachhang PRIMARY KEY(MaKH)
);

INSERT INTO KHACHHANG (HoTen, DiachiKH, DienthoaiKH, Taikhoan, Matkhau, Ngaysinh, Email) VALUES
(N'Phạm Văn Khoa',   N'Trần Huy Liệu',              '0918062755', 'pvkhoa',       'khoa',    '1982-08-18', 'pvkhoa@hcmuns.edu.vn'),
(N'Nguyễn Văn An',   N'12 Lê Lợi, Quận 1',          '0901111222', 'vanan01',      'an123',   '1990-01-01', 'vanan@gmail.com'),
(N'Trần Thị Bình',   N'45 Nguyễn Huệ, Quận 1',      '0902222333', 'thibinh02',    'binh456', '1992-05-15', 'thibinh@gmail.com'),
(N'Lê Minh Cường',   N'78 Cách Mạng Tháng 8',        '0903333444', 'minhcuong03',  'cuong789','1985-10-20', 'cuongle@gmail.com'),
(N'Phạm Hồng Đào',   N'102 Võ Văn Tần, Quận 3',     '0904444555', 'hongdao04',    'dao102',  '1998-03-12', 'daopham@gmail.com'),
(N'Hoàng Gia Bảo',   N'234 Nam Kỳ Khởi Nghĩa',       '0905555666', 'giabao05',     'bao234',  '1993-07-25', 'baohong@gmail.com'),
(N'Vũ Kim Liên',     N'56 Lý Tự Trọng, Quận 1',     '0906666777', 'kimlien06',    'lien56',  '1988-12-30', 'lienvu@gmail.com'),
(N'Đỗ Minh Nhật',    N'89 Trần Hưng Đạo, Quận 5',   '0907777888', 'minhnhat07',   'nhat89',  '1995-04-18', 'nhatdo@gmail.com'),
(N'Bùi Tuyết Mai',   N'123 Hai Bà Trưng, Quận 3',   '0908888999', 'tuyetmai08',   'mai123',  '1991-09-05', 'maibui@gmail.com'),
(N'Ngô Quốc Khánh',  N'67 Phan Đăng Lưu, PN',        '0909999000', 'quockhanh09',  'khanh67', '1980-02-14', 'khanhngo@gmail.com'),
(N'Lê Thị Tuyết Hoa',N'Hậu Giang',                   '02333455',   'user24',       '123456',  '2005-07-24', 'Tuyethoa@gmail.com');
GO

-- ============================================================
-- BẢNG SACH (thêm IsActive cho MVC, Anhbia mở rộng)
-- ============================================================
CREATE TABLE SACH (
    Masach      INT IDENTITY(1,1),
    Tensach     NVARCHAR(100) NOT NULL,
    Giaban      DECIMAL(18,0) CHECK (Giaban >= 0),
    Mota        NVARCHAR(MAX),
    Anhbia      NVARCHAR(300),
    Ngaycapnhat DATETIME DEFAULT GETDATE(),
    Soluongton  INT DEFAULT 0,
    IsActive    BIT DEFAULT 1,
    MaCD        INT,
    MaNXB       INT,
    CONSTRAINT PK_Sach PRIMARY KEY(Masach),
    CONSTRAINT FK_Chude FOREIGN KEY(MaCD) REFERENCES CHUDE(MaCD),
    CONSTRAINT FK_NhaXB FOREIGN KEY(MaNXB) REFERENCES NHAXUATBAN(MaNXB)
);

INSERT INTO SACH (Tensach, Giaban, Mota, Anhbia, Ngaycapnhat, Soluongton, IsActive, MaCD, MaNXB) VALUES
(N'Lập trình SQL Server',       150000, N'Sách hướng dẫn SQL cơ bản',       'sql.jpg',    GETDATE(), 50,  1, 2, 4),
(N'Tiếng Anh cho người mới',    120000, N'Học giao tiếp cơ bản',             'english.jpg',GETDATE(), 30,  1, 1, 3),
(N'Kỹ năng sống hiện đại',       95000, N'Cải thiện tư duy',                 'kynang.jpg', GETDATE(), 100, 1, 4, 1),
(N'Lịch sử văn hóa Việt Nam',   210000, N'Tìm hiểu cội nguồn',              'lichsu.jpg', GETDATE(), 20,  1, 4, 5),
(N'Cơ sở dữ liệu nâng cao',     185000, N'Tối ưu hóa truy vấn',             'db.jpg',     GETDATE(), 15,  1, 2, 4),
(N'Luật dân sự 2024',           130000, N'Cập nhật thông tin luật mới',      'luat.jpg',   GETDATE(), 40,  1, 3, 2),
(N'Vật lý nguyên tử',           250000, N'Khoa học chuyên sâu',              'vatly.jpg',  GETDATE(), 10,  1, 5, 4),
(N'Giải thuật và dữ liệu',      170000, N'Cấu trúc dữ liệu cơ bản',         'algo.jpg',   GETDATE(), 60,  1, 2, 3),
(N'Tiếng Nhật N5',              145000, N'Sách học tiếng Nhật',              'japan.jpg',  GETDATE(), 25,  1, 1, 1),
(N'Thiết kế đồ họa cơ bản',     300000, N'Hướng dẫn sử dụng Tools',         'design.jpg', GETDATE(), 12,  1, 2, 5);
GO

-- ============================================================
-- BẢNG TACGIA
-- ============================================================
CREATE TABLE TACGIA (
    MaTG        INT IDENTITY(1,1),
    TenTG       NVARCHAR(50) NOT NULL,
    Diachi      NVARCHAR(100),
    Tieusu      NVARCHAR(MAX),
    Dienthoai   VARCHAR(50),
    CONSTRAINT PK_TacGia PRIMARY KEY(MaTG)
);

INSERT INTO TACGIA (TenTG, Diachi, Tieusu, Dienthoai) VALUES
(N'Nguyễn Nhật Ánh', N'TP. Hồ Chí Minh', N'Tác giả của nhiều tác phẩm văn học thiếu nhi nổi tiếng.', '0901234567'),
(N'Tô Hoài',         N'Hà Nội',           N'Tác giả tác phẩm Dế Mèn Phiêu Lưu Ký.',                   '0243888999'),
(N'Nam Cao',         N'Hà Nam',           N'Nhà văn hiện thực xuất sắc trước cách mạng.',               '0912333444'),
(N'Xuân Quỳnh',      N'Hà Đông',          N'Nữ sĩ nổi tiếng với những bài thơ tình.',                  '0988777666'),
(N'Nguyễn Du',       N'Hà Tĩnh',          N'Đại thi hào dân tộc, tác giả Truyện Kiều.',                '0355444333'),
(N'Bảo Ninh',        N'Hà Nội',           N'Tác giả cuốn tiểu thuyết Nỗi buồn chiến tranh.',           '0909111222'),
(N'Trần Đăng Khoa',  N'Hải Dương',        N'Thần đồng thơ văn Việt Nam.',                              '0977666555'),
(N'Nguyễn Ngọc Tư',  N'Cà Mau',           N'Nữ nhà văn của vùng đất Nam Bộ.',                          '0911222333'),
(N'Phan Khôi',       N'Quảng Nam',        N'Học giả, nhà báo, nhà thơ nổi tiếng.',                     '0235666777'),
(N'Huy Cận',         N'Hà Tĩnh',          N'Một trong những gương mặt tiêu biểu của Thơ mới.',         '0944555666');
GO

-- ============================================================
-- BẢNG DONDATHANG
-- ============================================================
CREATE TABLE DONDATHANG (
    MaDonHang           INT IDENTITY(1,1),
    Dathanhtoan         BIT DEFAULT 0,
    Tinhtranggiaohang   BIT DEFAULT 0,
    Ngaydat             DATETIME DEFAULT GETDATE(),
    Ngaygiao            DATETIME,
    MaKH                INT NOT NULL,
    CONSTRAINT PK_DonDatHang PRIMARY KEY(MaDonHang),
    CONSTRAINT FK_Khachhang FOREIGN KEY(MaKH) REFERENCES KHACHHANG(MaKH)
);

INSERT INTO DONDATHANG (Dathanhtoan, Tinhtranggiaohang, Ngaydat, Ngaygiao, MaKH) VALUES
(1, 1, '2026-04-20 08:30:00', '2026-04-22 10:00:00', 1),
(0, 0, '2026-04-21 09:15:00', NULL,                   2),
(1, 0, '2026-04-22 14:20:00', '2026-04-25 08:00:00', 3),
(0, 0, '2026-04-23 10:45:00', NULL,                   4),
(1, 1, '2026-04-24 16:30:00', '2026-04-26 14:00:00', 5),
(1, 1, '2026-04-25 07:00:00', '2026-04-26 09:00:00', 6),
(0, 0, '2026-04-26 11:00:00', NULL,                   7),
(1, 0, '2026-04-26 13:00:00', '2026-04-28 10:00:00', 8),
(0, 0, '2026-04-26 15:30:00', NULL,                   9),
(1, 1, '2026-04-26 17:00:00', '2026-04-27 08:00:00', 10);
GO

-- ============================================================
-- BẢNG CHITIETDONTHANG
-- ============================================================
CREATE TABLE CHITIETDONTHANG (
    MaDonHang   INT NOT NULL,
    Masach      INT NOT NULL,
    Soluong     INT NOT NULL DEFAULT 1,
    Dongia      DECIMAL(18,0) NOT NULL,
    CONSTRAINT PK_CTDatHang PRIMARY KEY(MaDonHang, Masach),
    CONSTRAINT FK_Donhang FOREIGN KEY(MaDonHang) REFERENCES DONDATHANG(MaDonHang),
    CONSTRAINT FK_Sach    FOREIGN KEY(Masach)    REFERENCES SACH(Masach)
);

INSERT INTO CHITIETDONTHANG (MaDonHang, Masach, Soluong, Dongia) VALUES
(2, 5, 1, 185000),
(3, 1, 3, 150000),
(4, 4, 1, 210000),
(5, 7, 2, 250000),
(6, 8, 1, 170000),
(7, 10,5, 300000),
(8, 6, 1, 130000),
(9, 9, 2, 145000);
GO

-- ============================================================
-- BẢNG VIETSACH
-- ============================================================
CREATE TABLE VIETSACH (
    MaSach  INT NOT NULL,
    MaTG    INT NOT NULL,
    Vaitro  NVARCHAR(50),
    Vitri   NVARCHAR(50),
    CONSTRAINT PK_VietSach       PRIMARY KEY(MaSach, MaTG),
    CONSTRAINT FK_VietSach_Sach  FOREIGN KEY(MaSach) REFERENCES SACH(Masach),
    CONSTRAINT FK_VietSach_TacGia FOREIGN KEY(MaTG)  REFERENCES TACGIA(MaTG)
);

INSERT INTO VIETSACH (MaSach, MaTG, Vaitro, Vitri) VALUES
(1, 1,  N'Tác giả chính',  N'Bìa 1'),
(1, 2,  N'Đồng tác giả',   N'Bìa 2'),
(2, 10, N'Dịch giả',        N'Trang phụ bìa'),
(3, 4,  N'Chủ biên',        N'Bìa 1'),
(4, 5,  N'Tác giả chính',  N'Bìa 1'),
(5, 1,  N'Tác giả chính',  N'Bìa 1'),
(6, 9,  N'Người hiệu đính', N'Trang cuối'),
(7, 7,  N'Tác giả chính',  N'Bìa 1'),
(8, 3,  N'Tác giả chính',  N'Bìa 1'),
(10,8,  N'Tác giả chính',  N'Bìa 1');
GO

-- ============================================================
-- BẢNG Users - cho hệ thống đăng nhập Admin MVC
-- ============================================================
CREATE TABLE Users (
    UserID      INT PRIMARY KEY IDENTITY(1,1),
    FullName    NVARCHAR(100) NOT NULL,
    Email       VARCHAR(100) UNIQUE NOT NULL,
    Password    VARCHAR(100) NOT NULL,
    Phone       VARCHAR(15),
    DateOfBirth DATETIME,
    Address     NVARCHAR(200),
    Role        INT DEFAULT 0,
    IsActive    BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE()
);

INSERT INTO Users (FullName, Email, Password, Phone, DateOfBirth, Address, Role, IsActive)
VALUES 
(N'Admin Manager', 'admin@bookstore.com', 'admin123', '0987654321', '1990-01-01', N'Hà Nội', 1, 1),
(N'Nguyễn Văn An', 'user@bookstore.com', '123456', '0901111222', '1990-01-01', N'TP.HCM', 0, 1);
GO

-- ============================================================
-- BẢNG Orders, OrderDetails, CartItems - cho chức năng giỏ hàng MVC
-- ============================================================
CREATE TABLE Orders (
    OrderID         INT PRIMARY KEY IDENTITY(1,1),
    UserID          INT NOT NULL,
    OrderDate       DATETIME DEFAULT GETDATE(),
    TotalAmount     DECIMAL(18,2) NOT NULL,
    Status          INT DEFAULT 0,
    ShippingAddress NVARCHAR(200),
    Note            NVARCHAR(MAX),
    UpdatedDate     DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

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

CREATE TABLE CartItems (
    CartItemID  INT PRIMARY KEY IDENTITY(1,1),
    UserID      INT NOT NULL,
    BookID      INT NOT NULL,
    Quantity    INT NOT NULL,
    AddedDate   DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (BookID) REFERENCES SACH(Masach)
);
GO

PRINT N'Database QLBANSACH đã được tạo thành công!';
PRINT N'Bảng chính: SACH, CHUDE, NHAXUATBAN';
PRINT N'Bảng SQLQuery2: TACGIA, VIETSACH, KHACHHANG, DONDATHANG, CHITIETDONTHANG';
PRINT N'Bảng MVC: Users, Orders, OrderDetails, CartItems';
PRINT N'Tài khoản admin: admin@bookstore.com / admin123';
GO
