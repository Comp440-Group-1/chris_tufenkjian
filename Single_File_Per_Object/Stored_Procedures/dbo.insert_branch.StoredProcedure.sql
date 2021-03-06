USE [s16guest63]
GO
/****** Object:  StoredProcedure [dbo].[insert_branch]    Script Date: 5/5/2016 8:28:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_branch]
	@branch_name varchar(50)

AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @exists INT

	SET @exists = (SELECT COUNT(*) FROM Product_Branches WHERE branch_name = @branch_name);

	IF @exists = 0
		BEGIN
				INSERT INTO Product_Branches (branch_name) 
				VALUES (@branch_name)
		END
	ELSE
		PRINT 'Branch already exists, no need for update.'
END
GO
