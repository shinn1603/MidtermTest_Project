-- Script tạo Database và bảng cho Đề 03 - MSSV: 24110343 - Nguyễn Phước Thọ
USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'MidtermDB_24110343')
BEGIN
    ALTER DATABASE MidtermDB_24110343 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE MidtermDB_24110343;
END
GO

CREATE DATABASE MidtermDB_24110343;
GO

USE MidtermDB_24110343;
GO

-- Bảng Category
CREATE TABLE Category (
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    Categoryname NVARCHAR(100),
    Categorycode NVARCHAR(100),
    Images NVARCHAR(500),
    Status BIT DEFAULT 1
);
GO

-- Bảng Users
CREATE TABLE Users (
    Username NVARCHAR(50) PRIMARY KEY,
    Password NVARCHAR(50) NOT NULL,
    Phone NVARCHAR(15),
    Fullname NVARCHAR(50),
    Email NVARCHAR(150),
    Admin BIT DEFAULT 0,
    Active BIT DEFAULT 1,
    Images NVARCHAR(500)
);
GO

-- Bảng Videos
CREATE TABLE Videos (
    VideoId NVARCHAR(50) PRIMARY KEY,
    Title NVARCHAR(200),
    Poster NVARCHAR(50),
    Views INT DEFAULT 0,
    Description NVARCHAR(500),
    Active BIT DEFAULT 1,
    CategoryId INT,
    VideoUrl NVARCHAR(255) NULL,
    CONSTRAINT FK_Videos_Category FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId) ON DELETE SET NULL
);
GO

-- Bảng Shares
CREATE TABLE Shares (
    ShareId INT IDENTITY(1,1) PRIMARY KEY,
    Emails NVARCHAR(50),
    SharedDate DATE,
    Username NVARCHAR(50),
    VideoId NVARCHAR(50),
    CONSTRAINT FK_Shares_Users FOREIGN KEY (Username) REFERENCES Users(Username) ON DELETE CASCADE,
    CONSTRAINT FK_Shares_Videos FOREIGN KEY (VideoId) REFERENCES Videos(VideoId) ON DELETE CASCADE
);
GO

-- Bảng Favorites
CREATE TABLE Favorites (
    FavoriteId INT IDENTITY(1,1) PRIMARY KEY,
    LikedDate DATE,
    VideoId NVARCHAR(50),
    Username NVARCHAR(50),
    CONSTRAINT FK_Favorites_Videos FOREIGN KEY (VideoId) REFERENCES Videos(VideoId) ON DELETE CASCADE,
    CONSTRAINT FK_Favorites_Users FOREIGN KEY (Username) REFERENCES Users(Username) ON DELETE CASCADE
);
GO

-- Chèn dữ liệu mẫu
-- 1. Category
INSERT INTO Category (Categoryname, Categorycode, Images, Status) VALUES
(N'Lập trình Java', N'JAVA', N'java.png', 1),
(N'Lập trình Web Servlet', N'WEB', N'web.png', 1),
(N'Cơ sở dữ liệu SQL', N'SQL', N'sql.png', 1);
GO

-- 2. Users (Admin và User thường)
INSERT INTO Users (Username, Password, Phone, Fullname, Email, Admin, Active, Images) VALUES
(N'admin', N'123', N'0912345678', N'Quản Trị Viên', N'admin@gmail.com', 1, 1, N'admin.png'),
(N'tho24110343', N'123', N'0987654321', N'Nguyễn Phước Thọ', N'tho24110343@gmail.com', 0, 1, N'user.png'),
(N'user01', N'123', N'0901234567', N'Trần Văn An', N'an@gmail.com', 0, 1, N'user.png');
GO

-- 3. Videos (Đủ số lượng để kiểm tra phân trang 6 video/trang ở Admin và 3 video/trang ở User)
INSERT INTO Videos (VideoId, Title, Poster, Views, Description, Active, CategoryId) VALUES
(N'VID01', N'Nhập môn Java Core cho người mới', N'poster1.jpg', 1520, N'Hướng dẫn cú pháp cơ bản và các thành phần cốt lõi của ngôn ngữ lập trình Java.', 1, 1),
(N'VID02', N'Lập trình hướng đối tượng OOP trong Java', N'poster2.jpg', 980, N'Chi tiết 4 tính chất OOP: Kế thừa, Đóng gói, Đa hình và Trừu tượng.', 1, 1),
(N'VID03', N'Java Collections Framework toàn tập', N'poster3.jpg', 670, N'Tìm hiểu List, Set, Map và cách sử dụng các cấu trúc dữ liệu hiệu quả.', 1, 1),
(N'VID04', N'Xử lý ngoại lệ Exception trong Java', N'poster4.jpg', 450, N'Các kỹ thuật try-catch-finally, throw, throws và custom exception.', 1, 1),
(N'VID05', N'Java Stream API & Lambda Expressions', N'poster5.jpg', 1200, N'Lập trình hàm trong Java hiện đại với Functional Interface và Streams.', 1, 1),
(N'VID06', N'Đa luồng Multithreading căn bản', N'poster6.jpg', 890, N'Tìm hiểu Thread, Runnable, Synchronization và Thread Pool.', 1, 1),
(N'VID07', N'Java I/O và File System', N'poster7.jpg', 320, N'Đọc ghi file nhị phân và text file trong Java NIO.', 1, 1),

(N'VID08', N'Xây dựng ứng dụng Web với Servlet & JSP', N'poster8.jpg', 2100, N'Kiến trúc MVC cơ bản sử dụng Jakarta Servlet và JSP.', 1, 2),
(N'VID09', N'Quản lý giao diện với SiteMesh Decorator', N'poster9.jpg', 1450, N'Tạo layout dùng chung cho Header, Footer và menu điều hướng.', 1, 2),
(N'VID10', N'Kết nối Cơ sở dữ liệu với JPA Hibernate', N'poster10.jpg', 3100, N'Thao tác CRUD dữ liệu thông qua EntityManager và JPQL.', 1, 2),
(N'VID11', N'Xác thực người dùng và Quản lý Session', N'poster11.jpg', 1800, N'Xây dựng cơ chế đăng nhập, phân quyền và xác thực mã OTP.', 1, 2),

(N'VID12', N'Thiết kế CSDL quan hệ chuẩn hóa 3NF', N'poster12.jpg', 1320, N'Quy tắc chuẩn hóa 1NF, 2NF, 3NF trong phân tích thiết kế CSDL.', 1, 3),
(N'VID13', N'Tối ưu hóa truy vấn SQL Server', N'poster13.jpg', 950, N'Kỹ thuật đánh chỉ mục Index và phân tích Execution Plan.', 1, 3),
(N'VID14', N'Store Procedure và Transaction trong T-SQL', N'poster14.jpg', 780, N'Viết thủ tục lưu trữ, hàm và xử lý giao dịch an toàn ACID.', 1, 3);
GO

-- 4. Favorites (Lượt Like mẫu)
INSERT INTO Favorites (LikedDate, VideoId, Username) VALUES
('2026-09-01', N'VID01', N'admin'),
('2026-09-02', N'VID01', N'tho24110343'),
('2026-09-03', N'VID01', N'user01'),
('2026-09-02', N'VID08', N'tho24110343'),
('2026-09-04', N'VID08', N'user01'),
('2026-09-05', N'VID10', N'tho24110343');
GO

-- 5. Shares (Lượt Share mẫu)
INSERT INTO Shares (Emails, SharedDate, Username, VideoId) VALUES
(N'banbe1@gmail.com', '2026-09-02', N'tho24110343', N'VID01'),
(N'banbe2@gmail.com', '2026-09-03', N'tho24110343', N'VID01'),
(N'dongnghiep@gmail.com', '2026-09-05', N'user01', N'VID08');
GO
