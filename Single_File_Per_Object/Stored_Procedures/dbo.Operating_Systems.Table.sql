USE [s16guest63]
GO
/****** Object:  Table [dbo].[Operating_Systems]    Script Date: 5/5/2016 8:28:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Operating_Systems](
	[operating_system_id] [int] IDENTITY(1,1) NOT NULL,
	[operating_system] [varchar](50) NULL,
 CONSTRAINT [PK_Operating_Systems] PRIMARY KEY CLUSTERED 
(
	[operating_system_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
