USE [s16guest63]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 5/5/2016 8:28:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Products](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[product_name] [varchar](50) NOT NULL,
	[product_info] [varchar](50) NOT NULL,
	[product_department_id] [int] NOT NULL,
	[product_operating_system_id] [int] NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Operating_Systems] FOREIGN KEY([product_operating_system_id])
REFERENCES [dbo].[Operating_Systems] ([operating_system_id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Operating_Systems]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Product_Departments] FOREIGN KEY([product_department_id])
REFERENCES [dbo].[Product_Departments] ([product_department_id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Product_Departments]
GO
