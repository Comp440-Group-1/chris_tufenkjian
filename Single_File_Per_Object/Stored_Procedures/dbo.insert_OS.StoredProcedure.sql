USE [s16guest63]
GO
/****** Object:  StoredProcedure [dbo].[insert_OS]    Script Date: 5/5/2016 8:28:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_OS]
	@operating_system_id int,
	@operating_system varchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	IF(@operating_system = 'Windows' 
	   OR @operating_system = 'Linux' 
	   OR @operating_system = 'MAC')

		BEGIN
			IF(@operating_system = 'Windows')
				SET @operating_system_id = 1;

			IF(@operating_system = 'Linux')
				SET @operating_system_id = 2;

			IF(@operating_system = 'MAC')
				SET @operating_system_id = 3;

			INSERT INTO Operating_Systems VALUES(@operating_system_id, @operating_system)
		END
	ELSE 
		PRINT 'Incorrect O.S. INPUT'
END

GO
