USE [s16guest63]
GO
/****** Object:  StoredProcedure [dbo].[insert_downloads]    Script Date: 5/5/2016 8:28:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_downloads]
	@product_version_id int,
	@user_id int,
	@download_date date

AS
BEGIN
	SET NOCOUNT ON;

				INSERT INTO Downloads (product_version_id, user_id, download_date) 
				VALUES (@product_version_id, @user_id, @download_date)
END
GO
