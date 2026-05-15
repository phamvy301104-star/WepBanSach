
-- Categories Table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    CreatedDate DATETIME DEFAULT GETDATE()
);

-- Publishers Table
CREATE TABLE Publishers (
    PublisherID INT PRIMARY KEY IDENTITY(1,1),
    PublisherName NVARCHAR(100) NOT NULL,
    Address NVARCHAR(200),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    CreatedDate DATETIME DEFAULT GETDATE()
);

-- Books Table
CREATE TABLE Books (
    BookID INT PRIMARY KEY IDENTITY(1,1),
    BookTitle NVARCHAR(200) NOT NULL,
    Author NVARCHAR(100),
    Description NVARCHAR(MAX),
    Price DECIMAL(10,2) NOT NULL,
    Quantity INT DEFAULT 0,
    ImagePath NVARCHAR(MAX),
    CategoryID INT NOT NULL,
    PublisherID INT NOT NULL,
    PublishedDate DATETIME,
    CreatedDate DATETIME DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID)
);

-- Users Table
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(100) NOT NULL,
    Phone VARCHAR(15),
    DateOfBirth DATETIME,
    Address NVARCHAR(200),
    Role INT DEFAULT 0, -- 0: User, 1: Admin
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE()
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(12,2) NOT NULL,
    Status INT DEFAULT 0, -- 0: Pending, 1: Confirmed, 2: Shipped, 3: Delivered, 4: Cancelled
    ShippingAddress NVARCHAR(200),
    Note NVARCHAR(MAX),
    UpdatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    BookID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    TotalPrice DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- CartItems Table
CREATE TABLE CartItems (
    CartItemID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    BookID INT NOT NULL,
    Quantity INT NOT NULL,
    AddedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- Insert Sample Data
-- Categories (10 chủ đề)
INSERT INTO Categories (CategoryName, Description) VALUES 
(N'Ngoại ngữ', N'Sách học ngoại ngữ, giao tiếp'),
(N'Công nghệ thông tin', N'Sách về lập trình, CNTT'),
(N'Luật', N'Sách pháp luật, văn bản pháp quy'),
(N'Văn học', N'Sách văn học, truyện ngắn, tiểu thuyết'),
(N'Khoa học kỹ thuật', N'Sách khoa học, kỹ thuật chuyên ngành'),
(N'Công Nghệ ÔTÔ', N'Sách kỹ thuật ô tô, cơ khí'),
(N'Truyền Thông Đa phương tiện', N'Sách truyền thông, báo chí, media'),
(N'Quản Trị Kinh Doanh', N'Sách kinh doanh, quản trị doanh nghiệp'),
(N'Dược', N'Sách y dược, dược liệu'),
(N'Quan Hệ Công Chúng', N'Sách PR, marketing, truyền thông');

-- Publishers (10 nhà xuất bản)
INSERT INTO Publishers (PublisherName, Address, Phone, Email) VALUES 
(N'Nhà xuất bản Trẻ', N'124 Nguyễn Văn Cừ Q1.Tp.HCM', '19001560', 'info@nxbtre.com.vn'),
(N'NXB Thống kê', N'Đồng Nai', '19001511', 'info@nxbthongke.vn'),
(N'Kim Đồng', N'Tp.HCM', '19001570', 'info@nxbkimdong.vn'),
(N'Đại học quốc gia', N'Tp.HCM', '0908419981', 'info@vnuhcm.edu.vn'),
(N'Văn hóa nghệ thuật', N'Đà Nẵng', '0903118833', 'info@vhnt.vn'),
(N'Giáo dục', N'81 Trần Hưng Đạo, Hà Nội', '02438220801', 'info@nxbgd.vn'),
(N'Lao động', N'175 Giảng Võ, Đống Đa, Hà Nội', '02438515380', 'info@nxbld.vn'),
(N'Chính trị Quốc gia Sự thật', N'24 Quang Trung, Hoàn Kiếm, Hà Nội', '02438221581', 'info@nxbctqg.vn'),
(N'Phụ nữ Việt Nam', N'39 Hàng Chuối, Hai Bà Trưng, Hà Nội', '02439433236', 'info@nxbpn.vn'),
(N'Thông tin và Truyền thông', N'115 Trần Duy Hưng, Cầu Giấy, Hà Nội', '02435563453', 'info@nxbtttt.vn');

-- Books (10 sách, CategoryID và PublisherID theo thứ tự INSERT trên)
INSERT INTO Books (BookTitle, Author, Description, Price, Quantity, CategoryID, PublisherID, PublishedDate, IsActive) VALUES 
(N'Lập trình SQL Server', N'Nguyễn Nhật Ánh, Tô Hoài', N'Sách hướng dẫn SQL cơ bản', 150000, 50, 2, 4, GETDATE(), 1),
(N'Tiếng Anh cho người mới', N'Huy Cận', N'Học giao tiếp cơ bản', 120000, 30, 1, 3, GETDATE(), 1),
(N'Kỹ năng sống hiện đại', N'Xuân Quỳnh', N'Cải thiện tư duy', 95000, 100, 4, 1, GETDATE(), 1),
(N'Lịch sử văn hóa Việt Nam', N'Nguyễn Du', N'Tìm hiểu cội nguồn', 210000, 20, 4, 5, GETDATE(), 1),
(N'Cơ sở dữ liệu nâng cao', N'Nguyễn Nhật Ánh', N'Tối ưu hóa truy vấn', 185000, 15, 2, 4, GETDATE(), 1),
(N'Luật dân sự 2024', N'Phan Khôi', N'Cập nhật thông tin luật mới', 130000, 40, 3, 2, GETDATE(), 1),
(N'Vật lý nguyên tử', N'Trần Đăng Khoa', N'Khoa học chuyên sâu', 250000, 10, 5, 4, GETDATE(), 1),
(N'Giải thuật và dữ liệu', N'Nam Cao', N'Cấu trúc dữ liệu cơ bản', 170000, 60, 2, 3, GETDATE(), 1),
(N'Tiếng Nhật N5', N'', N'Sách học tiếng Nhật', 145000, 25, 1, 1, GETDATE(), 1),
(N'Thiết kế đồ họa cơ bản', N'Nguyễn Ngọc Tư', N'Hướng dẫn sử dụng Tools', 300000, 12, 2, 5, GETDATE(), 1);

-- Admin User
INSERT INTO Users (FullName, Email, Password, Phone, DateOfBirth, Address, Role, IsActive) VALUES 
(N'Admin Manager', 'admin@bookstore.com', 'admin123', '0987654321', '1990-01-01', N'Hà Nội', 1, 1);

-- Sample Regular User
INSERT INTO Users (FullName, Email, Password, Phone, DateOfBirth, Address, Role, IsActive) VALUES 
(N'Nguyễn Văn A', 'user@example.com', 'user123', '0912345678', '1995-05-15', N'TP.HCM', 0, 1);
