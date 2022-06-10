
CREATE DATABASE ME_MOVIE
GO
USE ME_MOVIE
-- I. Tạo bản User
-- Note: Admin (1 là Admin, 2 là User)
CREATE TABLE  [User](
	UserId VARCHAR(75) PRIMARY KEY NOT NULL,
	[Password] VARCHAR(55) NOT NULL,
	Fullname NVARCHAR(255),
	Email VARCHAR(255),
	[Admin] BIT DEFAULT 0 NOT NULL
)
-- II. Tạo bảng Movie
CREATE TABLE Movie(
	MovieId CHAR(5) PRIMARY KEY NOT NULL,
	CategoryId CHAR(5) NOT NULL,
	Title NVARCHAR(255) NOT NULL,
	Poster VARCHAR(255),
	[Description] NVARCHAR(MAX),
	LinkEmbed VARCHAR(MAX),
	DatePost DATE,
	Active BIT DEFAULT 1,
	[Views] INT
)
-- III. Tạo bảng Category (Danh mục)
CREATE TABLE Category(
	CategoryId CHAR(5) PRIMARY KEY NOT NULL,
	NameCategory NVARCHAR(255) NOT NULL
)
-- IV. Tạo bản Favorite
CREATE TABLE Favorite(
	FavId INT IDENTITY(1,1) PRIMARY KEY,
	MovieId CHAR(5) NOT NULL,
	UserID VARCHAR(75) NOT NULL,
	LikeDate DATE,
	UNIQUE(MovieId, UserID)
)
-- V. Tạo bảng Comments
CREATE TABLE Comment(
	CommentId INT IDENTITY(1,1) PRIMARY KEY,
	UserId VARCHAR(75) NOT NULL,
	MovieId CHAR(5) NOT NULL,
	Content NVARCHAR(MAX)
)
-- VI. Tạo bảng Visitor
CREATE TABLE Visitor(
	VisitId INT IDENTITY(1,1) PRIMARY KEY,
	UserId VARCHAR(75) NOT NULL,
	DateVisit DATE
)
-- ALTER TABLE dbo.Share ADD CONSTRAINT DF_DateShare DEFAULT GETDATE() FOR DateShare
-- VII. Tạo bảng Share
CREATE TABLE Share(
	ShareId INT IDENTITY(1,1) PRIMARY KEY,
	UserId VARCHAR(75) NOT NULL,
	MovieId CHAR(5) NOT NULL,
	Email VARCHAR(255),
	DateShare DATE 
)
-- Tạo Foreign Key
-- 1. Movie
ALTER TABLE dbo.Movie ADD CONSTRAINT FK_Movie_CategoryId FOREIGN KEY (CategoryId) REFERENCES dbo.Category(CategoryId)
-- 2. Favorite
ALTER TABLE dbo.Favorite ADD CONSTRAINT FK_Fav_VideoId FOREIGN KEY (MovieId) REFERENCES dbo.Movie(MovieId)
ALTER TABLE dbo.Favorite ADD CONSTRAINT FK_Fav_UserId FOREIGN KEY (UserID) REFERENCES dbo.[USER](UserID)
-- 3. Comment
ALTER TABLE dbo.Comment ADD CONSTRAINT FK_Cmt_UserId FOREIGN KEY (UserId) REFERENCES dbo.[USER](UserId)
ALTER TABLE dbo.Comment ADD CONSTRAINT FK_Cmt_MovieId FOREIGN KEY (MovieId) REFERENCES dbo.Movie(MovieId)
-- 4. Visitor
ALTER TABLE dbo.Visitor ADD CONSTRAINT FK_Visit_UserId FOREIGN KEY (UserId) REFERENCES dbo.[USER](UserId)
-- 5. Share
ALTER TABLE dbo.Share ADD CONSTRAINT FK_Share_UserId FOREIGN KEY (UserId) REFERENCES dbo.[USER](UserId)
ALTER TABLE dbo.Share ADD CONSTRAINT FK_Share_MovieId FOREIGN KEY (MovieId) REFERENCES dbo.Movie(MovieId)
INSERT INTO dbo.[User]
(
    UserId,
    Password,
    Fullname,
    Email,
    Admin
)
VALUES
(   'lcphan512@gmail.com',  -- UserId - varchar(75)
    '123456',  -- Password - varchar(55)
    N'Phan Tấn Lộc', -- Fullname - nvarchar(255)
    'lcphan512@gmail.com',  -- Email - varchar(255)
    1 -- Admin - bit
    )
	INSERT INTO dbo.Category
	(
	    CategoryId,
	    NameCategory
	)
	VALUES
	(   'CI001', -- CategoryId - char(5)
	    N'K-Dramas' -- NameCategory - nvarchar(255)
	    )
		INSERT INTO dbo.Movie
		(
		    MovieId,
		    CategoryId,
		    Title,
		    Poster,
		    Description,
		    LinkEmbed,
		    DatePost,
		    Active,
		    Views
		)
		VALUES
		(   'MI001',        -- MovieId - char(5)
		    'CI001',        -- CategoryId - char(5)
		    N'Twenty Five, Twenty One',       -- Title - nvarchar(255)
		    '',        -- Poster - varchar(255)
		    N'',       -- Description - nvarchar(max)
		    '',        -- LinkEmbed - varchar(max)
		    GETDATE(), -- DatePost - date
		    1,      -- Active - bit
		    22          -- Views - int
		    )
			SELECT * FROM dbo.[User]
			SELECT * FROM dbo.Category
			SELECT * FROM dbo.Movie
-- CREATE STORE PROCEDURE 
GO
CREATE PROC sp_InsertFav
@MovieId CHAR(5),
@UserId VARCHAR(75)
AS
BEGIN
	INSERT dbo.Favorite
	(
	    MovieId,
	    UserID,
	    LikeDate
	)
	VALUES
	(   @MovieId,       -- MovieId - char(5)
	    @UserId,       -- UserID - varchar(75)
	    GETDATE() -- LikeDate - date
	    )
END
SELECT F.MovieId, COUNT(F.MovieId) AS SLLike FROM dbo.Favorite AS F GROUP BY F.MovieId
INSERT INTO dbo.[User]
(
    UserId,
    Password,
    Fullname,
    Email,
    Admin
)
VALUES
(   'usertemp',  -- UserId - varchar(75)
    '123456',  -- Password - varchar(55)
    N'Nguyễn Temp', -- Fullname - nvarchar(255)
    'usertemp@gmail.com',  -- Email - varchar(255)
    0 -- Admin - bit
    )
	SELECT C.NameCategory, M.[Views], COUNT(F.IsLike) AS [LIKE] FROM dbo.Movie AS M INNER JOIN dbo.Category AS C
	ON C.CategoryId = M.CategoryId INNER JOIN dbo.Favorite AS F
	ON F.MovieId = M.MovieId
	WHERE M.MovieId = 'MI004' AND F.IsLike = 1
	GROUP BY C.NameCategory, M.[Views],F.IsLike
	SELECT * FROM dbo.Favorite
	SELECT DISTINCT C.* FROM dbo.Movie AS M INNER JOIN dbo.Category AS C
	ON C.CategoryId = M.CategoryId 
	WHERE Title LIKE '%a%'
	
	SELECT * FROM [User]
	INSERT INTO dbo.[User]
	(
	    UserId,
	    Password,
	    Fullname,
	    Email,
	    Admin
	)
	VALUES
	(   '',  -- UserId - varchar(75)
	    '',  -- Password - varchar(55)
	    '', -- Fullname - nvarchar(255)
	    '',  -- Email - varchar(255)
	    0 -- Admin - bit
	    )
		DELETE dbo.[User] WHERE UserId = ''