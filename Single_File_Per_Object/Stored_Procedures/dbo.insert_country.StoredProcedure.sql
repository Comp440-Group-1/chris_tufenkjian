USE [s16guest63]
GO
/****** Object:  StoredProcedure [dbo].[insert_country]    Script Date: 5/5/2016 8:28:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_country]
	@country_name varchar(50)

AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @exists INT

	SET @exists = (SELECT COUNT(*) FROM Countries WHERE country_name = @country_name);

	IF @exists = 0
		BEGIN
				INSERT INTO Countries (country_name) 
				VALUES (@country_name)
		END
	ELSE
		PRINT 'Country already exists, no need for update.'
END
GO
