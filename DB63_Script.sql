USE [s16guest63]
GO
/****** Object:  User [s16guest63]    Script Date: 5/5/2016 8:30:31 PM ******/
CREATE USER [s16guest63] FOR LOGIN [s16guest63] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [s16guest63]
GO
ALTER ROLE [db_datareader] ADD MEMBER [s16guest63]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [s16guest63]
GO
/****** Object:  StoredProcedure [dbo].[insert_branch]    Script Date: 5/5/2016 8:30:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_branch]
	@branch_name varchar(50)

AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @exists INT

	SET @exists = (SELECT COUNT(*) FROM Product_Branches WHERE branch_name = @branch_name);

	IF @exists = 0
		BEGIN
				INSERT INTO Product_Branches (branch_name) 
				VALUES (@branch_name)
		END
	ELSE
		PRINT 'Branch already exists, no need for update.'
END
GO
/****** Object:  StoredProcedure [dbo].[insert_cities]    Script Date: 5/5/2016 8:30:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_cities]
	@city_name varchar(50)

AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @exists INT

	SET @exists = (SELECT COUNT(*) FROM Cities WHERE city_name = @city_name);

	IF @exists = 0
		BEGIN
				INSERT INTO Cities (city_name) 
				VALUES (@city_name)
		END
	ELSE
		PRINT 'City already exists, no need for update.'
END
GO
/****** Object:  StoredProcedure [dbo].[insert_companies]    Script Date: 5/5/2016 8:30:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[insert_country]    Script Date: 5/5/2016 8:30:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_country]
	@country_name varchar(50)

AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @exists INT

	SET @exists = (SELECT COUNT(*) FROM Countries WHERE country_name = @country_name);

	IF @exists = 0
		BEGIN
				INSERT INTO Countries (country_name) 
				VALUES (@country_name)
		END
	ELSE
		PRINT 'Country already exists, no need for update.'
END
GO
/****** Object:  StoredProcedure [dbo].[insert_downloads]    Script Date: 5/5/2016 8:30:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[insert_emails]    Script Date: 5/5/2016 8:30:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[insert_OS]    Script Date: 5/5/2016 8:30:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[insert_product_commits]    Script Date: 5/5/2016 8:30:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_product_commits]
	@commit_info varchar(50),
	@commit_date date,
	@product_name varchar(50),
	@branch_name varchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @exists INT

	SET @exists = (SELECT COUNT(*) FROM Product_Commits WHERE commit_info = @commit_info AND commit_date = @commit_date);

	IF @exists = 0
		BEGIN
				EXEC insert_products @product_name = @product_name
					DECLARE @product_id INT
					SET @product_id = (SELECT product_id 
										FROM Products 
										WHERE product_name = @product_name)

				EXEC insert_branch @branch_name = @branch_name
					DECLARE @branch_id INT
					SET @branch_id = (SELECT @branch_id
										FROM Product_Branches 
										WHERE branch_name = @branch_name)

				INSERT INTO Product_Commits (commit_info, commit_date, product_id, branch_id) 
				VALUES (@commit_info, @commit_date, @product_id, @branch_id)
		END
	ELSE
		PRINT 'Commit Date and Info matched, already exists, no need for update.'
END
GO
/****** Object:  StoredProcedure [dbo].[insert_product_departments]    Script Date: 5/5/2016 8:30:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_product_departments]
	@department_name varchar(50)

AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @exists INT

	SET @exists = (SELECT COUNT(*) FROM Product_Departments WHERE department_name = @department_name);

	IF @exists = 0
		BEGIN
				INSERT INTO Product_Departments (department_name) 
				VALUES (@department_name)
		END
	ELSE
		PRINT 'Product Department Already exists, no need for update.'
END
GO
/****** Object:  StoredProcedure [dbo].[insert_product_versions]    Script Date: 5/5/2016 8:30:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_product_versions]
	@product_commit_id int,
	@release_info varchar(50),
	@release_date date

AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @exists INT

	SET @exists = (SELECT COUNT(*) FROM Product_Commits WHERE @product_commit_id = @product_commit_id);

	IF @exists = 0
		BEGIN
				INSERT INTO Product_Versions (product_commit_id, release_info, release_date) 
				VALUES (@product_commit_id, @release_info, @release_date)
		END
	ELSE
		PRINT 'A version with this Commit already exists, no need for update.'
END
GO
/****** Object:  StoredProcedure [dbo].[insert_products]    Script Date: 5/5/2016 8:30:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_products]
	@product_name varchar(50),
	@product_info varchar(50),
	@department_name varchar(50),
	@operating_system varchar(50)
AS
BEGIN
	SET NOCOUNT ON;


	DECLARE @exists INT

	SET @exists = (SELECT COUNT(*) FROM Products WHERE product_name = @product_name);

	IF @exists = 0
		BEGIN
				EXEC insert_product_departments @product_department = @department_name
					DECLARE @product_department_id INT
					SET @product_department_id = (SELECT product_department_id 
													FROM Product_Departments 
													WHERE department_name = @department_name)

				EXEC insert_OS @operating_system = @operating_system
					DECLARE @operating_system_id INT
					SET @operating_system_id = (SELECT @operating_system_id
												FROM Operating_Systems 
												WHERE operating_system = @operating_system)

				INSERT INTO Products (product_name, product_info, product_department_id, product_operating_system_id) 
				VALUES (@product_name, @product_info, @product_department_id, @operating_system_id)

		END
	ELSE
		PRINT 'Product Already exists, no need for update.'
END
GO
/****** Object:  StoredProcedure [dbo].[insert_states]    Script Date: 5/5/2016 8:30:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[insert_streets]    Script Date: 5/5/2016 8:30:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_streets]
	@street_name varchar(50)

AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @exists INT

	SET @exists = (SELECT COUNT(*) FROM Streets WHERE street_name = @street_name);

	IF @exists = 0
		BEGIN
				INSERT INTO Streets (street_name) 
				VALUES (@street_name)
		END
	ELSE
		PRINT 'Street Already exists, no need for update.'
END
GO
/****** Object:  StoredProcedure [dbo].[insert_users]    Script Date: 5/5/2016 8:30:31 PM ******/
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
/****** Object:  Table [dbo].[Cities]    Script Date: 5/5/2016 8:30:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cities](
	[city_id] [int] IDENTITY(1,1) NOT NULL,
	[city_name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Cities] PRIMARY KEY CLUSTERED 
(
	[city_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Companies]    Script Date: 5/5/2016 8:30:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Companies](
	[company_id] [int] IDENTITY(1,1) NOT NULL,
	[company_name] [varchar](50) NOT NULL,
	[street_id] [int] NULL,
	[city_id] [int] NULL,
	[state_id] [int] NULL,
	[zip_code] [int] NULL,
	[country_id] [int] NULL,
 CONSTRAINT [PK_Companies] PRIMARY KEY CLUSTERED 
(
	[company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 5/5/2016 8:30:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Countries](
	[country_id] [int] IDENTITY(1,1) NOT NULL,
	[country_name] [varchar](50) NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Downloads]    Script Date: 5/5/2016 8:30:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Downloads](
	[download_id] [int] IDENTITY(1,1) NOT NULL,
	[product_version_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[download_date] [date] NOT NULL,
 CONSTRAINT [PK_Downloads] PRIMARY KEY CLUSTERED 
(
	[download_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Operating_Systems]    Script Date: 5/5/2016 8:30:31 PM ******/
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
/****** Object:  Table [dbo].[Product_Branches]    Script Date: 5/5/2016 8:30:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product_Branches](
	[branch_id] [int] IDENTITY(1,1) NOT NULL,
	[branch_name] [varchar](50) NULL,
 CONSTRAINT [PK_Product_Branches] PRIMARY KEY CLUSTERED 
(
	[branch_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product_Commits]    Script Date: 5/5/2016 8:30:31 PM ******/
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
/****** Object:  Table [dbo].[Product_Departments]    Script Date: 5/5/2016 8:30:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product_Departments](
	[product_department_id] [int] IDENTITY(1,1) NOT NULL,
	[department_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Product_Departments] PRIMARY KEY CLUSTERED 
(
	[product_department_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product_Versions]    Script Date: 5/5/2016 8:30:31 PM ******/
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
/****** Object:  Table [dbo].[Products]    Script Date: 5/5/2016 8:30:31 PM ******/
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
/****** Object:  Table [dbo].[States]    Script Date: 5/5/2016 8:30:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[States](
	[state_id] [int] IDENTITY(1,1) NOT NULL,
	[state_name] [varchar](50) NULL,
 CONSTRAINT [PK_States] PRIMARY KEY CLUSTERED 
(
	[state_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Streets]    Script Date: 5/5/2016 8:30:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Streets](
	[street_id] [int] IDENTITY(1,1) NOT NULL,
	[street_name] [varchar](50) NULL,
 CONSTRAINT [PK_Streets] PRIMARY KEY CLUSTERED 
(
	[street_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User_Emails]    Script Date: 5/5/2016 8:30:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User_Emails](
	[email_id] [int] IDENTITY(1,1) NOT NULL,
	[user_email] [varchar](50) NOT NULL,
 CONSTRAINT [PK_User_Emails] PRIMARY KEY CLUSTERED 
(
	[email_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 5/5/2016 8:30:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[user_name] [varchar](50) NOT NULL,
	[email_id] [int] NOT NULL,
	[user_password] [varchar](50) NOT NULL,
	[user_phone_number] [int] NOT NULL,
	[company_id] [int] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Companies]  WITH CHECK ADD  CONSTRAINT [FK_Companies_Cities1] FOREIGN KEY([city_id])
REFERENCES [dbo].[Cities] ([city_id])
GO
ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [FK_Companies_Cities1]
GO
ALTER TABLE [dbo].[Companies]  WITH CHECK ADD  CONSTRAINT [FK_Companies_Countries] FOREIGN KEY([country_id])
REFERENCES [dbo].[Countries] ([country_id])
GO
ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [FK_Companies_Countries]
GO
ALTER TABLE [dbo].[Companies]  WITH CHECK ADD  CONSTRAINT [FK_Companies_States] FOREIGN KEY([state_id])
REFERENCES [dbo].[States] ([state_id])
GO
ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [FK_Companies_States]
GO
ALTER TABLE [dbo].[Companies]  WITH CHECK ADD  CONSTRAINT [FK_Companies_Streets] FOREIGN KEY([street_id])
REFERENCES [dbo].[Streets] ([street_id])
GO
ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [FK_Companies_Streets]
GO
ALTER TABLE [dbo].[Downloads]  WITH CHECK ADD  CONSTRAINT [FK_Downloads_Product_Releases1] FOREIGN KEY([product_version_id])
REFERENCES [dbo].[Product_Versions] ([product_version_id])
GO
ALTER TABLE [dbo].[Downloads] CHECK CONSTRAINT [FK_Downloads_Product_Releases1]
GO
ALTER TABLE [dbo].[Downloads]  WITH CHECK ADD  CONSTRAINT [FK_Downloads_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Downloads] CHECK CONSTRAINT [FK_Downloads_Users]
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
ALTER TABLE [dbo].[Product_Versions]  WITH CHECK ADD  CONSTRAINT [FK_Product_Releases_Product_Commits] FOREIGN KEY([product_commit_id])
REFERENCES [dbo].[Product_Commits] ([product_commit_id])
GO
ALTER TABLE [dbo].[Product_Versions] CHECK CONSTRAINT [FK_Product_Releases_Product_Commits]
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
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Companies] FOREIGN KEY([company_id])
REFERENCES [dbo].[Companies] ([company_id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Companies]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_User_Emails] FOREIGN KEY([email_id])
REFERENCES [dbo].[User_Emails] ([email_id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_User_Emails]
GO
