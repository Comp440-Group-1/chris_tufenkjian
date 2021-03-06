USE [s16guest63]
GO
/****** Object:  Table [dbo].[Product_Versions]    Script Date: 5/5/2016 8:28:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product_Versions](
	[product_version_id] [int] IDENTITY(1,1) NOT NULL,
	[product_commit_id] [int] NOT NULL,
	[release_info] [varchar](50) NULL,
	[release_date] [date] NULL,
 CONSTRAINT [PK_Product_Releases] PRIMARY KEY CLUSTERED 
(
	[product_version_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Product_Versions]  WITH CHECK ADD  CONSTRAINT [FK_Product_Releases_Product_Commits] FOREIGN KEY([product_commit_id])
REFERENCES [dbo].[Product_Commits] ([product_commit_id])
GO
ALTER TABLE [dbo].[Product_Versions] CHECK CONSTRAINT [FK_Product_Releases_Product_Commits]
GO
