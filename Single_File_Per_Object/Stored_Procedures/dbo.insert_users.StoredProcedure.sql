USE [s16guest63]
GO
/****** Object:  StoredProcedure [dbo].[insert_users]    Script Date: 5/5/2016 8:28:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_users]
	@user_name varchar(50),
	@user_email varchar(50),
	@user_password varchar(50),
	@user_phone_number int,
	@company_name varchar(50)

AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @exists INT

	SET @exists = (SELECT COUNT(*) FROM User_Emails WHERE user_email = @user_email);

	IF @exists = 0
		BEGIN
				EXEC insert_emails @user_email = @user_email
					DECLARE @email_id INT
					SET @email_id = (SELECT @email_id 
										FROM User_Emails 
										WHERE user_email = @user_email)

				EXEC insert_companies @company_name = @company_name
					DECLARE @company_id INT
					SET @company_id = (SELECT @company_id 
										FROM Companies 
										WHERE company_name = @company_name)

				INSERT INTO Users (user_name, email_id, user_password, user_phone_number, company_id) 
				VALUES (@user_name, @email_id, @user_password, @user_phone_number, @company_name)

		END
	ELSE
		PRINT 'User Already exists (duplicate email value), no need for update.'
END
GO
