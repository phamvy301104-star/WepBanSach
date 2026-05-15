-- Create Database
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'WebBanSach')
BEGIN
    CREATE DATABASE WebBanSach;
END
USE WebBanSach;

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
-- Categories
INSERT INTO Categories (CategoryName, Description) VALUES 
(N'Sách Truyện', N'Các tác phẩm văn học, truyện ngắn'),
(N'Sách IT', N'Sách về công nghệ thông tin, lập trình'),
(N'Sách Văn Học', N'Sách văn học cổ điển, hiện đại'),
(N'Sách Phổ Thông', N'Sách giáo khoa, kiến thức phổ thông'),
(N'Truyện Anime', N'Sách truyện tranh anime, manga');

-- Publishers
INSERT INTO Publishers (PublisherName, Address, Phone, Email) VALUES 
(N'Nhà Xuất Bản Kim Đồng', N'Hà Nội', '0243933331', 'info@kimdonv.vn'),
(N'Nhà Xuất Bản Trẻ', N'TP.HCM', '0283898989', 'info@nxbtre.com.vn'),
(N'Nhà Xuất Bản Thế Giới', N'Hà Nội', '0243933333', 'info@thegioi.vn'),
(N'Nhà Xuất Bản Hội Nhà Văn', N'Hà Nội', '0243933334', 'info@hoinhavvan.vn'),
(N'Nhà Xuất Bản Phụ Nữ', N'Hà Nội', '0243933335', 'info@phunu.vn');

-- Books
INSERT INTO Books (BookTitle, Author, Description, Price, Quantity, CategoryID, PublisherID, PublishedDate, IsActive) VALUES 
(N'Những Đứa Trẻ Sáng Suốt', N'Nguyễn Nhật Ánh', N'Bộ truyện nổi tiếng về tuổi thơ', 85000, 50, 1, 1, '2015-01-01', 1),
(N'Hoàng Tử Bé', N'Antoine de Saint-Exupéry', N'Bộ tiểu thuyết kỳ ảo', 120000, 30, 3, 3, '2016-06-15', 1),
(N'Clean Code', N'Robert C. Martin', N'Hướng dẫn viết code sạch', 250000, 20, 2, 2, '2014-03-10', 1),
(N'Code Hoàn Hảo', N'Steve McConnell', N'Lập trình tuyệt vời', 280000, 15, 2, 2, '2015-08-20', 1),
(N'Tôi Thích Tiếng Anh', N'Võ Anh Tuấn', N'Hướng dẫn học tiếng Anh hiệu quả', 95000, 40, 4, 1, '2017-02-01', 1),
(N'Naruto Tập 1', N'Masashi Kishimoto', N'Manga nổi tiếng thế giới', 65000, 100, 5, 1, '2018-01-10', 1),
(N'One Piece Tập 1', N'Eiichiro Oda', N'Truyện tranh Manga kinh điển', 70000, 80, 5, 1, '2018-02-15', 1),
(N'Chiến Thắng Kỳ Vọng', N'Napoleon Hill', N'Sách phát triển bản thân', 150000, 25, 4, 3, '2016-09-01', 1),
(N'Lập Trình Python', N'Guido van Rossum', N'Hướng dẫn toàn diện Python', 320000, 10, 2, 2, '2017-05-10', 1),
(N'Tủ Sách Vàng', N'Tác giả ẩn danh', N'Bộ sưu tập truyện ngắn', 200000, 18, 1, 3, '2016-11-20', 1);

-- Admin User
INSERT INTO Users (FullName, Email, Password, Phone, DateOfBirth, Address, Role, IsActive) VALUES 
(N'Admin Manager', 'admin@bookstore.com', 'admin123', '0987654321', '1990-01-01', N'Hà Nội', 1, 1);

-- Sample Regular User
INSERT INTO Users (FullName, Email, Password, Phone, DateOfBirth, Address, Role, IsActive) VALUES 
(N'Nguyễn Văn A', 'user@example.com', 'user123', '0912345678', '1995-05-15', N'TP.HCM', 0, 1);
