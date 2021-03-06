USE [s16guest63]
GO
/****** Object:  Table [dbo].[Product_Commits]    Script Date: 5/5/2016 8:28:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product_Commits](
	[product_commit_id] [int] IDENTITY(1,1) NOT NULL,
	[commit_info] [varchar](50) NULL,
	[commit_date] [date] NULL,
	[product_id] [int] NOT NULL,
	[branch_id] [int] NOT NULL,
 CONSTRAINT [PK_Product_Commits] PRIMARY KEY CLUSTERED 
(
	[product_commit_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Product_Commits]  WITH CHECK ADD  CONSTRAINT [FK_Product_Commits_Product_Branches] FOREIGN KEY([branch_id])
REFERENCES [dbo].[Product_Branches] ([branch_id])
GO
ALTER TABLE [dbo].[Product_Commits] CHECK CONSTRAINT [FK_Product_Commits_Product_Branches]
GO
ALTER TABLE [dbo].[Product_Commits]  WITH CHECK ADD  CONSTRAINT [FK_Product_Commits_Products] FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
GO
ALTER TABLE [dbo].[Product_Commits] CHECK CONSTRAINT [FK_Product_Commits_Products]
GO
