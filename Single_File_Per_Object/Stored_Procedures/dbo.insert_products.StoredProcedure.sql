USE [s16guest63]
GO
/****** Object:  StoredProcedure [dbo].[insert_products]    Script Date: 5/5/2016 8:28:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_products]
	@product_name varchar(50),
	@product_info varchar(50),
	@department_name varchar(50),
	@operating_system varchar(50)
AS
BEGIN
	SET NOCOUNT ON;


	DECLARE @exists INT

	SET @exists = (SELECT COUNT(*) FROM Products WHERE product_name = @product_name);

	IF @exists = 0
		BEGIN
				EXEC insert_product_departments @product_department = @department_name
					DECLARE @product_department_id INT
					SET @product_department_id = (SELECT product_department_id 
													FROM Product_Departments 
													WHERE department_name = @department_name)

				EXEC insert_OS @operating_system = @operating_system
					DECLARE @operating_system_id INT
					SET @operating_system_id = (SELECT @operating_system_id
												FROM Operating_Systems 
												WHERE operating_system = @operating_system)

				INSERT INTO Products (product_name, product_info, product_department_id, product_operating_system_id) 
				VALUES (@product_name, @product_info, @product_department_id, @operating_system_id)

		END
	ELSE
		PRINT 'Product Already exists, no need for update.'
END
GO
