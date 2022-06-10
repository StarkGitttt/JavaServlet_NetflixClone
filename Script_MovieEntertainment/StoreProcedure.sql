-- STORE PROCEDU
-- 1. Change Pass
CREATE PROCEDURE sp_changePassword
@UserId VARCHAR(75),
@Password VARCHAR(55)
AS
BEGIN
	UPDATE dbo.[User] SET [Password] = @Password WHERE UserId = @UserId
END
SELECT * FROM dbo.[User]
UPDATE dbo.[User] SET Password = '123456' WHERE UserId = 'lcphan512@gmail.com'
GO
ALTER PROC sp_myFavMovie
@UserId VARCHAR(75),
@CategoryId CHAR(5)
AS
BEGIN
	SELECT M.* FROM [User] AS U INNER JOIN Favorite AS F
	ON U.UserId = F.UserId INNER JOIN dbo.Movie AS M
	ON M.MovieId = F.MovieId INNER JOIN dbo.Category AS C
	ON C.CategoryId = M.CategoryId
	WHERE U.UserId = @UserId AND C.CategoryId = @CategoryId
	AND F.IsLike = 1 AND M.Active = 'TRUE'
END
GO
ALTER PROC sp_setNotLike
@UserId VARCHAR(75),
@MovieId CHAR(5)
AS
BEGIN
	DECLARE @FavId INT, @IsExist VARCHAR(75)
	SELECT @IsExist = FavId FROM dbo.Favorite
	WHERE MovieId = @MovieId AND UserID = @UserId
	IF(@IsExist IS NULL)
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
		RETURN
	END
	SELECT @FavId = F.FavId FROM dbo.Favorite AS F
	WHERE F.UserID = @UserId AND F.MovieId = @MovieId AND F.IsLike = 1
	IF(@FavId IS NULL)
		BEGIN
			UPDATE dbo.Favorite SET IsLike = 1, LikeDate = GETDATE() WHERE UserID = @UserId AND MovieId = @MovieId
		END
	ELSE
		BEGIN
			UPDATE dbo.Favorite SET IsLike = 0, LikeDate = GETDATE() WHERE UserID = @UserId AND MovieId = @MovieId
		END
END
ALTER TABLE dbo.Comment ADD DateComment SMALLDATETIME
GO
-- SP Chèn comment
CREATE PROC sp_InsertComment
@UserId VARCHAR(75),
@MovieId VARCHAR(5),
@Content NVARCHAR(MAX)
AS
BEGIN
	INSERT dbo.Comment
	(
	    UserId,
	    MovieId,
	    Content,
		DateComment
	)
	VALUES
	(   @UserId, -- UserId - varchar(75)
	    @MovieId, -- MovieId - char(5)
	    @Content, -- Content - nvarchar(max)
	    CURRENT_TIMESTAMP )
END
GO
-- SP tăng lượt Like lên một
CREATE PROC sp_riseView
@MovieId CHAR(5)
AS
BEGIN
	DECLARE @Views INT
	SELECT @Views = [Views] FROM dbo.Movie WHERE MovieId = @MovieId
	SET @Views = @Views + 1
	UPDATE dbo.Movie SET [Views] = @Views WHERE MovieId = @MovieId
END
-- SP Thêm video
GO
CREATE PROC sp_addMovie
@CategoryId CHAR(5),
@Title NVARCHAR(255),
@CodeMovie VARCHAR(255),
@Description NVARCHAR(MAX)
AS
BEGIN
	-- Hàm tăng tự đông ID của phim
	DECLARE @ID VARCHAR(10)
	IF (SELECT COUNT(MovieId) FROM dbo.Movie) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MovieId, 3)) FROM dbo.Movie
		SELECT @ID = CASE 
			WHEN @ID >= 0 and @ID < 9 THEN 'MI00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 AND @ID < 99 THEN 'MI0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 99 THEN 'MI' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	DECLARE @Poster VARCHAR(255), @LinkEmbed VARCHAR(255)
	-- Xử lí nối chuỗi Poster
	SET @Poster = CONCAT('https://img.youtube.com/vi/',@CodeMovie,'/maxresdefault.jpg')
	-- Xử lí nối chuỗi Link phim
	SET @LinkEmbed = CONCAT('https://www.youtube.com/embed/',@CodeMovie)
	-- CHÈN PHIM
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
	(   TRIM(@ID),        -- MovieId - char(5)
	    @CategoryId,        -- CategoryId - char(5)
	    @Title,       -- Title - nvarchar(255)
	    @Poster,        -- Poster - varchar(255)
	    @Description,       -- Description - nvarchar(max)
	    @LinkEmbed,        -- LinkEmbed - varchar(max)
	    GETDATE(), -- DatePost - date
	    1,      -- Active - bit
	    0          -- Views - int
	    )
	
END
-- SP Xóa Movie
GO
CREATE PROC sp_setStatusMovie
@MovieId CHAR(5)
AS
BEGIN
	DECLARE @State CHAR(5)
	SELECT @State = MovieId FROM dbo.Movie WHERE MovieId = @MovieId AND Active = 'TRUE'
	-- Trường hợp trạng thái phim đang Acitive -> Chuyển sang in-active
	IF(@State IS NOT NULL)
	BEGIN
		UPDATE dbo.Movie SET Active = 'FALSE' WHERE MovieId = @MovieId
	END
	ELSE
		UPDATE dbo.Movie SET Active = 'TRUE' WHERE MovieId = @MovieId
END
-- SP Cập nhập Movie
GO
CREATE PROC sp_UpdateMovie
@MovieId CHAR(5),
@Title NVARCHAR(255),
@Poster VARCHAR(255),
@LinkEmbed VARCHAR(MAX),
@Description NVARCHAR(MAX),
@Views INT
AS
BEGIN
	UPDATE dbo.Movie SET Title = @Title, Poster = @Poster, 
						LinkEmbed = @LinkEmbed, [Description] = @Description,
						[Views] = @Views
					WHERE MovieId = @MovieId
END
SELECT COUNT(F.FavId) FROM dbo.Favorite  AS F INNER JOIN dbo.Movie AS M
ON M.MovieId = F.MovieId WHERE M.Active = 'TRUE' AND F.IsLike = 'TRUE'
SELECT COUNT(FavId) FROM dbo.Favorite
SELECT * FROM dbo.Favorite
SELECT * FROM dbo.Movie
EXEC dbo.sp_addMovie @CategoryId = 'CI002',  -- char(5)
                     @Title = N'US',      -- nvarchar(255)
                     @CodeMovie = 'hNCmb-4oXJA',   -- varchar(255)
                     @Description = N'' -- nvarchar(max)
					 SELECT * FROM dbo.Visitor
					 SELECT * FROM dbo.Favorite
					 UPDATE dbo.Movie SET Active = 'TRUE' WHERE MovieId = 'MI005' OR MovieId = 'MI044'
-- Store thống kế số lượt thích và ghé thăm của user
GO
CREATE PROC sp_StatisticsUsers
AS
BEGIN
	SELECT u.Fullname, u.[Email], TTotal.CountLike, TTotal.CountVisit FROM dbo.[User] AS U INNER JOIN 
	( SELECT V.UserId, COUNT(V.UserId) AS CountVisit, TLike.CountLike FROM dbo.Visitor AS V INNER JOIN 
	( SELECT F.UserID, COUNT(F.UserID) AS CountLike FROM dbo.[User] AS U INNER JOIN dbo.Favorite AS F
	ON F.UserID = U.UserId 
	GROUP BY F.UserID ) AS TLike
	ON TLike.UserID = V.UserId
	GROUP BY V.UserId, TLike.CountLike ) AS TTotal
	ON TTotal.UserId = U.UserId
END
UPDATE dbo.[User] SET Fullname =  N'Phan Tấn Lộc' WHERE UserId = 'lcphan512@gmail.com'

SELECT DISTINCT C_Main.* FROM dbo.Category AS C_Main INNER JOIN 
(SELECT TOP 10 C.CategoryId FROM dbo.Movie AS M INNER JOIN dbo.Category AS C
ON C.CategoryId = M.CategoryId 
ORDER BY M.DatePost DESC ) AS C_Temp
ON C_Temp.CategoryId = C_Main.CategoryId 
-- Store lấy phim mới nhất theo danh mục
GO
CREATE PROC sp_newMovie
@CategoryId CHAR(5)
AS
BEGIN
	SELECT M_Temp.* FROM dbo.Category AS C INNER JOIN
	(SELECT TOP 10 M.* FROM dbo.Movie AS M
	ORDER BY M.DatePost DESC) AS M_Temp
	ON M_Temp.CategoryId = C.CategoryId
	WHERE M_Temp.CategoryId = @CategoryId
END

EXEC dbo.sp_newMovie @CategoryId = 'CI001' -- char(5)
-- STORE LOGIN GOOGLE
SELECT * FROM dbo.[User]
GO
ALTER PROC sp_loginGoogle
@UserId VARCHAR(75),
@Fullname NVARCHAR(255),
@Email  VARCHAR(255)
AS
BEGIN
	INSERT INTO dbo.[User]
	(
	    UserId,
	    Password,
	    Fullname,
	    Email,
	    Admin
	)
	VALUES
	(   @UserId,  -- UserId - varchar(75)
	    'loginwithmail',  -- Password - varchar(55)
	    @Fullname, -- Fullname - nvarchar(255)
	    @Email,  -- Email - varchar(255)
		DEFAULT -- Admin - bit
	    )
END

SELECT * FROM dbo.[User]
SELECT * FROM dbo.Favorite
SELECT * FROM dbo.Movie WHERE Active = 'FALSE'
SELECT * FROM dbo.Category
SELECT * FROM dbo.Movie WHERE CategoryId = 'CI001'