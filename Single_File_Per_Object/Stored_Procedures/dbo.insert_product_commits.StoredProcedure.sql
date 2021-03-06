USE [s16guest63]
GO
/****** Object:  StoredProcedure [dbo].[insert_product_commits]    Script Date: 5/5/2016 8:28:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_product_commits]
	@commit_info varchar(50),
	@commit_date date,
	@product_name varchar(50),
	@branch_name varchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @exists INT

	SET @exists = (SELECT COUNT(*) FROM Product_Commits WHERE commit_info = @commit_info AND commit_date = @commit_date);

	IF @exists = 0
		BEGIN
				EXEC insert_products @product_name = @product_name
					DECLARE @product_id INT
					SET @product_id = (SELECT product_id 
										FROM Products 
										WHERE product_name = @product_name)

				EXEC insert_branch @branch_name = @branch_name
					DECLARE @branch_id INT
					SET @branch_id = (SELECT @branch_id
										FROM Product_Branches 
										WHERE branch_name = @branch_name)

				INSERT INTO Product_Commits (commit_info, commit_date, product_id, branch_id) 
				VALUES (@commit_info, @commit_date, @product_id, @branch_id)
		END
	ELSE
		PRINT 'Commit Date and Info matched, already exists, no need for update.'
END
GO
