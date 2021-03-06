USE [s16guest63]
GO
/****** Object:  StoredProcedure [dbo].[insert_product_departments]    Script Date: 5/5/2016 8:28:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_product_departments]
	@department_name varchar(50)

AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @exists INT

	SET @exists = (SELECT COUNT(*) FROM Product_Departments WHERE department_name = @department_name);

	IF @exists = 0
		BEGIN
				INSERT INTO Product_Departments (department_name) 
				VALUES (@department_name)
		END
	ELSE
		PRINT 'Product Department Already exists, no need for update.'
END
GO
