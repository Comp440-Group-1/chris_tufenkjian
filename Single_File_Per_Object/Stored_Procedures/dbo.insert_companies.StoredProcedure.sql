USE [s16guest63]
GO
/****** Object:  StoredProcedure [dbo].[insert_companies]    Script Date: 5/5/2016 8:28:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_companies]
	@company_name varchar(50),
	@street_name varchar(50),
	@city_name varchar(50),
	@state_name varchar(50),
	@zip_code int,
	@country_name varchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @exists INT

	SET @exists = (SELECT COUNT(*) FROM Companies WHERE Company_name = @Company_name);

	IF @exists = 0
		BEGIN
				EXEC insert_streets @street_name = @street_name
					DECLARE @street_id INT
					SET @street_id = (SELECT street_id 
										FROM Streets 
										WHERE street_name = @street_name)

				EXEC insert_country @country_name = @country_name
					DECLARE @country_id INT
					SET @country_id = (SELECT country_id
										FROM Countries 
										WHERE country_name = @country_name)

				EXEC insert_cities @city_name = @city_name
					DECLARE @city_id INT
					SET @city_id = (SELECT city_id 
										FROM Cities 
										WHERE city_name = @city_name)

				EXEC insert_states @state_name = @state_name
					DECLARE @state_id INT
					SET @state_id = (SELECT state_id 
										FROM States 
										WHERE state_name = @state_name)

				INSERT INTO Companies (company_name, street_id, city_id, state_id, zip_code, country_id) 
				VALUES (@company_name, @street_id, @city_id, @state_id, @zip_code, @country_id)

		END
	ELSE
		PRINT 'Company Already exists, no need for update.'
END
GO
