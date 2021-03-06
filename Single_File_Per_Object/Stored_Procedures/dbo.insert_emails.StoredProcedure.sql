USE [s16guest63]
GO
/****** Object:  StoredProcedure [dbo].[insert_emails]    Script Date: 5/5/2016 8:28:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_emails]
	@user_email varchar(50)

AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @exists INT

	SET @exists = (SELECT COUNT(*) FROM User_Emails WHERE user_email = @user_email);

	IF @exists = 0
		BEGIN
				INSERT INTO User_Emails (user_email) 
				VALUES (@user_email)
		END
	ELSE
		PRINT 'Email Already exists, no need for update.'
END
GO
