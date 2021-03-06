USE [s16guest63]
GO
/****** Object:  StoredProcedure [dbo].[insert_cities]    Script Date: 5/5/2016 8:28:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_cities]
	@city_name varchar(50)

AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @exists INT

	SET @exists = (SELECT COUNT(*) FROM Cities WHERE city_name = @city_name);

	IF @exists = 0
		BEGIN
				INSERT INTO Cities (city_name) 
				VALUES (@city_name)
		END
	ELSE
		PRINT 'City already exists, no need for update.'
END
GO
