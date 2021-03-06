USE [s16guest63]
GO
/****** Object:  StoredProcedure [dbo].[insert_product_versions]    Script Date: 5/5/2016 8:28:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_product_versions]
	@product_commit_id int,
	@release_info varchar(50),
	@release_date date

AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @exists INT

	SET @exists = (SELECT COUNT(*) FROM Product_Commits WHERE @product_commit_id = @product_commit_id);

	IF @exists = 0
		BEGIN
				INSERT INTO Product_Versions (product_commit_id, release_info, release_date) 
				VALUES (@product_commit_id, @release_info, @release_date)
		END
	ELSE
		PRINT 'A version with this Commit already exists, no need for update.'
END
GO
