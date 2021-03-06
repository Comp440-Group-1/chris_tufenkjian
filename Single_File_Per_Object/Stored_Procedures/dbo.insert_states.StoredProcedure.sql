USE [s16guest63]
GO
/****** Object:  StoredProcedure [dbo].[insert_states]    Script Date: 5/5/2016 8:28:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_states]
	@state_name varchar(50)

AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @exists INT

	SET @exists = (SELECT COUNT(*) FROM States WHERE state_name = @state_name);

	IF @exists = 0
		BEGIN
				INSERT INTO States (state_name) 
				VALUES (@state_name)
		END
	ELSE
		PRINT 'State Already exists, no need for update.'
END
GO
