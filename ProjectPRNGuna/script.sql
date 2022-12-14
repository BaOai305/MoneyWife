USE [master]
GO
/****** Object:  Database [MoneyWife]    Script Date: 11/11/2022 3:14:57 PM ******/
CREATE DATABASE [MoneyWife]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MoneyWife', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\MoneyWife.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MoneyWife_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\MoneyWife_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [MoneyWife] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MoneyWife].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MoneyWife] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MoneyWife] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MoneyWife] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MoneyWife] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MoneyWife] SET ARITHABORT OFF 
GO
ALTER DATABASE [MoneyWife] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MoneyWife] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MoneyWife] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MoneyWife] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MoneyWife] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MoneyWife] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MoneyWife] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MoneyWife] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MoneyWife] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MoneyWife] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MoneyWife] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MoneyWife] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MoneyWife] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MoneyWife] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MoneyWife] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MoneyWife] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MoneyWife] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MoneyWife] SET RECOVERY FULL 
GO
ALTER DATABASE [MoneyWife] SET  MULTI_USER 
GO
ALTER DATABASE [MoneyWife] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MoneyWife] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MoneyWife] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MoneyWife] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MoneyWife] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MoneyWife] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'MoneyWife', N'ON'
GO
ALTER DATABASE [MoneyWife] SET QUERY_STORE = OFF
GO
USE [MoneyWife]
GO
/****** Object:  Table [dbo].[Money]    Script Date: 11/11/2022 3:14:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Money](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[cash] [decimal](18, 0) NULL,
	[bank] [decimal](18, 0) NULL,
 CONSTRAINT [PK_Money] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Plan]    Script Date: 11/11/2022 3:14:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Plan](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[title] [nvarchar](250) NOT NULL,
	[target] [decimal](18, 0) NOT NULL,
	[pfrom] [datetime] NOT NULL,
	[pto] [datetime] NOT NULL,
	[progress] [float] NOT NULL,
 CONSTRAINT [PK_Plan] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Saving]    Script Date: 11/11/2022 3:14:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Saving](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[title] [nvarchar](250) NOT NULL,
	[tienVao] [decimal](18, 0) NOT NULL,
	[ngayDaoHan] [int] NOT NULL,
	[interest_rate] [float] NOT NULL,
	[tienRa] [decimal](18, 0) NULL,
	[status] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Saving] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SavingMoney]    Script Date: 11/11/2022 3:14:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SavingMoney](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[saving_id] [int] NOT NULL,
	[deposits] [decimal](18, 0) NOT NULL,
	[dep_day] [datetime] NOT NULL,
	[interest] [decimal](18, 0) NOT NULL,
	[int_day] [datetime] NOT NULL,
 CONSTRAINT [PK_SavingMoney] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[user_id] ASC,
	[saving_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 11/11/2022 3:14:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[moneyNum] [decimal](18, 0) NOT NULL,
	[cashOrBank] [varchar](50) NOT NULL,
	[moneyContent] [nvarchar](max) NULL,
	[moneyType] [int] NULL,
	[dateUse] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Type]    Script Date: 11/11/2022 3:14:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Type](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](250) NULL,
	[category] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Type] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TypeOfUsers]    Script Date: 11/11/2022 3:14:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypeOfUsers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](250) NULL,
	[category] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TypeOfUsers] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 11/11/2022 3:14:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[fullname] [nvarchar](100) NOT NULL,
	[phone] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[gender] [varchar](100) NULL,
	[location] [varchar](50) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Money] ON 

INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (1, 11, CAST(57954000 AS Decimal(18, 0)), CAST(6007913 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (2, 16, CAST(394421553 AS Decimal(18, 0)), CAST(927026153 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (3, 18, CAST(832416722 AS Decimal(18, 0)), CAST(242420510 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (4, 15, CAST(135848203 AS Decimal(18, 0)), CAST(434957642 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (5, 10, CAST(583095252 AS Decimal(18, 0)), CAST(227875880 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (6, 4, CAST(688485317 AS Decimal(18, 0)), CAST(196962423 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (7, 12, CAST(801953623 AS Decimal(18, 0)), CAST(43204726 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (8, 20, CAST(269471404 AS Decimal(18, 0)), CAST(319564015 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (9, 7, CAST(263222636 AS Decimal(18, 0)), CAST(350143909 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (10, 21, CAST(967390772 AS Decimal(18, 0)), CAST(598601553 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (11, 5, CAST(242574817 AS Decimal(18, 0)), CAST(5602656 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (12, 2, CAST(1000000 AS Decimal(18, 0)), CAST(25000000 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (13, 22, CAST(34000 AS Decimal(18, 0)), CAST(5400000 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (14, 23, CAST(23000 AS Decimal(18, 0)), CAST(340000 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (15, 24, CAST(23000 AS Decimal(18, 0)), CAST(43000 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (16, 25, CAST(23000 AS Decimal(18, 0)), CAST(43000 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (17, 26, CAST(23000 AS Decimal(18, 0)), CAST(43000 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (18, 27, CAST(23000 AS Decimal(18, 0)), CAST(4300000 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (19, 28, CAST(23000 AS Decimal(18, 0)), CAST(3200000 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (20, 29, CAST(23000 AS Decimal(18, 0)), CAST(4300000 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (21, 30, CAST(23000 AS Decimal(18, 0)), CAST(45000 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (22, 31, CAST(23000 AS Decimal(18, 0)), CAST(54000 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (23, 32, CAST(23000 AS Decimal(18, 0)), CAST(4300000 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (24, 33, CAST(23000 AS Decimal(18, 0)), CAST(4500000 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (25, 34, CAST(23000 AS Decimal(18, 0)), CAST(5400000 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (26, 35, CAST(2000000 AS Decimal(18, 0)), CAST(4500000 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (27, 36, CAST(23000 AS Decimal(18, 0)), CAST(3400000 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (28, 37, CAST(2300000 AS Decimal(18, 0)), CAST(5400000 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (29, 38, CAST(2300000 AS Decimal(18, 0)), CAST(4500000 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (30, 39, CAST(33400000 AS Decimal(18, 0)), CAST(45600000 AS Decimal(18, 0)))
INSERT [dbo].[Money] ([id], [user_id], [cash], [bank]) VALUES (31, 40, CAST(4003000 AS Decimal(18, 0)), CAST(4000000 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[Money] OFF
GO
SET IDENTITY_INSERT [dbo].[Saving] ON 

INSERT [dbo].[Saving] ([id], [user_id], [title], [tienVao], [ngayDaoHan], [interest_rate], [tienRa], [status]) VALUES (1, 11, N'Tiết kiệm', CAST(5000000 AS Decimal(18, 0)), 1, 0.8, CAST(0 AS Decimal(18, 0)), N'done')
INSERT [dbo].[Saving] ([id], [user_id], [title], [tienVao], [ngayDaoHan], [interest_rate], [tienRa], [status]) VALUES (2, 11, N'mua iphone', CAST(6000000 AS Decimal(18, 0)), 2, 0.9, CAST(0 AS Decimal(18, 0)), N'done')
INSERT [dbo].[Saving] ([id], [user_id], [title], [tienVao], [ngayDaoHan], [interest_rate], [tienRa], [status]) VALUES (3, 11, N'Tích lũy', CAST(30000000 AS Decimal(18, 0)), 3, 10, CAST(0 AS Decimal(18, 0)), N'interesting')
INSERT [dbo].[Saving] ([id], [user_id], [title], [tienVao], [ngayDaoHan], [interest_rate], [tienRa], [status]) VALUES (4, 11, N'tientro', CAST(1500000 AS Decimal(18, 0)), 5, 0.2, CAST(0 AS Decimal(18, 0)), N'done')
INSERT [dbo].[Saving] ([id], [user_id], [title], [tienVao], [ngayDaoHan], [interest_rate], [tienRa], [status]) VALUES (10, 11, N'tien hoc', CAST(40411325 AS Decimal(18, 0)), 8, 0.5, CAST(0 AS Decimal(18, 0)), N'done')
INSERT [dbo].[Saving] ([id], [user_id], [title], [tienVao], [ngayDaoHan], [interest_rate], [tienRa], [status]) VALUES (11, 11, N'tienny', CAST(8000000 AS Decimal(18, 0)), 1, 0.8, CAST(8391762 AS Decimal(18, 0)), N'interesting')
SET IDENTITY_INSERT [dbo].[Saving] OFF
GO
SET IDENTITY_INSERT [dbo].[SavingMoney] ON 

INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (1, 11, 1, CAST(5000000 AS Decimal(18, 0)), CAST(N'2022-05-01T00:00:00.000' AS DateTime), CAST(5040000 AS Decimal(18, 0)), CAST(N'2022-06-01T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (2, 11, 1, CAST(5040000 AS Decimal(18, 0)), CAST(N'2022-06-01T00:00:00.000' AS DateTime), CAST(5080320 AS Decimal(18, 0)), CAST(N'2022-07-01T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (3, 11, 1, CAST(5080320 AS Decimal(18, 0)), CAST(N'2022-07-01T00:00:00.000' AS DateTime), CAST(5120963 AS Decimal(18, 0)), CAST(N'2022-08-01T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (4, 11, 1, CAST(5120963 AS Decimal(18, 0)), CAST(N'2022-08-01T00:00:00.000' AS DateTime), CAST(5161930 AS Decimal(18, 0)), CAST(N'2022-09-01T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (5, 11, 1, CAST(5161930 AS Decimal(18, 0)), CAST(N'2022-09-01T00:00:00.000' AS DateTime), CAST(5203226 AS Decimal(18, 0)), CAST(N'2022-10-01T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (6, 11, 1, CAST(5203226 AS Decimal(18, 0)), CAST(N'2022-10-01T00:00:00.000' AS DateTime), CAST(5244852 AS Decimal(18, 0)), CAST(N'2022-11-01T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (7, 11, 2, CAST(6000000 AS Decimal(18, 0)), CAST(N'2022-02-02T00:00:00.000' AS DateTime), CAST(6054000 AS Decimal(18, 0)), CAST(N'2022-03-02T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (8, 11, 2, CAST(6054000 AS Decimal(18, 0)), CAST(N'2022-03-02T00:00:00.000' AS DateTime), CAST(6108486 AS Decimal(18, 0)), CAST(N'2022-04-02T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (9, 11, 2, CAST(6108486 AS Decimal(18, 0)), CAST(N'2022-04-02T00:00:00.000' AS DateTime), CAST(6163462 AS Decimal(18, 0)), CAST(N'2022-05-02T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (10, 11, 2, CAST(6163462 AS Decimal(18, 0)), CAST(N'2022-05-02T00:00:00.000' AS DateTime), CAST(6218934 AS Decimal(18, 0)), CAST(N'2022-06-02T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (11, 11, 2, CAST(6218934 AS Decimal(18, 0)), CAST(N'2022-06-02T00:00:00.000' AS DateTime), CAST(6274904 AS Decimal(18, 0)), CAST(N'2022-07-02T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (12, 11, 2, CAST(6274904 AS Decimal(18, 0)), CAST(N'2022-07-02T00:00:00.000' AS DateTime), CAST(6331378 AS Decimal(18, 0)), CAST(N'2022-08-02T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (13, 11, 2, CAST(6331378 AS Decimal(18, 0)), CAST(N'2022-08-02T00:00:00.000' AS DateTime), CAST(6388360 AS Decimal(18, 0)), CAST(N'2022-09-02T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (14, 11, 2, CAST(6388360 AS Decimal(18, 0)), CAST(N'2022-09-02T00:00:00.000' AS DateTime), CAST(6445856 AS Decimal(18, 0)), CAST(N'2022-10-02T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (15, 11, 2, CAST(6445856 AS Decimal(18, 0)), CAST(N'2022-10-02T00:00:00.000' AS DateTime), CAST(6503868 AS Decimal(18, 0)), CAST(N'2022-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (16, 11, 3, CAST(30000000 AS Decimal(18, 0)), CAST(N'2022-05-03T00:00:00.000' AS DateTime), CAST(33000000 AS Decimal(18, 0)), CAST(N'2022-06-03T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (17, 11, 3, CAST(33000000 AS Decimal(18, 0)), CAST(N'2022-06-03T00:00:00.000' AS DateTime), CAST(36300000 AS Decimal(18, 0)), CAST(N'2022-07-03T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (18, 11, 3, CAST(36300000 AS Decimal(18, 0)), CAST(N'2022-07-03T00:00:00.000' AS DateTime), CAST(39930000 AS Decimal(18, 0)), CAST(N'2022-08-03T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (19, 11, 3, CAST(39930000 AS Decimal(18, 0)), CAST(N'2022-08-03T00:00:00.000' AS DateTime), CAST(43923000 AS Decimal(18, 0)), CAST(N'2022-09-03T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (20, 11, 3, CAST(43923000 AS Decimal(18, 0)), CAST(N'2022-09-03T00:00:00.000' AS DateTime), CAST(48315300 AS Decimal(18, 0)), CAST(N'2022-10-03T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (21, 11, 3, CAST(48315300 AS Decimal(18, 0)), CAST(N'2022-10-03T00:00:00.000' AS DateTime), CAST(53146830 AS Decimal(18, 0)), CAST(N'2022-11-03T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (22, 11, 3, CAST(53146830 AS Decimal(18, 0)), CAST(N'2022-11-03T00:00:00.000' AS DateTime), CAST(58461513 AS Decimal(18, 0)), CAST(N'2022-12-03T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (23, 11, 3, CAST(58461513 AS Decimal(18, 0)), CAST(N'2022-12-03T00:00:00.000' AS DateTime), CAST(64307664 AS Decimal(18, 0)), CAST(N'2023-01-03T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (24, 11, 3, CAST(64307664 AS Decimal(18, 0)), CAST(N'2023-01-03T00:00:00.000' AS DateTime), CAST(70738431 AS Decimal(18, 0)), CAST(N'2023-02-03T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (25, 11, 3, CAST(70738431 AS Decimal(18, 0)), CAST(N'2023-02-03T00:00:00.000' AS DateTime), CAST(77812274 AS Decimal(18, 0)), CAST(N'2023-03-03T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (26, 11, 3, CAST(77812274 AS Decimal(18, 0)), CAST(N'2023-03-03T00:00:00.000' AS DateTime), CAST(85593501 AS Decimal(18, 0)), CAST(N'2023-04-03T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (27, 11, 3, CAST(85593501 AS Decimal(18, 0)), CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(94152851 AS Decimal(18, 0)), CAST(N'2023-05-03T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (28, 11, 3, CAST(94152851 AS Decimal(18, 0)), CAST(N'2023-05-03T00:00:00.000' AS DateTime), CAST(103568136 AS Decimal(18, 0)), CAST(N'2023-06-03T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (29, 11, 3, CAST(103568136 AS Decimal(18, 0)), CAST(N'2023-06-03T00:00:00.000' AS DateTime), CAST(113924950 AS Decimal(18, 0)), CAST(N'2023-07-03T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (30, 11, 3, CAST(113924950 AS Decimal(18, 0)), CAST(N'2023-07-03T00:00:00.000' AS DateTime), CAST(125317445 AS Decimal(18, 0)), CAST(N'2023-08-03T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (31, 11, 3, CAST(125317445 AS Decimal(18, 0)), CAST(N'2023-08-03T00:00:00.000' AS DateTime), CAST(137849190 AS Decimal(18, 0)), CAST(N'2023-09-03T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (32, 11, 3, CAST(137849190 AS Decimal(18, 0)), CAST(N'2023-09-03T00:00:00.000' AS DateTime), CAST(151634109 AS Decimal(18, 0)), CAST(N'2023-10-03T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (33, 11, 3, CAST(151634109 AS Decimal(18, 0)), CAST(N'2023-10-03T00:00:00.000' AS DateTime), CAST(166797519 AS Decimal(18, 0)), CAST(N'2023-11-03T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (34, 11, 4, CAST(1500000 AS Decimal(18, 0)), CAST(N'2022-05-05T00:00:00.000' AS DateTime), CAST(1503000 AS Decimal(18, 0)), CAST(N'2022-06-05T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (35, 11, 4, CAST(1503000 AS Decimal(18, 0)), CAST(N'2022-06-05T00:00:00.000' AS DateTime), CAST(1506006 AS Decimal(18, 0)), CAST(N'2022-07-05T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (36, 11, 4, CAST(1506006 AS Decimal(18, 0)), CAST(N'2022-07-05T00:00:00.000' AS DateTime), CAST(1509018 AS Decimal(18, 0)), CAST(N'2022-08-05T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (37, 11, 4, CAST(1509018 AS Decimal(18, 0)), CAST(N'2022-08-05T00:00:00.000' AS DateTime), CAST(1512036 AS Decimal(18, 0)), CAST(N'2022-09-05T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (38, 11, 4, CAST(1512036 AS Decimal(18, 0)), CAST(N'2022-09-05T00:00:00.000' AS DateTime), CAST(1515060 AS Decimal(18, 0)), CAST(N'2022-10-05T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (39, 11, 4, CAST(1515060 AS Decimal(18, 0)), CAST(N'2022-10-05T00:00:00.000' AS DateTime), CAST(1518090 AS Decimal(18, 0)), CAST(N'2022-11-05T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (40, 11, 4, CAST(1518090 AS Decimal(18, 0)), CAST(N'2022-11-05T00:00:00.000' AS DateTime), CAST(1521126 AS Decimal(18, 0)), CAST(N'2022-12-05T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (41, 11, 4, CAST(1521126 AS Decimal(18, 0)), CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(1524169 AS Decimal(18, 0)), CAST(N'2023-01-05T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (42, 11, 4, CAST(1524169 AS Decimal(18, 0)), CAST(N'2023-01-05T00:00:00.000' AS DateTime), CAST(1527217 AS Decimal(18, 0)), CAST(N'2023-02-05T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (43, 11, 4, CAST(1527217 AS Decimal(18, 0)), CAST(N'2023-02-05T00:00:00.000' AS DateTime), CAST(1530271 AS Decimal(18, 0)), CAST(N'2023-03-05T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (44, 11, 4, CAST(1530271 AS Decimal(18, 0)), CAST(N'2023-03-05T00:00:00.000' AS DateTime), CAST(1533332 AS Decimal(18, 0)), CAST(N'2023-04-05T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (45, 11, 4, CAST(1533332 AS Decimal(18, 0)), CAST(N'2023-04-05T00:00:00.000' AS DateTime), CAST(1536399 AS Decimal(18, 0)), CAST(N'2023-05-05T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (46, 11, 4, CAST(1536399 AS Decimal(18, 0)), CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(1539471 AS Decimal(18, 0)), CAST(N'2023-06-05T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (47, 11, 4, CAST(1539471 AS Decimal(18, 0)), CAST(N'2023-06-05T00:00:00.000' AS DateTime), CAST(1542550 AS Decimal(18, 0)), CAST(N'2023-07-05T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (48, 11, 4, CAST(1542550 AS Decimal(18, 0)), CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(1545635 AS Decimal(18, 0)), CAST(N'2023-08-05T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (49, 11, 4, CAST(1545635 AS Decimal(18, 0)), CAST(N'2023-08-05T00:00:00.000' AS DateTime), CAST(1548727 AS Decimal(18, 0)), CAST(N'2023-09-05T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (50, 11, 4, CAST(1548727 AS Decimal(18, 0)), CAST(N'2023-09-05T00:00:00.000' AS DateTime), CAST(1551824 AS Decimal(18, 0)), CAST(N'2023-10-05T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (51, 11, 4, CAST(1551824 AS Decimal(18, 0)), CAST(N'2023-10-05T00:00:00.000' AS DateTime), CAST(1554928 AS Decimal(18, 0)), CAST(N'2023-11-05T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (52, 11, 10, CAST(6000000 AS Decimal(18, 0)), CAST(N'2022-05-08T00:00:00.000' AS DateTime), CAST(6030000 AS Decimal(18, 0)), CAST(N'2022-06-08T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (53, 11, 10, CAST(6030000 AS Decimal(18, 0)), CAST(N'2022-06-08T00:00:00.000' AS DateTime), CAST(6060150 AS Decimal(18, 0)), CAST(N'2022-07-08T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (54, 11, 10, CAST(6060150 AS Decimal(18, 0)), CAST(N'2022-07-08T00:00:00.000' AS DateTime), CAST(6090451 AS Decimal(18, 0)), CAST(N'2022-08-08T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (55, 11, 10, CAST(6090451 AS Decimal(18, 0)), CAST(N'2022-08-08T00:00:00.000' AS DateTime), CAST(6120903 AS Decimal(18, 0)), CAST(N'2022-09-08T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (56, 11, 10, CAST(6120903 AS Decimal(18, 0)), CAST(N'2022-09-08T00:00:00.000' AS DateTime), CAST(6151508 AS Decimal(18, 0)), CAST(N'2022-10-08T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (57, 11, 10, CAST(6151508 AS Decimal(18, 0)), CAST(N'2022-10-08T00:00:00.000' AS DateTime), CAST(6182265 AS Decimal(18, 0)), CAST(N'2022-11-08T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (58, 11, 11, CAST(8000000 AS Decimal(18, 0)), CAST(N'2022-05-01T00:00:00.000' AS DateTime), CAST(8064000 AS Decimal(18, 0)), CAST(N'2022-06-01T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (59, 11, 11, CAST(8064000 AS Decimal(18, 0)), CAST(N'2022-06-01T00:00:00.000' AS DateTime), CAST(8128512 AS Decimal(18, 0)), CAST(N'2022-07-01T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (60, 11, 11, CAST(8128512 AS Decimal(18, 0)), CAST(N'2022-07-01T00:00:00.000' AS DateTime), CAST(8193540 AS Decimal(18, 0)), CAST(N'2022-08-01T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (61, 11, 11, CAST(8193540 AS Decimal(18, 0)), CAST(N'2022-08-01T00:00:00.000' AS DateTime), CAST(8259088 AS Decimal(18, 0)), CAST(N'2022-09-01T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (62, 11, 11, CAST(8259088 AS Decimal(18, 0)), CAST(N'2022-09-01T00:00:00.000' AS DateTime), CAST(8325161 AS Decimal(18, 0)), CAST(N'2022-10-01T00:00:00.000' AS DateTime))
INSERT [dbo].[SavingMoney] ([id], [user_id], [saving_id], [deposits], [dep_day], [interest], [int_day]) VALUES (63, 11, 11, CAST(8325161 AS Decimal(18, 0)), CAST(N'2022-10-01T00:00:00.000' AS DateTime), CAST(8391762 AS Decimal(18, 0)), CAST(N'2022-11-01T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[SavingMoney] OFF
GO
SET IDENTITY_INSERT [dbo].[Transaction] ON 

INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (19, 1, CAST(3678386 AS Decimal(18, 0)), N'cash', N'Multum bono eggredior. eggredior. Quad', 128, CAST(N'2022-08-26T18:45:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (20, 1, CAST(4326839 AS Decimal(18, 0)), N'cash', N'quad e in linguens eggredior.', 128, CAST(N'2021-10-21T04:04:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (21, 1, CAST(4649911 AS Decimal(18, 0)), N'bank', N'quoque linguens transit.', 128, CAST(N'2022-07-18T21:47:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (22, 1, CAST(2762028 AS Decimal(18, 0)), N'bank', N'funem. e venit. imaginator quad', 128, CAST(N'2022-03-14T07:49:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (23, 1, CAST(2163403 AS Decimal(18, 0)), N'bank', N'sed Multum esset e transit. quad estum. novum trepicandor', 128, CAST(N'2022-01-07T02:52:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (24, 1, CAST(906611 AS Decimal(18, 0)), N'cash', N'in travissimantor novum', 128, CAST(N'2022-06-28T09:48:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (25, 1, CAST(3068750 AS Decimal(18, 0)), N'cash', N'gravis essit. Et Et plorum Et linguens Pro', 128, CAST(N'2022-03-14T08:15:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (26, 1, CAST(868468 AS Decimal(18, 0)), N'bank', N'quartu sed quad rarendum si cognitio,', 128, CAST(N'2021-12-14T18:46:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (27, 1, CAST(4556205 AS Decimal(18, 0)), N'cash', N'esset Tam e fecundio, quad', 128, CAST(N'2022-03-14T20:47:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (28, 1, CAST(3069407 AS Decimal(18, 0)), N'bank', N'quo si non dolorum Et vobis', 128, CAST(N'2021-11-09T09:50:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (29, 1, CAST(903591 AS Decimal(18, 0)), N'bank', N'e Versus vantis. pars', 128, CAST(N'2021-11-23T23:51:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (30, 1, CAST(2412071 AS Decimal(18, 0)), N'cash', N'si dolorum Quad estum. plorum venit.', 128, CAST(N'2022-05-31T15:48:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (31, 1, CAST(4788079 AS Decimal(18, 0)), N'bank', N'Multum funem. brevens, estis e Quad eggredior. plurissimum', 128, CAST(N'2022-07-11T15:45:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (32, 1, CAST(1272062 AS Decimal(18, 0)), N'bank', N'in novum non trepicandor essit.', 128, CAST(N'2022-02-13T23:33:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (33, 1, CAST(783361 AS Decimal(18, 0)), N'bank', N'nomen non gravum regit,', 128, CAST(N'2022-10-16T13:13:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (34, 1, CAST(3948257 AS Decimal(18, 0)), N'cash', N'nomen essit. quis brevens, esset', 128, CAST(N'2022-01-27T00:50:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (35, 1, CAST(770865 AS Decimal(18, 0)), N'bank', N'quis non Longam, brevens,', 128, CAST(N'2022-08-29T21:24:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (36, 1, CAST(590990 AS Decimal(18, 0)), N'bank', N'esset quad estum. delerium.', 128, CAST(N'2022-05-28T07:03:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (37, 1, CAST(2267960 AS Decimal(18, 0)), N'cash', N'Longam, quartu Multum', 128, CAST(N'2022-05-14T12:20:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (38, 1, CAST(2942270 AS Decimal(18, 0)), N'bank', N'et Versus Quad gravum transit.', 128, CAST(N'2021-11-28T10:25:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (39, 12, CAST(727559 AS Decimal(18, 0)), N'cash', N'novum gravum plorum linguens', 25, CAST(N'2022-06-28T09:12:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (40, 12, CAST(2826247 AS Decimal(18, 0)), N'bank', N'quad si et vobis dolorum', 25, CAST(N'2022-05-08T16:06:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (41, 12, CAST(1967393 AS Decimal(18, 0)), N'bank', N'travissimantor fecundio,', 25, CAST(N'2021-11-01T10:08:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (42, 12, CAST(2318257 AS Decimal(18, 0)), N'bank', N'in habitatio quo, e nomen', 25, CAST(N'2022-09-09T09:35:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (43, 12, CAST(1283944 AS Decimal(18, 0)), N'cash', N'si quoque quo quis pars cognitio,', 25, CAST(N'2022-06-17T10:56:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (44, 12, CAST(2171623 AS Decimal(18, 0)), N'cash', N'regit, Et imaginator in eggredior.', 25, CAST(N'2021-10-07T21:14:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (45, 12, CAST(283300 AS Decimal(18, 0)), N'bank', N'Multum gravum Et quoque', 25, CAST(N'2022-04-17T19:42:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (46, 12, CAST(2038827 AS Decimal(18, 0)), N'cash', N'fecit, funem. bono et', 25, CAST(N'2022-09-19T05:24:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (47, 12, CAST(4707920 AS Decimal(18, 0)), N'cash', N'vantis. estis quantare', 25, CAST(N'2021-10-24T04:52:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (48, 12, CAST(1912649 AS Decimal(18, 0)), N'cash', N'fecit. et gravis plorum', 25, CAST(N'2022-05-30T23:41:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (49, 12, CAST(4818168 AS Decimal(18, 0)), N'cash', N'sed linguens trepicandor quo', 25, CAST(N'2022-03-28T10:31:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (50, 12, CAST(3549459 AS Decimal(18, 0)), N'bank', N'fecundio, nomen linguens homo,', 25, CAST(N'2022-08-02T08:49:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (51, 12, CAST(4384280 AS Decimal(18, 0)), N'cash', N'Id in e estum. Versus', 25, CAST(N'2022-04-15T00:49:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (52, 12, CAST(3560798 AS Decimal(18, 0)), N'bank', N'egreddior ut si imaginator', 25, CAST(N'2022-08-21T15:32:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (53, 12, CAST(4501827 AS Decimal(18, 0)), N'cash', N'nomen eudis et plorum non', 25, CAST(N'2022-01-30T21:24:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (54, 12, CAST(1154288 AS Decimal(18, 0)), N'cash', N'egreddior et quad Sed quorum parte', 25, CAST(N'2022-03-13T01:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (55, 12, CAST(4585577 AS Decimal(18, 0)), N'bank', N'homo, delerium. plorum', 25, CAST(N'2022-01-04T16:34:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (56, 12, CAST(3001983 AS Decimal(18, 0)), N'cash', N'parte si Id apparens', 25, CAST(N'2022-02-10T23:11:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (57, 12, CAST(257050 AS Decimal(18, 0)), N'cash', N'vantis. eggredior. bono non', 25, CAST(N'2022-07-21T15:33:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (58, 12, CAST(2626601 AS Decimal(18, 0)), N'cash', N'et dolorum rarendum in plorum in', 25, CAST(N'2022-08-15T01:59:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (59, 12, CAST(822623 AS Decimal(18, 0)), N'bank', N'quo quo non linguens vobis', 25, CAST(N'2022-01-05T09:21:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (60, 12, CAST(3820885 AS Decimal(18, 0)), N'cash', N'non plurissimum fecit, Versus', 25, CAST(N'2022-09-15T13:31:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (61, 12, CAST(724523 AS Decimal(18, 0)), N'bank', N'quis et si eudis Et eggredior.', 25, CAST(N'2022-03-24T10:37:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (62, 12, CAST(1910987 AS Decimal(18, 0)), N'cash', N'quo quoque quo et Multum non quad dolorum', 25, CAST(N'2022-08-29T22:55:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (63, 12, CAST(4259031 AS Decimal(18, 0)), N'cash', N'quartu egreddior quo, nomen', 25, CAST(N'2022-10-19T07:14:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (64, 12, CAST(1670074 AS Decimal(18, 0)), N'cash', N'Tam trepicandor non et sed', 25, CAST(N'2022-09-07T10:29:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (65, 12, CAST(2033162 AS Decimal(18, 0)), N'bank', N'travissimantor regit,', 25, CAST(N'2022-08-03T11:07:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (66, 12, CAST(2661476 AS Decimal(18, 0)), N'bank', N'linguens funem. linguens', 25, CAST(N'2022-05-27T16:10:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (67, 12, CAST(1915242 AS Decimal(18, 0)), N'cash', N'Quad venit. novum glavans venit.', 25, CAST(N'2022-08-05T21:51:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (68, 12, CAST(4138906 AS Decimal(18, 0)), N'bank', N'linguens eggredior. fecit. non eggredior. Longam,', 25, CAST(N'2022-02-23T04:08:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (69, 12, CAST(3058315 AS Decimal(18, 0)), N'bank', N'delerium. non non dolorum', 25, CAST(N'2021-11-04T11:30:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (70, 12, CAST(704216 AS Decimal(18, 0)), N'bank', N'et glavans essit. si', 25, CAST(N'2022-10-11T10:29:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (71, 12, CAST(1379812 AS Decimal(18, 0)), N'bank', N'Et plorum plorum Id in apparens novum', 25, CAST(N'2021-12-15T22:53:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (72, 12, CAST(2568663 AS Decimal(18, 0)), N'bank', N'non si volcans essit.', 25, CAST(N'2022-02-11T17:09:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (73, 12, CAST(3160128 AS Decimal(18, 0)), N'bank', N'Versus quad quis quantare', 103, CAST(N'2022-03-24T23:57:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (74, 12, CAST(872138 AS Decimal(18, 0)), N'cash', N'volcans gravum non volcans', 103, CAST(N'2022-01-24T02:38:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (75, 12, CAST(2379445 AS Decimal(18, 0)), N'bank', N'in nomen et si estis fecundio, apparens', 103, CAST(N'2022-10-23T17:56:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (76, 12, CAST(2351654 AS Decimal(18, 0)), N'bank', N'gravis bono fecit. vobis', 103, CAST(N'2022-09-12T12:12:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (77, 12, CAST(1498084 AS Decimal(18, 0)), N'cash', N'nomen plorum fecundio, Sed trepicandor', 103, CAST(N'2022-07-31T20:53:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (78, 12, CAST(4991780 AS Decimal(18, 0)), N'bank', N'non manifestum non plorum', 103, CAST(N'2022-01-05T05:38:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (79, 12, CAST(643311 AS Decimal(18, 0)), N'cash', N'linguens nomen nomen si Id pladior vantis. et', 103, CAST(N'2021-12-16T14:06:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (80, 12, CAST(1049923 AS Decimal(18, 0)), N'cash', N'travissimantor non estis', 103, CAST(N'2022-04-29T02:52:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (81, 12, CAST(1160548 AS Decimal(18, 0)), N'cash', N'quo quorum travissimantor eggredior.', 103, CAST(N'2021-11-26T13:54:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (82, 12, CAST(2663555 AS Decimal(18, 0)), N'bank', N'Et cognitio, dolorum non Tam essit.', 103, CAST(N'2022-08-18T21:07:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (83, 12, CAST(3251239 AS Decimal(18, 0)), N'bank', N'Pro volcans egreddior e', 103, CAST(N'2022-06-17T23:20:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (84, 12, CAST(2354132 AS Decimal(18, 0)), N'bank', N'vobis pars essit. non', 103, CAST(N'2022-02-25T15:02:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (85, 12, CAST(3027791 AS Decimal(18, 0)), N'bank', N'homo, brevens, habitatio', 103, CAST(N'2021-11-21T14:59:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (86, 12, CAST(1247281 AS Decimal(18, 0)), N'bank', N'non fecit. plorum quad', 103, CAST(N'2022-09-24T00:14:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (87, 12, CAST(1770235 AS Decimal(18, 0)), N'bank', N'funem. quo si Et rarendum', 103, CAST(N'2021-10-20T02:08:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (88, 12, CAST(4629074 AS Decimal(18, 0)), N'bank', N'quo et transit. gravum', 103, CAST(N'2022-05-11T12:12:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (89, 12, CAST(4362681 AS Decimal(18, 0)), N'bank', N'vobis et eudis apparens quad', 103, CAST(N'2021-10-28T08:15:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (90, 12, CAST(2768882 AS Decimal(18, 0)), N'cash', N'travissimantor esset', 103, CAST(N'2022-04-23T22:13:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (91, 12, CAST(353939 AS Decimal(18, 0)), N'bank', N'Versus nomen pladior trepicandor vobis', 103, CAST(N'2022-09-10T15:31:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (92, 1, CAST(4641359 AS Decimal(18, 0)), N'cash', N'estum. habitatio non e in in', 139, CAST(N'2022-08-03T10:21:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (93, 1, CAST(2139646 AS Decimal(18, 0)), N'cash', N'apparens e parte pars', 139, CAST(N'2022-09-27T01:05:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (94, 1, CAST(1906674 AS Decimal(18, 0)), N'cash', N'quartu Et eggredior. Longam,', 139, CAST(N'2022-08-16T19:42:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (95, 9, CAST(2121724 AS Decimal(18, 0)), N'cash', N'Et quantare quo Quad', 125, CAST(N'2021-11-20T05:29:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (96, 9, CAST(76406 AS Decimal(18, 0)), N'cash', N'plorum linguens et ut et quo', 125, CAST(N'2022-01-06T11:14:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (97, 9, CAST(3059226 AS Decimal(18, 0)), N'cash', N'ut e funem. novum si', 125, CAST(N'2022-09-25T02:22:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (98, 9, CAST(4613870 AS Decimal(18, 0)), N'cash', N'plorum et si e regit, fecundio, in Versus', 125, CAST(N'2022-08-14T00:28:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (99, 9, CAST(158461 AS Decimal(18, 0)), N'cash', N'gravum nomen dolorum nomen', 125, CAST(N'2022-01-08T10:08:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (100, 9, CAST(2621824 AS Decimal(18, 0)), N'cash', N'venit. transit. non Longam,', 125, CAST(N'2022-09-25T03:32:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (101, 9, CAST(143584 AS Decimal(18, 0)), N'bank', N'in egreddior quorum si in', 125, CAST(N'2021-11-19T07:32:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (102, 9, CAST(589014 AS Decimal(18, 0)), N'cash', N'quis eudis dolorum linguens in gravis', 125, CAST(N'2022-07-05T00:45:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (103, 9, CAST(3854334 AS Decimal(18, 0)), N'cash', N'et et non Pro funem. quo,', 125, CAST(N'2022-05-01T12:10:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (104, 9, CAST(4133952 AS Decimal(18, 0)), N'bank', N'plorum plorum Tam et', 125, CAST(N'2022-04-21T00:02:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (105, 9, CAST(2189647 AS Decimal(18, 0)), N'bank', N'essit. quad quorum rarendum', 125, CAST(N'2022-05-23T09:56:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (106, 9, CAST(1835617 AS Decimal(18, 0)), N'bank', N'e quartu parte rarendum si', 125, CAST(N'2021-12-07T07:39:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (107, 9, CAST(420669 AS Decimal(18, 0)), N'bank', N'si delerium. e manifestum', 125, CAST(N'2022-03-04T15:34:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (108, 9, CAST(3649689 AS Decimal(18, 0)), N'bank', N'eudis vobis gravis quo travissimantor quo, sed', 125, CAST(N'2021-10-12T18:46:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (109, 9, CAST(3774843 AS Decimal(18, 0)), N'bank', N'Longam, Et novum quorum e', 125, CAST(N'2022-03-24T07:04:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (110, 9, CAST(2253923 AS Decimal(18, 0)), N'bank', N'Quad et imaginator Versus', 125, CAST(N'2022-02-26T04:23:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (111, 9, CAST(1523899 AS Decimal(18, 0)), N'bank', N'Versus venit. imaginator Sed Longam,', 125, CAST(N'2022-05-17T02:19:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (112, 9, CAST(265270 AS Decimal(18, 0)), N'cash', N'pars gravis glavans quoque', 125, CAST(N'2022-04-21T09:55:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (113, 9, CAST(2003289 AS Decimal(18, 0)), N'bank', N'estum. vantis. Et quorum quad', 125, CAST(N'2022-06-04T11:53:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (114, 9, CAST(4772701 AS Decimal(18, 0)), N'bank', N'Multum venit. e et e regit, Quad quad', 125, CAST(N'2022-07-13T06:30:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (115, 9, CAST(2680336 AS Decimal(18, 0)), N'bank', N'pladior apparens si Versus homo,', 125, CAST(N'2022-07-25T23:37:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (116, 9, CAST(3060968 AS Decimal(18, 0)), N'bank', N'gravum plorum venit.', 125, CAST(N'2022-06-09T13:31:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (117, 9, CAST(3659748 AS Decimal(18, 0)), N'bank', N'si delerium. sed novum', 125, CAST(N'2021-12-17T23:35:00' AS SmallDateTime))
GO
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (118, 9, CAST(1924898 AS Decimal(18, 0)), N'cash', N'homo, eudis linguens trepicandor et', 125, CAST(N'2022-05-29T16:11:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (119, 9, CAST(3642284 AS Decimal(18, 0)), N'cash', N'essit. delerium. pars Longam, et', 125, CAST(N'2022-07-22T19:30:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (120, 9, CAST(805881 AS Decimal(18, 0)), N'bank', N'vantis. homo, quad trepicandor et', 125, CAST(N'2022-09-13T10:53:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (121, 9, CAST(911240 AS Decimal(18, 0)), N'cash', N'eggredior. gravis nomen et', 125, CAST(N'2022-05-13T14:02:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (122, 9, CAST(2286168 AS Decimal(18, 0)), N'bank', N'Quad plurissimum Multum', 125, CAST(N'2021-12-31T09:38:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (123, 9, CAST(4776226 AS Decimal(18, 0)), N'cash', N'imaginator dolorum funem. et', 125, CAST(N'2022-01-31T19:52:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (124, 9, CAST(309433 AS Decimal(18, 0)), N'cash', N'plorum volcans manifestum si', 125, CAST(N'2022-05-17T13:18:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (125, 9, CAST(370276 AS Decimal(18, 0)), N'cash', N'sed bono eudis quis quo e gravis', 125, CAST(N'2021-11-05T18:58:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (126, 9, CAST(1738453 AS Decimal(18, 0)), N'bank', N'quoque quantare sed Tam si quad', 125, CAST(N'2022-03-18T12:32:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (127, 9, CAST(449017 AS Decimal(18, 0)), N'bank', N'et et habitatio et in', 125, CAST(N'2022-03-21T16:05:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (128, 9, CAST(1273453 AS Decimal(18, 0)), N'bank', N'quo, parte manifestum', 125, CAST(N'2022-06-12T04:15:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (129, 9, CAST(3750415 AS Decimal(18, 0)), N'cash', N'imaginator imaginator quad', 125, CAST(N'2021-12-09T21:09:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (130, 9, CAST(2323039 AS Decimal(18, 0)), N'bank', N'esset quo habitatio Multum', 125, CAST(N'2022-07-23T06:42:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (131, 9, CAST(4292428 AS Decimal(18, 0)), N'cash', N'egreddior eggredior.', 125, CAST(N'2022-10-22T09:51:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (132, 9, CAST(1884214 AS Decimal(18, 0)), N'cash', N'plurissimum quis estis Et manifestum nomen nomen', 125, CAST(N'2022-10-21T20:25:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (133, 9, CAST(4853319 AS Decimal(18, 0)), N'cash', N'gravum non si homo, et linguens novum', 125, CAST(N'2022-10-31T19:31:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (134, 9, CAST(3021488 AS Decimal(18, 0)), N'bank', N'venit. cognitio, quoque', 125, CAST(N'2022-01-25T10:34:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (135, 9, CAST(926338 AS Decimal(18, 0)), N'cash', N'estum. gravum et homo,', 125, CAST(N'2022-03-15T19:19:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (136, 9, CAST(591534 AS Decimal(18, 0)), N'cash', N'esset glavans pars sed Multum eggredior. Id', 125, CAST(N'2022-03-28T13:09:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (137, 9, CAST(3809222 AS Decimal(18, 0)), N'cash', N'pars Tam plorum et quorum', 125, CAST(N'2022-01-23T08:56:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (138, 1, CAST(4117288 AS Decimal(18, 0)), N'bank', N'quantare pladior glavans', 135, CAST(N'2021-12-02T23:17:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (139, 1, CAST(184485 AS Decimal(18, 0)), N'bank', N'parte quis trepicandor apparens', 135, CAST(N'2022-08-09T05:06:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (140, 1, CAST(1212174 AS Decimal(18, 0)), N'cash', N'ut Versus apparens non', 135, CAST(N'2022-10-19T07:20:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (141, 1, CAST(846611 AS Decimal(18, 0)), N'cash', N'brevens, delerium. dolorum sed', 135, CAST(N'2022-04-27T08:40:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (142, 1, CAST(3120547 AS Decimal(18, 0)), N'bank', N'quorum gravis gravum', 135, CAST(N'2021-10-13T07:22:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (143, 1, CAST(874231 AS Decimal(18, 0)), N'bank', N'fecit. quartu plorum', 135, CAST(N'2021-11-23T05:08:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (144, 1, CAST(2128757 AS Decimal(18, 0)), N'bank', N'nomen estis manifestum nomen', 135, CAST(N'2022-07-06T03:53:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (145, 1, CAST(1264983 AS Decimal(18, 0)), N'cash', N'linguens dolorum Quad in', 135, CAST(N'2022-10-11T19:55:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (146, 1, CAST(108669 AS Decimal(18, 0)), N'cash', N'vantis. funem. eggredior.', 135, CAST(N'2022-02-25T05:36:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (147, 1, CAST(2658070 AS Decimal(18, 0)), N'cash', N'quantare in pars linguens', 135, CAST(N'2021-12-04T22:27:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (148, 1, CAST(2366946 AS Decimal(18, 0)), N'cash', N'gravum volcans Pro egreddior ut', 135, CAST(N'2021-12-20T18:35:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (149, 1, CAST(4226338 AS Decimal(18, 0)), N'bank', N'travissimantor vantis. quo', 135, CAST(N'2021-10-27T20:04:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (150, 1, CAST(4060756 AS Decimal(18, 0)), N'cash', N'novum vantis. eggredior. Versus non', 135, CAST(N'2022-04-16T15:58:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (151, 1, CAST(1416658 AS Decimal(18, 0)), N'cash', N'fecit, estis non transit. novum quo fecundio,', 135, CAST(N'2021-10-25T11:38:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (152, 1, CAST(1154328 AS Decimal(18, 0)), N'bank', N'dolorum linguens eudis', 135, CAST(N'2022-02-01T10:10:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (153, 1, CAST(991586 AS Decimal(18, 0)), N'bank', N'vantis. plurissimum ut', 135, CAST(N'2021-10-28T04:58:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (154, 1, CAST(4352580 AS Decimal(18, 0)), N'cash', N'non Id nomen et fecit.', 135, CAST(N'2022-02-28T23:15:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (155, 1, CAST(1730583 AS Decimal(18, 0)), N'cash', N'eudis non regit, Id estum.', 135, CAST(N'2022-02-17T13:30:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (156, 1, CAST(2857416 AS Decimal(18, 0)), N'bank', N'Multum vantis. rarendum', 135, CAST(N'2022-09-22T21:55:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (157, 1, CAST(812789 AS Decimal(18, 0)), N'bank', N'cognitio, imaginator si regit,', 135, CAST(N'2022-03-09T04:52:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (158, 1, CAST(3564901 AS Decimal(18, 0)), N'cash', N'quad esset eggredior.', 135, CAST(N'2022-10-18T22:53:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (159, 1, CAST(3783676 AS Decimal(18, 0)), N'bank', N'si ut eudis estis cognitio,', 135, CAST(N'2022-03-21T05:04:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (160, 1, CAST(471193 AS Decimal(18, 0)), N'cash', N'plorum Id venit. apparens estum. et', 135, CAST(N'2021-12-10T21:24:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (161, 12, CAST(1406599 AS Decimal(18, 0)), N'bank', N'cognitio, eudis estum.', 33, CAST(N'2022-07-22T15:35:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (162, 12, CAST(4147217 AS Decimal(18, 0)), N'cash', N'esset bono Tam si Quad', 33, CAST(N'2022-07-27T11:20:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (163, 12, CAST(4899274 AS Decimal(18, 0)), N'cash', N'volcans quad gravis fecundio,', 33, CAST(N'2022-09-06T21:37:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (164, 12, CAST(1471803 AS Decimal(18, 0)), N'cash', N'plurissimum in manifestum quo novum fecit. vantis.', 33, CAST(N'2022-07-06T00:23:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (165, 12, CAST(2961496 AS Decimal(18, 0)), N'bank', N'estis non plorum regit, plorum', 33, CAST(N'2022-03-10T18:32:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (166, 12, CAST(4639686 AS Decimal(18, 0)), N'bank', N'quis transit. pladior', 33, CAST(N'2022-05-30T05:54:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (167, 12, CAST(411952 AS Decimal(18, 0)), N'bank', N'travissimantor manifestum vobis non vobis et', 33, CAST(N'2022-04-24T14:24:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (168, 12, CAST(3981802 AS Decimal(18, 0)), N'cash', N'pladior quad quo quad gravis', 33, CAST(N'2022-02-13T01:19:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (169, 12, CAST(3866362 AS Decimal(18, 0)), N'cash', N'vobis travissimantor quo,', 33, CAST(N'2022-02-02T11:11:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (170, 12, CAST(2108802 AS Decimal(18, 0)), N'cash', N'nomen vobis Versus in quoque', 33, CAST(N'2022-02-02T10:27:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (171, 12, CAST(4251747 AS Decimal(18, 0)), N'cash', N'si eudis Tam e imaginator', 33, CAST(N'2022-02-20T04:34:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (172, 12, CAST(4542461 AS Decimal(18, 0)), N'bank', N'vobis et manifestum trepicandor', 33, CAST(N'2021-10-21T00:18:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (173, 12, CAST(1760413 AS Decimal(18, 0)), N'cash', N'quo, novum estum. quantare', 33, CAST(N'2022-08-24T11:06:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (174, 12, CAST(2450110 AS Decimal(18, 0)), N'bank', N'sed novum gravum brevens, fecit, quantare', 33, CAST(N'2022-08-07T12:10:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (175, 12, CAST(4959271 AS Decimal(18, 0)), N'bank', N'novum funem. et homo, imaginator quartu quorum', 33, CAST(N'2022-02-22T02:13:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (176, 12, CAST(2790694 AS Decimal(18, 0)), N'cash', N'si dolorum si fecit. fecit, quad', 33, CAST(N'2022-05-06T06:39:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (177, 12, CAST(1431937 AS Decimal(18, 0)), N'bank', N'e quad e quis dolorum Versus', 33, CAST(N'2021-11-13T04:30:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (178, 12, CAST(2667468 AS Decimal(18, 0)), N'bank', N'quantare venit. gravum', 33, CAST(N'2022-06-01T16:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (179, 12, CAST(4044450 AS Decimal(18, 0)), N'cash', N'sed estis gravum et travissimantor', 33, CAST(N'2022-06-09T17:23:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (180, 12, CAST(281607 AS Decimal(18, 0)), N'bank', N'quo volcans et travissimantor et', 33, CAST(N'2022-07-15T13:23:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (181, 12, CAST(4080384 AS Decimal(18, 0)), N'cash', N'e imaginator regit, quantare', 33, CAST(N'2022-01-17T14:05:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (182, 12, CAST(3082071 AS Decimal(18, 0)), N'bank', N'delerium. funem. quantare', 33, CAST(N'2022-01-04T21:29:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (183, 12, CAST(2047115 AS Decimal(18, 0)), N'bank', N'eudis quad Id brevens,', 33, CAST(N'2022-05-21T08:10:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (184, 9, CAST(4689659 AS Decimal(18, 0)), N'cash', N'si quo, travissimantor', 68, CAST(N'2022-06-29T05:11:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (185, 9, CAST(926380 AS Decimal(18, 0)), N'cash', N'e cognitio, ut novum fecit, essit. plurissimum', 68, CAST(N'2022-07-03T19:03:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (186, 9, CAST(3158099 AS Decimal(18, 0)), N'cash', N'si dolorum dolorum apparens', 68, CAST(N'2022-06-25T23:41:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (187, 9, CAST(912627 AS Decimal(18, 0)), N'cash', N'non quo e bono quorum regit,', 68, CAST(N'2022-09-29T15:27:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (188, 9, CAST(520738 AS Decimal(18, 0)), N'bank', N'Tam quad travissimantor non in', 68, CAST(N'2022-06-07T20:15:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (189, 9, CAST(1310904 AS Decimal(18, 0)), N'cash', N'egreddior dolorum homo, fecit.', 68, CAST(N'2022-10-11T21:04:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (190, 9, CAST(3068922 AS Decimal(18, 0)), N'bank', N'funem. quad apparens', 68, CAST(N'2022-04-26T21:24:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (191, 9, CAST(4778746 AS Decimal(18, 0)), N'cash', N'manifestum travissimantor', 68, CAST(N'2021-10-25T08:16:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (192, 9, CAST(264320 AS Decimal(18, 0)), N'cash', N'novum e et plurissimum regit,', 68, CAST(N'2022-02-08T10:04:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (193, 9, CAST(353612 AS Decimal(18, 0)), N'cash', N'fecit. quad plorum fecundio,', 68, CAST(N'2022-07-18T18:14:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (194, 9, CAST(4713292 AS Decimal(18, 0)), N'bank', N'et brevens, et e Pro', 68, CAST(N'2022-06-04T07:42:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (195, 9, CAST(4805575 AS Decimal(18, 0)), N'bank', N'imaginator Pro plurissimum', 68, CAST(N'2022-01-02T15:45:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (196, 9, CAST(1699395 AS Decimal(18, 0)), N'bank', N'transit. rarendum et', 68, CAST(N'2022-08-04T21:20:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (197, 9, CAST(3221273 AS Decimal(18, 0)), N'cash', N'trepicandor gravis ut', 68, CAST(N'2021-12-10T09:45:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (198, 9, CAST(4402428 AS Decimal(18, 0)), N'bank', N'vobis linguens quis eudis', 68, CAST(N'2022-03-24T04:45:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (199, 9, CAST(4167262 AS Decimal(18, 0)), N'cash', N'egreddior novum estum.', 68, CAST(N'2022-01-31T09:20:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (200, 9, CAST(1625298 AS Decimal(18, 0)), N'bank', N'quoque Multum pladior quad Sed', 68, CAST(N'2022-02-17T14:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1019, 11, CAST(1001520 AS Decimal(18, 0)), N'cash', N'test', 145, CAST(N'2022-11-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1024, 38, CAST(2500000 AS Decimal(18, 0)), N'cash', N'dgtdgdfg df', 344, CAST(N'2022-11-07T11:20:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1025, 39, CAST(2300000 AS Decimal(18, 0)), N'cash', N'gfgxccvcx xc', 361, CAST(N'2022-11-07T11:22:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1026, 39, CAST(3400000 AS Decimal(18, 0)), N'cash', N'sdfsfxc vxc', 360, CAST(N'2022-11-07T11:22:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1027, 39, CAST(3230000 AS Decimal(18, 0)), N'cash', N'ddi hotl', 369, CAST(N'2022-11-07T11:22:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1028, 29, CAST(1608566 AS Decimal(18, 0)), N'cash', N'manifestum essit. Et in novum non pars', 180, CAST(N'2022-07-21T05:20:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1029, 31, CAST(1522319 AS Decimal(18, 0)), N'bank', N'regit, quo novum quoque', 217, CAST(N'2022-02-24T13:50:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1030, 29, CAST(116790 AS Decimal(18, 0)), N'cash', N'quad Sed quo quorum regit, in Longam,', 175, CAST(N'2022-02-19T14:13:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1031, 37, CAST(629715 AS Decimal(18, 0)), N'cash', N'vobis eggredior. cognitio, si', 324, CAST(N'2022-10-21T17:31:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1032, 32, CAST(1545009 AS Decimal(18, 0)), N'cash', N'quo, quad travissimantor plurissimum Et plurissimum', 239, CAST(N'2022-03-26T08:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1033, 28, CAST(83601 AS Decimal(18, 0)), N'bank', N'e et plorum glavans gravis quo, plorum habitatio', 170, CAST(N'2022-03-19T20:24:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1034, 36, CAST(879903 AS Decimal(18, 0)), N'bank', N'quorum vobis apparens novum apparens quad', 309, CAST(N'2021-10-02T22:59:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1035, 30, CAST(778545 AS Decimal(18, 0)), N'cash', N'quad linguens non plorum manifestum glavans', 203, CAST(N'2022-09-17T04:28:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1036, 29, CAST(1205274 AS Decimal(18, 0)), N'bank', N'linguens in estis nomen', 178, CAST(N'2021-08-01T13:25:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1037, 37, CAST(56332 AS Decimal(18, 0)), N'bank', N'linguens quo fecundio, volcans non', 332, CAST(N'2022-05-31T17:42:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1038, 34, CAST(404914 AS Decimal(18, 0)), N'cash', N'Pro gravis travissimantor quis', 274, CAST(N'2022-03-15T11:55:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1039, 34, CAST(562740 AS Decimal(18, 0)), N'bank', N'et quorum delerium. ut vobis parte quartu travissimantor', 271, CAST(N'2021-07-13T19:56:00' AS SmallDateTime))
GO
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1040, 31, CAST(1937440 AS Decimal(18, 0)), N'bank', N'fecit. gravum e venit.', 211, CAST(N'2022-05-15T19:47:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1041, 32, CAST(1683270 AS Decimal(18, 0)), N'bank', N'plurissimum quad et bono', 237, CAST(N'2021-07-23T12:11:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1042, 30, CAST(1934189 AS Decimal(18, 0)), N'bank', N'cognitio, in et quo pars', 193, CAST(N'2022-06-18T23:27:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1043, 34, CAST(269690 AS Decimal(18, 0)), N'bank', N'glavans non pars homo, linguens Tam', 276, CAST(N'2022-07-25T12:21:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1044, 33, CAST(310320 AS Decimal(18, 0)), N'cash', N'estis quo venit. estis', 243, CAST(N'2021-11-05T04:32:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1045, 28, CAST(434467 AS Decimal(18, 0)), N'bank', N'brevens, rarendum vantis. estis', 165, CAST(N'2022-02-11T18:35:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1046, 33, CAST(1995354 AS Decimal(18, 0)), N'cash', N'quo, trepicandor Longam, funem.', 259, CAST(N'2021-11-05T02:46:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1047, 36, CAST(1216169 AS Decimal(18, 0)), N'cash', N'nomen venit. linguens quantare', 302, CAST(N'2022-05-03T18:40:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1048, 37, CAST(1485441 AS Decimal(18, 0)), N'cash', N'Versus sed homo, quoque quoque quo', 319, CAST(N'2022-06-23T08:40:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1049, 31, CAST(1773143 AS Decimal(18, 0)), N'cash', N'fecit. Id quad gravum cognitio,', 223, CAST(N'2022-07-11T23:19:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1050, 32, CAST(572191 AS Decimal(18, 0)), N'bank', N'vantis. quad et delerium. plurissimum rarendum nomen novum', 227, CAST(N'2021-08-20T02:56:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1051, 37, CAST(564636 AS Decimal(18, 0)), N'bank', N'vobis e parte Tam Multum pladior', 328, CAST(N'2022-04-11T05:50:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1052, 35, CAST(1226100 AS Decimal(18, 0)), N'bank', N'et gravis dolorum quo', 293, CAST(N'2021-06-17T20:50:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1053, 29, CAST(1074380 AS Decimal(18, 0)), N'bank', N'vobis e trepicandor estis gravum Multum', 182, CAST(N'2022-04-29T02:06:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1054, 31, CAST(736957 AS Decimal(18, 0)), N'cash', N'Multum homo, Et eggredior. eudis quantare volcans', 220, CAST(N'2022-09-11T18:11:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1055, 32, CAST(1946751 AS Decimal(18, 0)), N'bank', N'si non et fecit, plurissimum', 241, CAST(N'2021-12-17T02:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1056, 29, CAST(292180 AS Decimal(18, 0)), N'cash', N'non regit, quad Pro plorum et cognitio,', 171, CAST(N'2022-09-10T06:16:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1057, 34, CAST(1061951 AS Decimal(18, 0)), N'bank', N'plorum quartu Longam, in', 270, CAST(N'2021-11-10T04:08:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1058, 33, CAST(102505 AS Decimal(18, 0)), N'cash', N'fecit. quantare cognitio,', 252, CAST(N'2022-02-13T22:17:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1059, 35, CAST(1311193 AS Decimal(18, 0)), N'bank', N'bono non et e et transit. esset', 295, CAST(N'2022-02-20T09:32:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1060, 36, CAST(770830 AS Decimal(18, 0)), N'cash', N'regit, estum. Multum', 308, CAST(N'2021-10-25T23:28:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1061, 34, CAST(1546157 AS Decimal(18, 0)), N'cash', N'trepicandor non nomen vobis', 261, CAST(N'2022-02-16T16:06:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1062, 29, CAST(653102 AS Decimal(18, 0)), N'bank', N'gravis Quad funem. homo, imaginator vobis', 177, CAST(N'2022-08-24T15:22:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1063, 32, CAST(1033461 AS Decimal(18, 0)), N'bank', N'quartu cognitio, Multum funem.', 229, CAST(N'2022-07-16T20:37:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1064, 32, CAST(576862 AS Decimal(18, 0)), N'bank', N'plorum Id essit. delerium.', 242, CAST(N'2022-02-04T14:43:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1065, 29, CAST(365592 AS Decimal(18, 0)), N'cash', N'plorum Id linguens sed', 179, CAST(N'2021-09-15T05:24:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1066, 37, CAST(940887 AS Decimal(18, 0)), N'bank', N'fecundio, gravum et pladior', 315, CAST(N'2021-08-03T00:54:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1067, 37, CAST(1611478 AS Decimal(18, 0)), N'bank', N'Longam, gravis et e novum trepicandor travissimantor', 316, CAST(N'2021-10-08T06:56:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1068, 31, CAST(1483112 AS Decimal(18, 0)), N'cash', N'gravis quartu sed essit.', 210, CAST(N'2021-12-12T02:55:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1069, 30, CAST(659799 AS Decimal(18, 0)), N'bank', N'funem. in vobis et venit. venit.', 201, CAST(N'2021-12-18T23:55:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1070, 31, CAST(1039105 AS Decimal(18, 0)), N'bank', N'linguens in e fecundio, quartu', 215, CAST(N'2021-11-19T14:30:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1071, 31, CAST(1973351 AS Decimal(18, 0)), N'cash', N'novum quoque plorum quo', 212, CAST(N'2022-06-12T20:28:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1072, 34, CAST(1668741 AS Decimal(18, 0)), N'cash', N'pars si pladior non dolorum apparens', 275, CAST(N'2022-08-21T16:43:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1073, 34, CAST(1140759 AS Decimal(18, 0)), N'bank', N'non sed brevens, et eudis', 278, CAST(N'2022-05-01T15:09:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1074, 30, CAST(1825030 AS Decimal(18, 0)), N'cash', N'volcans travissimantor Versus fecit, quoque parte ut', 206, CAST(N'2021-09-01T02:31:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1075, 29, CAST(786323 AS Decimal(18, 0)), N'bank', N'pars quis fecit, pars travissimantor gravis e', 188, CAST(N'2022-05-04T13:24:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1076, 37, CAST(243286 AS Decimal(18, 0)), N'bank', N'vobis et Versus non plorum', 331, CAST(N'2022-08-01T07:55:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1077, 31, CAST(1508462 AS Decimal(18, 0)), N'cash', N'parte pars quoque e brevens,', 224, CAST(N'2022-06-05T04:18:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1078, 29, CAST(974044 AS Decimal(18, 0)), N'bank', N'egreddior essit. volcans et quad Sed', 176, CAST(N'2021-07-07T14:04:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1079, 36, CAST(877618 AS Decimal(18, 0)), N'cash', N'Tam homo, delerium. eudis transit. funem. gravis', 303, CAST(N'2022-02-03T09:21:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1080, 35, CAST(330250 AS Decimal(18, 0)), N'cash', N'quo, Quad non habitatio cognitio, Id travissimantor quad', 279, CAST(N'2021-12-25T22:27:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1081, 35, CAST(640148 AS Decimal(18, 0)), N'cash', N'Tam quad trepicandor fecit. et quo pladior plorum fecundio, quorum', 284, CAST(N'2022-10-08T01:37:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1082, 28, CAST(1379326 AS Decimal(18, 0)), N'bank', N'fecundio, quorum apparens', 169, CAST(N'2022-02-08T01:17:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1083, 28, CAST(50158 AS Decimal(18, 0)), N'cash', N'venit. sed eggredior. brevens,', 168, CAST(N'2021-06-25T06:01:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1084, 35, CAST(437613 AS Decimal(18, 0)), N'bank', N'plorum eggredior. quartu volcans', 285, CAST(N'2021-12-21T10:54:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1085, 33, CAST(248551 AS Decimal(18, 0)), N'bank', N'quis e quo estum. Tam', 256, CAST(N'2022-09-16T08:23:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1086, 32, CAST(847574 AS Decimal(18, 0)), N'bank', N'linguens regit, plorum gravum', 230, CAST(N'2022-10-19T20:41:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1087, 31, CAST(1440744 AS Decimal(18, 0)), N'bank', N'apparens parte fecit.', 208, CAST(N'2022-10-03T05:55:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1088, 36, CAST(100666 AS Decimal(18, 0)), N'bank', N'et esset estis Multum Et ut venit.', 300, CAST(N'2022-05-14T02:13:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1089, 37, CAST(261850 AS Decimal(18, 0)), N'cash', N'nomen gravis habitatio in estis', 320, CAST(N'2022-08-22T20:59:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1090, 29, CAST(996295 AS Decimal(18, 0)), N'cash', N'fecit. et travissimantor funem. essit. et et', 172, CAST(N'2021-06-22T22:12:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1091, 30, CAST(1914145 AS Decimal(18, 0)), N'bank', N'eudis gravis pladior fecit. vobis', 196, CAST(N'2022-07-28T09:18:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1092, 31, CAST(1487596 AS Decimal(18, 0)), N'cash', N'funem. quartu gravum', 221, CAST(N'2021-09-30T19:24:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1093, 32, CAST(1305410 AS Decimal(18, 0)), N'bank', N'eudis imaginator non quo homo,', 236, CAST(N'2021-07-09T02:22:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1094, 28, CAST(944504 AS Decimal(18, 0)), N'bank', N'Et plorum Id gravis manifestum', 160, CAST(N'2022-07-24T20:29:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1095, 28, CAST(1214830 AS Decimal(18, 0)), N'cash', N'gravis ut pars eggredior.', 164, CAST(N'2021-09-12T03:40:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1096, 36, CAST(1700136 AS Decimal(18, 0)), N'bank', N'novum vantis. Pro transit. si in', 312, CAST(N'2021-10-04T20:50:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1097, 28, CAST(1189342 AS Decimal(18, 0)), N'bank', N'glavans in estum. Longam,', 163, CAST(N'2022-10-09T02:50:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1098, 30, CAST(348945 AS Decimal(18, 0)), N'bank', N'quo, gravis et fecundio, quartu gravum pladior', 199, CAST(N'2021-12-03T21:37:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1099, 31, CAST(534679 AS Decimal(18, 0)), N'bank', N'gravis quo si imaginator', 222, CAST(N'2021-08-05T23:08:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1100, 33, CAST(1164174 AS Decimal(18, 0)), N'cash', N'in pladior fecit, plorum', 245, CAST(N'2021-12-25T17:40:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1101, 37, CAST(1736695 AS Decimal(18, 0)), N'bank', N'imaginator Et pars eggredior. pladior Et quo, in', 327, CAST(N'2021-07-13T19:49:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1102, 28, CAST(1385660 AS Decimal(18, 0)), N'cash', N'nomen Tam quad dolorum', 159, CAST(N'2021-11-05T15:44:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1103, 35, CAST(338040 AS Decimal(18, 0)), N'bank', N'quis quo, habitatio Longam, habitatio', 283, CAST(N'2021-12-19T08:44:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1104, 37, CAST(1957316 AS Decimal(18, 0)), N'cash', N'non e brevens, quo quis', 321, CAST(N'2022-02-05T08:48:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1105, 28, CAST(23865 AS Decimal(18, 0)), N'cash', N'quis gravum quoque et et', 156, CAST(N'2022-01-13T06:28:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1106, 30, CAST(30167 AS Decimal(18, 0)), N'cash', N'quo Longam, et travissimantor trepicandor quantare brevens, non', 194, CAST(N'2022-06-26T13:08:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1107, 35, CAST(1932156 AS Decimal(18, 0)), N'bank', N'nomen fecundio, vobis sed rarendum', 291, CAST(N'2021-12-23T05:42:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1108, 34, CAST(1532533 AS Decimal(18, 0)), N'bank', N'Id essit. estis pars', 273, CAST(N'2022-02-10T23:35:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1109, 34, CAST(312090 AS Decimal(18, 0)), N'bank', N'si apparens quo plurissimum essit. quo,', 277, CAST(N'2021-10-24T04:46:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1110, 31, CAST(965337 AS Decimal(18, 0)), N'bank', N'ut delerium. non quo, plorum vobis apparens', 216, CAST(N'2022-03-23T18:06:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1111, 37, CAST(909122 AS Decimal(18, 0)), N'bank', N'et trepicandor eudis delerium. trepicandor quad', 326, CAST(N'2021-09-21T01:58:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1112, 32, CAST(309501 AS Decimal(18, 0)), N'cash', N'et cognitio, Versus plorum glavans non quartu', 232, CAST(N'2021-10-19T14:04:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1113, 36, CAST(117716 AS Decimal(18, 0)), N'cash', N'gravum vobis eggredior. fecit.', 305, CAST(N'2021-06-26T12:56:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1114, 30, CAST(990410 AS Decimal(18, 0)), N'bank', N'si esset rarendum manifestum', 202, CAST(N'2021-08-11T11:05:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1115, 33, CAST(1756584 AS Decimal(18, 0)), N'bank', N'essit. in nomen non fecit,', 260, CAST(N'2021-11-23T21:51:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1116, 33, CAST(1496081 AS Decimal(18, 0)), N'bank', N'apparens vobis non Pro', 248, CAST(N'2021-06-24T14:48:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1117, 37, CAST(1065100 AS Decimal(18, 0)), N'bank', N'eudis plurissimum linguens', 318, CAST(N'2022-08-15T09:21:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1118, 35, CAST(1023270 AS Decimal(18, 0)), N'bank', N'plorum Multum venit. Tam glavans', 288, CAST(N'2022-01-09T09:43:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1119, 30, CAST(1253646 AS Decimal(18, 0)), N'cash', N'quis travissimantor travissimantor', 197, CAST(N'2022-03-27T06:21:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1120, 33, CAST(1016152 AS Decimal(18, 0)), N'bank', N'habitatio et nomen Sed regit,', 250, CAST(N'2021-10-02T08:43:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1121, 35, CAST(1702474 AS Decimal(18, 0)), N'cash', N'Multum manifestum fecundio, et in Multum', 287, CAST(N'2021-09-05T19:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1122, 28, CAST(721879 AS Decimal(18, 0)), N'bank', N'rarendum ut Quad fecundio, Tam', 155, CAST(N'2022-04-02T04:43:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1123, 29, CAST(1655572 AS Decimal(18, 0)), N'bank', N'ut parte novum habitatio', 184, CAST(N'2022-02-25T05:56:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1124, 37, CAST(1908066 AS Decimal(18, 0)), N'cash', N'Multum et e glavans linguens volcans travissimantor quartu quad', 322, CAST(N'2021-12-12T01:43:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1125, 35, CAST(1382862 AS Decimal(18, 0)), N'bank', N'et quad quad pars estum.', 289, CAST(N'2022-02-28T05:13:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1126, 36, CAST(1051439 AS Decimal(18, 0)), N'cash', N'travissimantor trepicandor', 313, CAST(N'2022-02-26T01:04:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1127, 29, CAST(647457 AS Decimal(18, 0)), N'bank', N'bono non et cognitio, Multum plurissimum Versus', 187, CAST(N'2022-07-29T14:20:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1128, 36, CAST(146302 AS Decimal(18, 0)), N'cash', N'si non vobis parte quis quartu bono Quad venit.', 306, CAST(N'2022-08-13T18:41:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1129, 29, CAST(1967069 AS Decimal(18, 0)), N'bank', N'estis linguens homo, quoque', 183, CAST(N'2022-10-25T22:51:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1130, 35, CAST(69047 AS Decimal(18, 0)), N'bank', N'manifestum plurissimum', 296, CAST(N'2022-01-13T16:33:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1131, 36, CAST(117737 AS Decimal(18, 0)), N'bank', N'linguens et quorum nomen non plurissimum eudis funem.', 301, CAST(N'2022-08-29T05:05:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1132, 35, CAST(783375 AS Decimal(18, 0)), N'cash', N'quo regit, glavans Multum', 286, CAST(N'2021-12-16T06:41:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1133, 29, CAST(1836141 AS Decimal(18, 0)), N'bank', N'in funem. fecit, linguens', 186, CAST(N'2022-10-07T14:56:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1134, 36, CAST(1428435 AS Decimal(18, 0)), N'cash', N'non nomen non manifestum imaginator', 310, CAST(N'2021-07-25T15:40:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1135, 31, CAST(1279984 AS Decimal(18, 0)), N'bank', N'apparens quis si plorum', 209, CAST(N'2021-11-28T02:37:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1136, 34, CAST(1579317 AS Decimal(18, 0)), N'bank', N'rarendum homo, eudis delerium. fecit. non plorum', 266, CAST(N'2022-05-18T09:52:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1137, 33, CAST(489031 AS Decimal(18, 0)), N'cash', N'Id quo regit, Multum', 249, CAST(N'2021-08-05T16:33:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1138, 29, CAST(191647 AS Decimal(18, 0)), N'bank', N'quo novum homo, quad vobis quad', 181, CAST(N'2022-03-25T21:13:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1139, 34, CAST(847230 AS Decimal(18, 0)), N'bank', N'in egreddior eggredior. quad', 262, CAST(N'2022-10-14T04:26:00' AS SmallDateTime))
GO
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1140, 37, CAST(436828 AS Decimal(18, 0)), N'bank', N'quad trepicandor egreddior', 330, CAST(N'2021-09-05T19:15:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1141, 30, CAST(1494591 AS Decimal(18, 0)), N'bank', N'egreddior et novum estum.', 205, CAST(N'2022-04-12T14:59:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1142, 37, CAST(570802 AS Decimal(18, 0)), N'bank', N'fecit, glavans delerium.', 329, CAST(N'2022-02-05T06:19:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1143, 32, CAST(1072483 AS Decimal(18, 0)), N'bank', N'brevens, quartu si Multum si brevens, nomen quo', 228, CAST(N'2022-01-03T21:26:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1144, 32, CAST(1957627 AS Decimal(18, 0)), N'cash', N'travissimantor fecit, novum', 238, CAST(N'2021-11-15T02:53:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1145, 28, CAST(1053439 AS Decimal(18, 0)), N'bank', N'quo eggredior. rarendum imaginator', 161, CAST(N'2022-08-07T20:14:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1146, 35, CAST(1508051 AS Decimal(18, 0)), N'bank', N'non eudis glavans quis linguens funem. quad', 280, CAST(N'2022-03-24T19:13:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1147, 28, CAST(530774 AS Decimal(18, 0)), N'bank', N'quartu essit. nomen cognitio, funem. funem. apparens', 153, CAST(N'2021-09-20T06:28:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1148, 28, CAST(219622 AS Decimal(18, 0)), N'cash', N'venit. volcans Et Pro egreddior', 157, CAST(N'2022-10-03T15:18:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1149, 35, CAST(455448 AS Decimal(18, 0)), N'bank', N'regit, essit. imaginator plorum Versus homo,', 281, CAST(N'2022-02-13T22:37:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1150, 36, CAST(1828850 AS Decimal(18, 0)), N'bank', N'travissimantor imaginator', 298, CAST(N'2021-09-03T12:51:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1151, 37, CAST(1884635 AS Decimal(18, 0)), N'cash', N'apparens quad quo, et Longam, gravis Id', 317, CAST(N'2021-12-26T11:30:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1152, 35, CAST(1229361 AS Decimal(18, 0)), N'cash', N'fecit. volcans quorum et', 292, CAST(N'2022-03-15T17:07:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1153, 30, CAST(1590218 AS Decimal(18, 0)), N'bank', N'esset vobis fecit, imaginator', 190, CAST(N'2022-07-15T15:17:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1154, 33, CAST(1103714 AS Decimal(18, 0)), N'cash', N'eggredior. apparens imaginator', 254, CAST(N'2022-09-09T14:26:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1155, 35, CAST(432775 AS Decimal(18, 0)), N'bank', N'si imaginator nomen e', 282, CAST(N'2021-10-04T22:39:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1156, 34, CAST(1594545 AS Decimal(18, 0)), N'bank', N'plurissimum Pro homo,', 268, CAST(N'2022-02-16T15:07:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1157, 37, CAST(1998533 AS Decimal(18, 0)), N'bank', N'et quorum in nomen quo, pars', 323, CAST(N'2022-07-17T09:49:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1158, 30, CAST(1541487 AS Decimal(18, 0)), N'bank', N'essit. Multum et si et', 189, CAST(N'2021-06-23T07:01:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1159, 36, CAST(342816 AS Decimal(18, 0)), N'bank', N'quad esset Versus Tam Id Multum', 311, CAST(N'2022-10-14T03:35:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1160, 34, CAST(723097 AS Decimal(18, 0)), N'cash', N'et in apparens travissimantor', 265, CAST(N'2022-09-23T05:24:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1161, 33, CAST(136437 AS Decimal(18, 0)), N'bank', N'glavans estum. quorum', 258, CAST(N'2022-10-03T22:48:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1162, 31, CAST(229035 AS Decimal(18, 0)), N'cash', N'egreddior non novum estis in fecit, linguens', 207, CAST(N'2022-03-17T11:02:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1163, 36, CAST(1654952 AS Decimal(18, 0)), N'bank', N'quo, glavans fecit. Multum', 299, CAST(N'2022-02-22T00:44:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1164, 33, CAST(928037 AS Decimal(18, 0)), N'bank', N'in quantare gravis pladior', 251, CAST(N'2022-08-16T12:14:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1165, 30, CAST(1431498 AS Decimal(18, 0)), N'cash', N'homo, bono rarendum quad', 204, CAST(N'2022-05-31T13:01:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1166, 28, CAST(1949770 AS Decimal(18, 0)), N'cash', N'quad quad nomen cognitio, homo,', 166, CAST(N'2022-08-11T19:18:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1167, 36, CAST(296917 AS Decimal(18, 0)), N'cash', N'quo, vantis. non cognitio, et plorum quo e essit. quo, funem. quad', 297, CAST(N'2021-11-17T23:09:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1168, 31, CAST(811591 AS Decimal(18, 0)), N'cash', N'vobis delerium. quartu plorum quoque plorum', 213, CAST(N'2022-10-07T21:16:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1169, 33, CAST(367011 AS Decimal(18, 0)), N'bank', N'trepicandor regit, estis', 257, CAST(N'2022-07-20T08:29:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1170, 30, CAST(1935372 AS Decimal(18, 0)), N'bank', N'plorum et e essit. essit. brevens,', 200, CAST(N'2022-05-14T12:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1171, 29, CAST(1892652 AS Decimal(18, 0)), N'cash', N'estis plorum fecit, et', 174, CAST(N'2022-09-24T22:16:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1172, 35, CAST(208685 AS Decimal(18, 0)), N'bank', N'et plurissimum esset', 290, CAST(N'2021-11-05T12:07:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1173, 35, CAST(1394413 AS Decimal(18, 0)), N'bank', N'vantis. nomen quad nomen quorum quad', 294, CAST(N'2022-02-01T05:17:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1174, 30, CAST(1852650 AS Decimal(18, 0)), N'bank', N'quo, non parte quartu pars quo brevens,', 198, CAST(N'2022-01-04T11:05:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1175, 30, CAST(797697 AS Decimal(18, 0)), N'bank', N'et quo habitatio quad Quad', 192, CAST(N'2022-04-27T17:44:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1176, 36, CAST(1189464 AS Decimal(18, 0)), N'cash', N'Versus et vantis. novum Sed', 307, CAST(N'2022-06-06T12:41:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1177, 31, CAST(1144055 AS Decimal(18, 0)), N'cash', N'egreddior nomen plorum regit,', 218, CAST(N'2021-09-12T07:16:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1178, 36, CAST(1296550 AS Decimal(18, 0)), N'cash', N'glavans et dolorum non Quad', 314, CAST(N'2021-09-26T03:03:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1179, 32, CAST(1285675 AS Decimal(18, 0)), N'bank', N'Versus quad egreddior', 225, CAST(N'2022-03-12T05:29:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1180, 34, CAST(1071188 AS Decimal(18, 0)), N'cash', N'e si e quis Longam, bono', 267, CAST(N'2022-10-12T10:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1181, 33, CAST(739592 AS Decimal(18, 0)), N'cash', N'rarendum fecit. nomen', 244, CAST(N'2021-11-21T18:36:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1182, 30, CAST(342982 AS Decimal(18, 0)), N'bank', N'dolorum eudis fecit,', 191, CAST(N'2022-08-31T23:03:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1183, 31, CAST(85477 AS Decimal(18, 0)), N'cash', N'gravis delerium. fecit, plurissimum', 219, CAST(N'2021-12-13T20:03:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1184, 34, CAST(1964047 AS Decimal(18, 0)), N'cash', N'in quartu parte gravum', 264, CAST(N'2022-08-07T10:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1185, 30, CAST(1592300 AS Decimal(18, 0)), N'bank', N'Longam, e vobis vobis rarendum sed brevens, Quad', 195, CAST(N'2021-07-04T05:03:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1186, 34, CAST(57049 AS Decimal(18, 0)), N'cash', N'quo plorum Sed apparens vantis.', 269, CAST(N'2021-11-29T11:58:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1187, 33, CAST(228850 AS Decimal(18, 0)), N'bank', N'in eudis manifestum essit. quorum', 247, CAST(N'2022-04-08T15:24:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1188, 32, CAST(1480947 AS Decimal(18, 0)), N'cash', N'linguens gravis quantare', 233, CAST(N'2021-07-14T00:29:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1189, 36, CAST(329225 AS Decimal(18, 0)), N'cash', N'habitatio et si quad ut Multum nomen', 304, CAST(N'2022-08-26T17:01:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1190, 32, CAST(356427 AS Decimal(18, 0)), N'bank', N'regit, et quartu quad essit. essit.', 226, CAST(N'2022-08-17T11:31:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1191, 28, CAST(1392062 AS Decimal(18, 0)), N'cash', N'Pro gravis in habitatio', 154, CAST(N'2022-09-07T00:04:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1192, 28, CAST(1653725 AS Decimal(18, 0)), N'cash', N'gravis gravis gravis', 167, CAST(N'2021-07-29T09:31:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1193, 34, CAST(737805 AS Decimal(18, 0)), N'cash', N'fecit, estum. e non gravis', 272, CAST(N'2022-04-17T17:38:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1194, 28, CAST(79606 AS Decimal(18, 0)), N'bank', N'quantare novum egreddior', 158, CAST(N'2021-07-06T23:02:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1195, 33, CAST(807623 AS Decimal(18, 0)), N'bank', N'si novum quo e si e manifestum', 253, CAST(N'2021-10-08T20:28:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1196, 34, CAST(1227274 AS Decimal(18, 0)), N'bank', N'fecit, in travissimantor', 263, CAST(N'2021-07-12T03:57:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1197, 37, CAST(987975 AS Decimal(18, 0)), N'cash', N'nomen quorum novum nomen si estum.', 325, CAST(N'2022-10-20T05:36:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1198, 32, CAST(89966 AS Decimal(18, 0)), N'cash', N'in et sed quoque Sed Et pladior', 231, CAST(N'2022-03-26T09:13:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1199, 29, CAST(63008 AS Decimal(18, 0)), N'bank', N'Quad si quartu linguens', 173, CAST(N'2022-04-22T13:52:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1200, 32, CAST(617593 AS Decimal(18, 0)), N'cash', N'volcans vobis Quad non quad', 234, CAST(N'2022-11-02T00:57:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1201, 32, CAST(1879672 AS Decimal(18, 0)), N'cash', N'quantare gravis manifestum in et', 240, CAST(N'2021-10-20T20:04:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1202, 33, CAST(1210456 AS Decimal(18, 0)), N'bank', N'plorum Versus transit.', 246, CAST(N'2021-10-19T09:12:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1203, 33, CAST(1668258 AS Decimal(18, 0)), N'cash', N'Et dolorum nomen linguens venit. estum. novum', 255, CAST(N'2021-08-30T06:49:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1204, 29, CAST(1707006 AS Decimal(18, 0)), N'cash', N'et ut rarendum pars Tam Versus', 185, CAST(N'2022-08-08T10:37:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1205, 32, CAST(244402 AS Decimal(18, 0)), N'cash', N'quad in cognitio, plorum', 235, CAST(N'2021-10-15T14:35:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1206, 31, CAST(1594291 AS Decimal(18, 0)), N'cash', N'plurissimum quo, imaginator', 214, CAST(N'2021-08-05T23:22:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1207, 28, CAST(1306055 AS Decimal(18, 0)), N'cash', N'pladior si brevens, plorum', 162, CAST(N'2021-07-28T11:49:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1208, 11, CAST(230000 AS Decimal(18, 0)), N'cash', N'Về quê', 11, CAST(N'2022-08-08T14:36:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1209, 11, CAST(230000 AS Decimal(18, 0)), N'cash', N'Dự án', 13, CAST(N'2022-09-05T14:43:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1210, 11, CAST(2300000 AS Decimal(18, 0)), N'cash', N'Thu nợ của A', 16, CAST(N'2022-11-07T14:43:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1211, 11, CAST(230000 AS Decimal(18, 0)), N'cash', N'di choi', 370, CAST(N'2022-11-07T14:46:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1212, 11, CAST(11000 AS Decimal(18, 0)), N'cash', N'Đổ xăng', 3, CAST(N'2022-11-07T14:46:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1213, 11, CAST(230000 AS Decimal(18, 0)), N'cash', N'tien mang wifi', 4, CAST(N'2022-11-01T14:46:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1214, 11, CAST(23423 AS Decimal(18, 0)), N'cash', N'test', 1, CAST(N'2022-11-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1215, 11, CAST(5645345 AS Decimal(18, 0)), N'bank', N'test', 3, CAST(N'2022-10-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1216, 11, CAST(345342 AS Decimal(18, 0)), N'bank', N'test', 5, CAST(N'2022-09-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1217, 11, CAST(345342 AS Decimal(18, 0)), N'cash', N'test', 2, CAST(N'2022-11-02T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1218, 11, CAST(234343 AS Decimal(18, 0)), N'bank', N'test', 8, CAST(N'2022-11-05T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1219, 11, CAST(10000 AS Decimal(18, 0)), N'cash', N'test', 145, CAST(N'2022-10-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1220, 11, CAST(3452 AS Decimal(18, 0)), N'cash', N'sdfsd', 11, CAST(N'2022-02-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1221, 11, CAST(34522 AS Decimal(18, 0)), N'bank', N'cxver', 13, CAST(N'2022-03-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1222, 11, CAST(42453 AS Decimal(18, 0)), N'bank', N'ertf', 15, CAST(N'2022-07-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1223, 11, CAST(345343 AS Decimal(18, 0)), N'cash', N'sdfrgv', 12, CAST(N'2022-02-11T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1224, 11, CAST(345645 AS Decimal(18, 0)), N'bank', N'xcvxcre', 370, CAST(N'2022-11-05T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1225, 11, CAST(34242 AS Decimal(18, 0)), N'cash', N'esfdsfs', 5, CAST(N'2022-10-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1226, 11, CAST(28181 AS Decimal(18, 0)), N'bank', N'cvxcvxc', 10, CAST(N'2022-02-02T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1227, 11, CAST(3959989 AS Decimal(18, 0)), N'bank', N'awdad', 11, CAST(N'2022-03-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1228, 11, CAST(345345 AS Decimal(18, 0)), N'cash', N'sdfsd', 12, CAST(N'2022-02-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1229, 11, CAST(112000 AS Decimal(18, 0)), N'bank', N'hoa hong', 11, CAST(N'2022-08-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1230, 11, CAST(120000 AS Decimal(18, 0)), N'cash', N'asjdbajsbd', 370, CAST(N'2022-11-07T15:06:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1231, 11, CAST(112000 AS Decimal(18, 0)), N'cash', N'an nuong', 1, CAST(N'2022-01-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1232, 11, CAST(360000 AS Decimal(18, 0)), N'bank', N've que', 12, CAST(N'2022-01-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1233, 11, CAST(23000 AS Decimal(18, 0)), N'cash', N'mua quan ao tet', 1, CAST(N'2022-02-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1234, 11, CAST(233000 AS Decimal(18, 0)), N'cash', N'luong ve', 12, CAST(N'2022-02-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1235, 11, CAST(230121 AS Decimal(18, 0)), N'cash', N'do xang', 3, CAST(N'2022-03-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1236, 11, CAST(230121 AS Decimal(18, 0)), N'cash', N'blabla', 14, CAST(N'2022-03-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1237, 11, CAST(23423 AS Decimal(18, 0)), N'cash', N'an ewer', 8, CAST(N'2022-06-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1238, 11, CAST(2342342 AS Decimal(18, 0)), N'bank', N've xvx', 15, CAST(N'2022-06-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1239, 11, CAST(234235 AS Decimal(18, 0)), N'cash', N'mua wer ao tet', 7, CAST(N'2022-05-07T00:00:00' AS SmallDateTime))
GO
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1240, 11, CAST(23111 AS Decimal(18, 0)), N'cash', N'luong ve', 16, CAST(N'2022-05-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1241, 11, CAST(234232 AS Decimal(18, 0)), N'cash', N'do sdf', 4, CAST(N'2022-04-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1242, 11, CAST(451230 AS Decimal(18, 0)), N'cash', N'blabla', 12, CAST(N'2022-04-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1243, 11, CAST(435345 AS Decimal(18, 0)), N'cash', N'fwefw ewer', 5, CAST(N'2022-08-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1244, 11, CAST(12312 AS Decimal(18, 0)), N'bank', N'srsds xvx', 12, CAST(N'2022-08-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1245, 11, CAST(23421 AS Decimal(18, 0)), N'bank', N'ergerg wer ao tet', 7, CAST(N'2022-09-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1246, 11, CAST(43534 AS Decimal(18, 0)), N'cash', N'zczxc ve', 13, CAST(N'2022-09-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1247, 11, CAST(43536 AS Decimal(18, 0)), N'bank', N'werwe sdf', 2, CAST(N'2022-10-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1248, 11, CAST(23433 AS Decimal(18, 0)), N'cash', N'blabla', 14, CAST(N'2022-10-07T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1249, 40, CAST(130000 AS Decimal(18, 0)), N'cash', N'Đi về quê', 381, CAST(N'2022-11-07T15:23:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1250, 40, CAST(350000 AS Decimal(18, 0)), N'cash', N'ádas', 381, CAST(N'2022-11-07T15:23:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1251, 40, CAST(250000 AS Decimal(18, 0)), N'cash', N'sdad', 382, CAST(N'2022-11-07T15:23:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1252, 40, CAST(3500000 AS Decimal(18, 0)), N'cash', N'asdasd', 383, CAST(N'2022-11-07T15:26:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1253, 40, CAST(2500000 AS Decimal(18, 0)), N'bank', N'dada', 387, CAST(N'2022-11-07T15:26:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1254, 40, CAST(4000000 AS Decimal(18, 0)), N'bank', N'adasas', 390, CAST(N'2022-11-07T15:26:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1255, 11, CAST(234234 AS Decimal(18, 0)), N'bank', N'asdasa sdasd wqwe', 1, CAST(N'2021-05-01T00:00:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1256, 11, CAST(50000000 AS Decimal(18, 0)), N'cash', N'nạp tiền', 18, CAST(N'2022-11-09T14:38:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1257, 11, CAST(100000000 AS Decimal(18, 0)), N'bank', N'nạp tiền vào tài khoản', 18, CAST(N'2022-11-09T14:38:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1258, 11, CAST(50000000 AS Decimal(18, 0)), N'bank', N'nap tien', 18, CAST(N'2022-11-09T14:41:00' AS SmallDateTime))
INSERT [dbo].[Transaction] ([id], [user_id], [moneyNum], [cashOrBank], [moneyContent], [moneyType], [dateUse]) VALUES (1259, 11, CAST(50000000 AS Decimal(18, 0)), N'bank', N'nap tiennnn', 18, CAST(N'2022-11-09T14:43:00' AS SmallDateTime))
SET IDENTITY_INSERT [dbo].[Transaction] OFF
GO
SET IDENTITY_INSERT [dbo].[Type] ON 

INSERT [dbo].[Type] ([id], [name], [description], [category]) VALUES (1, N'Ăn uống', NULL, N'expense')
INSERT [dbo].[Type] ([id], [name], [description], [category]) VALUES (3, N'Quần áo', NULL, N'expense')
INSERT [dbo].[Type] ([id], [name], [description], [category]) VALUES (4, N'Đi lại', NULL, N'expense')
INSERT [dbo].[Type] ([id], [name], [description], [category]) VALUES (5, N'Internet', NULL, N'expense')
INSERT [dbo].[Type] ([id], [name], [description], [category]) VALUES (6, N'Tiền nhà', NULL, N'expense')
INSERT [dbo].[Type] ([id], [name], [description], [category]) VALUES (7, N'Giáo dục', NULL, N'expense')
INSERT [dbo].[Type] ([id], [name], [description], [category]) VALUES (8, N'Y tế', NULL, N'expense')
INSERT [dbo].[Type] ([id], [name], [description], [category]) VALUES (9, N'Hiếu hỉ', NULL, N'expense')
INSERT [dbo].[Type] ([id], [name], [description], [category]) VALUES (10, N'Giải trí', NULL, N'expense')
INSERT [dbo].[Type] ([id], [name], [description], [category]) VALUES (11, N'Khác', NULL, N'expense')
INSERT [dbo].[Type] ([id], [name], [description], [category]) VALUES (12, N'Mẹ cho', NULL, N'income')
INSERT [dbo].[Type] ([id], [name], [description], [category]) VALUES (13, N'Tiền lương', NULL, N'income')
INSERT [dbo].[Type] ([id], [name], [description], [category]) VALUES (14, N'Tiền thưởng', NULL, N'income')
INSERT [dbo].[Type] ([id], [name], [description], [category]) VALUES (15, N'Đầu tư', NULL, N'income')
INSERT [dbo].[Type] ([id], [name], [description], [category]) VALUES (16, N'Lợi nhuận', NULL, N'income')
INSERT [dbo].[Type] ([id], [name], [description], [category]) VALUES (17, N'Thu lãi', NULL, N'income')
INSERT [dbo].[Type] ([id], [name], [description], [category]) VALUES (18, N'Cho thuê', NULL, N'income')
INSERT [dbo].[Type] ([id], [name], [description], [category]) VALUES (19, N'Stock', NULL, N'income')
SET IDENTITY_INSERT [dbo].[Type] OFF
GO
SET IDENTITY_INSERT [dbo].[TypeOfUsers] ON 

INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (1, 11, N'Ăn uống', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (2, 11, N'Quần áo', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (3, 11, N'Đi lại', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (4, 11, N'Internet', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (5, 11, N'Tiền nhà', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (6, 11, N'Giáo dục', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (7, 11, N'Y tế', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (8, 11, N'Hiếu hỉ', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (9, 11, N'Giải trí', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (10, 11, N'Khác', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (11, 11, N'Mẹ cho', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (12, 11, N'Tiền lương', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (13, 11, N'Tiền thưởng', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (14, 11, N'Đầu tư', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (15, 11, N'Lợi nhuận', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (16, 11, N'Thu lãi', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (17, 11, N'Cho thuê', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (18, 11, N'Stock', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (19, 12, N'Ăn uống', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (20, 12, N'Quần áo', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (21, 12, N'Đi lại', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (22, 12, N'Internet', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (23, 12, N'Tiền nhà', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (24, 12, N'Giáo dục', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (25, 12, N'Y tế', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (26, 12, N'Hiếu hỉ', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (27, 12, N'Giải trí', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (28, 12, N'Khác', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (29, 12, N'Mẹ cho', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (30, 12, N'Tiền lương', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (31, 12, N'Tiền thưởng', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (32, 12, N'Đầu tư', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (33, 12, N'Lợi nhuận', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (34, 12, N'Thu lãi', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (35, 12, N'Cho thuê', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (36, 12, N'Stock', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (37, 1, N'Ăn uống', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (38, 1, N'Quần áo', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (39, 1, N'Đi lại', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (40, 1, N'Internet', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (41, 1, N'Tiền nhà', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (42, 1, N'Giáo dục', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (43, 1, N'Y tế', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (44, 1, N'Hiếu hỉ', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (45, 1, N'Giải trí', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (46, 1, N'Khác', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (47, 1, N'Mẹ cho', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (48, 1, N'Tiền lương', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (49, 1, N'Tiền thưởng', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (50, 1, N'Đầu tư', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (51, 1, N'Lợi nhuận', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (52, 1, N'Thu lãi', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (53, 1, N'Cho thuê', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (54, 1, N'Stock', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (55, 9, N'Ăn uống', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (56, 9, N'Quần áo', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (57, 9, N'Đi lại', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (58, 9, N'Internet', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (59, 9, N'Tiền nhà', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (60, 9, N'Giáo dục', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (61, 9, N'Y tế', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (62, 9, N'Hiếu hỉ', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (63, 9, N'Giải trí', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (64, 9, N'Khác', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (65, 9, N'Mẹ cho', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (66, 9, N'Tiền lương', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (67, 9, N'Tiền thưởng', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (68, 9, N'Đầu tư', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (69, 9, N'Lợi nhuận', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (70, 9, N'Thu lãi', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (71, 9, N'Cho thuê', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (72, 9, N'Stock', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (73, 12, N'Ăn uống', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (74, 12, N'Quần áo', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (75, 12, N'Đi lại', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (76, 12, N'Internet', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (77, 12, N'Tiền nhà', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (78, 12, N'Giáo dục', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (79, 12, N'Y tế', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (80, 12, N'Hiếu hỉ', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (81, 12, N'Giải trí', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (82, 12, N'Khác', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (83, 12, N'Mẹ cho', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (84, 12, N'Tiền lương', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (85, 12, N'Tiền thưởng', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (86, 12, N'Đầu tư', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (87, 12, N'Lợi nhuận', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (88, 12, N'Thu lãi', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (89, 12, N'Cho thuê', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (90, 12, N'Stock', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (91, 12, N'Ăn uống', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (92, 12, N'Quần áo', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (93, 12, N'Đi lại', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (94, 12, N'Internet', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (95, 12, N'Tiền nhà', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (96, 12, N'Giáo dục', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (97, 12, N'Y tế', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (98, 12, N'Hiếu hỉ', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (99, 12, N'Giải trí', NULL, N'expense')
GO
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (100, 12, N'Khác', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (101, 12, N'Mẹ cho', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (102, 12, N'Tiền lương', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (103, 12, N'Tiền thưởng', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (104, 12, N'Đầu tư', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (105, 12, N'Lợi nhuận', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (106, 12, N'Thu lãi', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (107, 12, N'Cho thuê', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (108, 12, N'Stock', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (109, 9, N'Ăn uống', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (110, 9, N'Quần áo', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (111, 9, N'Đi lại', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (112, 9, N'Internet', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (113, 9, N'Tiền nhà', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (114, 9, N'Giáo dục', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (115, 9, N'Y tế', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (116, 9, N'Hiếu hỉ', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (117, 9, N'Giải trí', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (118, 9, N'Khác', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (119, 9, N'Mẹ cho', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (120, 9, N'Tiền lương', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (121, 9, N'Tiền thưởng', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (122, 9, N'Đầu tư', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (123, 9, N'Lợi nhuận', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (124, 9, N'Thu lãi', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (125, 9, N'Cho thuê', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (126, 9, N'Stock', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (127, 1, N'Ăn uống', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (128, 1, N'Quần áo', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (129, 1, N'Đi lại', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (130, 1, N'Internet', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (131, 1, N'Tiền nhà', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (132, 1, N'Giáo dục', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (133, 1, N'Y tế', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (134, 1, N'Hiếu hỉ', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (135, 1, N'Giải trí', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (136, 1, N'Khác', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (137, 1, N'Mẹ cho', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (138, 1, N'Tiền lương', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (139, 1, N'Tiền thưởng', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (140, 1, N'Đầu tư', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (141, 1, N'Lợi nhuận', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (142, 1, N'Thu lãi', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (143, 1, N'Cho thuê', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (144, 1, N'Stock', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (145, 11, N'test', N'test', N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (152, 11, N'tiền thuế', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (153, 28, N'Ăn uống', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (154, 28, N'Quần áo', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (155, 28, N'Đi lại', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (156, 28, N'Internet', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (157, 28, N'Tiền nhà', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (158, 28, N'Giáo dục', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (159, 28, N'Y tế', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (160, 28, N'Hiếu hỉ', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (161, 28, N'Giải trí', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (162, 28, N'Khác', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (163, 28, N'Mẹ cho', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (164, 28, N'Tiền lương', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (165, 28, N'Tiền thưởng', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (166, 28, N'Đầu tư', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (167, 28, N'Lợi nhuận', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (168, 28, N'Thu lãi', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (169, 28, N'Cho thuê', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (170, 28, N'Stock', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (171, 29, N'Ăn uống', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (172, 29, N'Quần áo', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (173, 29, N'Đi lại', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (174, 29, N'Internet', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (175, 29, N'Tiền nhà', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (176, 29, N'Giáo dục', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (177, 29, N'Y tế', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (178, 29, N'Hiếu hỉ', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (179, 29, N'Giải trí', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (180, 29, N'Khác', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (181, 29, N'Mẹ cho', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (182, 29, N'Tiền lương', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (183, 29, N'Tiền thưởng', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (184, 29, N'Đầu tư', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (185, 29, N'Lợi nhuận', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (186, 29, N'Thu lãi', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (187, 29, N'Cho thuê', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (188, 29, N'Stock', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (189, 30, N'Ăn uống', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (190, 30, N'Quần áo', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (191, 30, N'Đi lại', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (192, 30, N'Internet', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (193, 30, N'Tiền nhà', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (194, 30, N'Giáo dục', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (195, 30, N'Y tế', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (196, 30, N'Hiếu hỉ', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (197, 30, N'Giải trí', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (198, 30, N'Khác', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (199, 30, N'Mẹ cho', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (200, 30, N'Tiền lương', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (201, 30, N'Tiền thưởng', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (202, 30, N'Đầu tư', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (203, 30, N'Lợi nhuận', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (204, 30, N'Thu lãi', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (205, 30, N'Cho thuê', NULL, N'income')
GO
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (206, 30, N'Stock', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (207, 31, N'Ăn uống', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (208, 31, N'Quần áo', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (209, 31, N'Đi lại', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (210, 31, N'Internet', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (211, 31, N'Tiền nhà', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (212, 31, N'Giáo dục', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (213, 31, N'Y tế', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (214, 31, N'Hiếu hỉ', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (215, 31, N'Giải trí', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (216, 31, N'Khác', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (217, 31, N'Mẹ cho', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (218, 31, N'Tiền lương', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (219, 31, N'Tiền thưởng', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (220, 31, N'Đầu tư', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (221, 31, N'Lợi nhuận', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (222, 31, N'Thu lãi', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (223, 31, N'Cho thuê', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (224, 31, N'Stock', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (225, 32, N'Ăn uống', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (226, 32, N'Quần áo', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (227, 32, N'Đi lại', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (228, 32, N'Internet', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (229, 32, N'Tiền nhà', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (230, 32, N'Giáo dục', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (231, 32, N'Y tế', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (232, 32, N'Hiếu hỉ', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (233, 32, N'Giải trí', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (234, 32, N'Khác', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (235, 32, N'Mẹ cho', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (236, 32, N'Tiền lương', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (237, 32, N'Tiền thưởng', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (238, 32, N'Đầu tư', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (239, 32, N'Lợi nhuận', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (240, 32, N'Thu lãi', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (241, 32, N'Cho thuê', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (242, 32, N'Stock', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (243, 33, N'Ăn uống', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (244, 33, N'Quần áo', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (245, 33, N'Đi lại', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (246, 33, N'Internet', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (247, 33, N'Tiền nhà', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (248, 33, N'Giáo dục', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (249, 33, N'Y tế', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (250, 33, N'Hiếu hỉ', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (251, 33, N'Giải trí', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (252, 33, N'Khác', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (253, 33, N'Mẹ cho', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (254, 33, N'Tiền lương', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (255, 33, N'Tiền thưởng', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (256, 33, N'Đầu tư', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (257, 33, N'Lợi nhuận', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (258, 33, N'Thu lãi', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (259, 33, N'Cho thuê', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (260, 33, N'Stock', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (261, 34, N'Ăn uống', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (262, 34, N'Quần áo', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (263, 34, N'Đi lại', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (264, 34, N'Internet', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (265, 34, N'Tiền nhà', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (266, 34, N'Giáo dục', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (267, 34, N'Y tế', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (268, 34, N'Hiếu hỉ', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (269, 34, N'Giải trí', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (270, 34, N'Khác', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (271, 34, N'Mẹ cho', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (272, 34, N'Tiền lương', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (273, 34, N'Tiền thưởng', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (274, 34, N'Đầu tư', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (275, 34, N'Lợi nhuận', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (276, 34, N'Thu lãi', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (277, 34, N'Cho thuê', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (278, 34, N'Stock', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (279, 35, N'Ăn uống', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (280, 35, N'Quần áo', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (281, 35, N'Đi lại', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (282, 35, N'Internet', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (283, 35, N'Tiền nhà', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (284, 35, N'Giáo dục', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (285, 35, N'Y tế', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (286, 35, N'Hiếu hỉ', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (287, 35, N'Giải trí', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (288, 35, N'Khác', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (289, 35, N'Mẹ cho', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (290, 35, N'Tiền lương', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (291, 35, N'Tiền thưởng', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (292, 35, N'Đầu tư', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (293, 35, N'Lợi nhuận', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (294, 35, N'Thu lãi', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (295, 35, N'Cho thuê', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (296, 35, N'Stock', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (297, 36, N'Ăn uống', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (298, 36, N'Quần áo', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (299, 36, N'Đi lại', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (300, 36, N'Internet', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (301, 36, N'Tiền nhà', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (302, 36, N'Giáo dục', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (303, 36, N'Y tế', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (304, 36, N'Hiếu hỉ', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (305, 36, N'Giải trí', NULL, N'expense')
GO
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (306, 36, N'Khác', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (307, 36, N'Mẹ cho', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (308, 36, N'Tiền lương', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (309, 36, N'Tiền thưởng', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (310, 36, N'Đầu tư', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (311, 36, N'Lợi nhuận', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (312, 36, N'Thu lãi', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (313, 36, N'Cho thuê', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (314, 36, N'Stock', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (315, 37, N'Ăn uống', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (316, 37, N'Quần áo', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (317, 37, N'Đi lại', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (318, 37, N'Internet', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (319, 37, N'Tiền nhà', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (320, 37, N'Giáo dục', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (321, 37, N'Y tế', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (322, 37, N'Hiếu hỉ', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (323, 37, N'Giải trí', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (324, 37, N'Khác', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (325, 37, N'Mẹ cho', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (326, 37, N'Tiền lương', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (327, 37, N'Tiền thưởng', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (328, 37, N'Đầu tư', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (329, 37, N'Lợi nhuận', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (330, 37, N'Thu lãi', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (331, 37, N'Cho thuê', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (332, 37, N'Stock', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (333, 38, N'Ăn uống', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (334, 38, N'Quần áo', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (335, 38, N'Đi lại', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (336, 38, N'Internet', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (337, 38, N'Tiền nhà', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (338, 38, N'Giáo dục', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (339, 38, N'Y tế', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (340, 38, N'Hiếu hỉ', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (341, 38, N'Giải trí', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (342, 38, N'Khác', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (343, 38, N'Mẹ cho', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (344, 38, N'Tiền lương', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (345, 38, N'Tiền thưởng', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (346, 38, N'Đầu tư', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (347, 38, N'Lợi nhuận', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (348, 38, N'Thu lãi', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (349, 38, N'Cho thuê', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (350, 38, N'Stock', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (351, 39, N'Ăn uống', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (352, 39, N'Quần áo', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (353, 39, N'Đi lại', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (354, 39, N'Internet', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (355, 39, N'Tiền nhà', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (356, 39, N'Giáo dục', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (357, 39, N'Y tế', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (358, 39, N'Hiếu hỉ', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (359, 39, N'Giải trí', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (360, 39, N'Khác', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (361, 39, N'Mẹ cho', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (362, 39, N'Tiền lương', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (363, 39, N'Tiền thưởng', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (364, 39, N'Đầu tư', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (365, 39, N'Lợi nhuận', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (366, 39, N'Thu lãi', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (367, 39, N'Cho thuê', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (368, 39, N'Stock', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (369, 39, N'Ny', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (370, 11, N'ny', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (371, 40, N'Ăn uống', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (372, 40, N'Quần áo', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (373, 40, N'Đi lại', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (374, 40, N'Internet', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (375, 40, N'Tiền nhà', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (376, 40, N'Giáo dục', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (377, 40, N'Y tế', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (378, 40, N'Hiếu hỉ', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (379, 40, N'Giải trí', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (380, 40, N'Khác', NULL, N'expense')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (381, 40, N'Mẹ cho', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (382, 40, N'Tiền lương', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (383, 40, N'Tiền thưởng', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (384, 40, N'Đầu tư', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (385, 40, N'Lợi nhuận', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (386, 40, N'Thu lãi', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (387, 40, N'Cho thuê', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (388, 40, N'Stock', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (389, 40, N'ny', NULL, N'income')
INSERT [dbo].[TypeOfUsers] ([id], [user_id], [name], [description], [category]) VALUES (390, 40, N'ny2', NULL, N'expense')
SET IDENTITY_INSERT [dbo].[TypeOfUsers] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (1, N'oaipbhe', N'abc123', N'Phạm Bá Oai', N'0838802571', N'oaipbhe150516@fpt.edu.vn', N'male', N'Vietnam')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (2, N'oaideptrai', N'abc123', N'Pham Oai', N'', N'', N'other', N'')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (3, N'asda', N'abc123', N'Ba Oai', N'', N'', N'other', N'')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (4, N'asbc', N'qweqwe', N'jkasdjkashd', N'', N'', N'other', N'')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (5, N'sdfsdf', N'eqweqweqw', N'zxcvzc sd', N'', N'', N'other', N'')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (6, N'qweqw', N'asdfg', N's czxczx ', N'', N'', N'other', N'')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (7, N'werwe', N'abc123', N'sdas dasd', N'', N'', N'other', N'')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (8, N'zxczxc', N'123', N'scz xcz ', N'', N'', N'other', N'')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (9, N'oaidep', N'123', N'pham ba oai', N'', N'', N'male', N'')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (10, N'oai', N'123', N'pham ba oai', N'', N'', N'male', N'')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (11, N'oaiba', N'123', N'pham ba oai', N'0812123432', N'', N'male', N'hanoi')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (12, N'Lydia74', N'Carter', N'Jarrod James', N'3811659270', N'roilood.fsxh@hsztqt.org', N'other', N'Romania')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (13, N'Danny711', N'Jeremey', N'Kimberley Faulkner', N'819-586-5613', N'gplf196@cwjhcsppm.neqtxx.com', N'other', N'Andorra')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (14, N'Gavin61', N'Dante', N'Gwendolyn Peck', N'6210613036', N'jhmq.vcjrmugcuf@ylwabc.com', N'male', N'Sweden')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (15, N'Joe', N'Antione', N'Melanie Stevens', N'866011-5290', N'tkumo1@pmhhl.ixcsyk.com', N'female', N'Vatican City')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (16, N'Eric2', N'Carlos', N'Lance Payne', N'541710-2944', N'bcybzi18@iwdfddv.qenqzx.net', N'other', N'Israel')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (17, N'Allison173', N'Paris', N'Alison Boyd', N'4499945005', N'avuizikl1@filz-q.com', N'female', N'Eire')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (18, N'Tracey', N'Lucas', N'Whitney Sims', N'770-8857567', N'youpl.ohcbq@gaalamr.p-wijv.org', N'male', N'Kiribati')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (19, N'Thomas', N'Jefferson', N'Jaime Hines', N'0770245050', N'yhfkb@nnxalb.org', N'female', N'Czech Republic')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (20, N'Dorothy96', N'Leslie', N'Lee Lloyd', N'615-490-5805', N'xclzpq.byutcjalpd@qgz-hx.com', N'other', N'Nicaragua')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (21, N'Jeffrey069', N'Jude', N'Lindsey Ritter', N'336-8314312', N'tudy.ntrsj@g-heyl.org', N'male', N'Niger')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (22, N'oaibadeptrai', N'123', N'pham ba oai', N'', N'qwe@gmail.com', N'male', N'Vietnam')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (23, N'oaiba123', N'123', N'pham ba aoia', N'', N'qwe@gmail.com', N'male', N'Hanoi')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (24, N'oai123', N'123', N'pham ba oai', N'', N'1asd@gmail.com', N'male', N'Hanoi')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (25, N'oai234', N'123', N'pham ba oai', N'', N'1asd@gmail.com', N'male', N'Hanoi')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (26, N'baoai234', N'123', N'pham ba oai', N'', N'1asd@gmail.com', N'male', N'Hanoi')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (27, N'dgdf', N'123', N'pham ba oai', N'', N'oai@gmail.com', N'male', N'Hanoi')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (28, N'phamba', N'123', N'Pham Ba Oai', N'', N'oai@gmail.com', N'male', N'VN')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (29, N'phambaoai', N'123', N'Pham Ba Oai', N'', N'oai@gmail.com', N'male', N'VN')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (30, N'sadasd', N'123', N'hsdhasd asd asd ', N'', N'asd2@gmail.com', N'male', N'HN')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (31, N'erter', N'123', N'dajsh as dasgd ', N'', N'asda@gmail.com', N'male', N'VN')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (32, N'eterte', N'123', N'diofs ad', N'', N'pao@gmail.com', N'male', N'HN')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (33, N'sdfszx', N'123', N'pham ba o', N'', N'123@gmail.com', N'male', N'hn')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (34, N'ryrtyg', N'123', N'fgsdf sf s', N'', N'masd@gmail.com', N'male', N'hn')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (35, N'baoia', N'123', N'sdf sdf', N'', N'opai@g', N'other', N'')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (36, N'qwedf', N'123', N'pham ba oai', N'', N'oai@g', N'other', N'')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (37, N'wersds', N'123', N'sdfsf sfs', N'', N'ewer@d', N'other', N'')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (38, N'xcvr', N'123', N'dgsdf sfw e', N'', N'dad@g', N'other', N'')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (39, N'ewrtxfg', N'123', N'sf sdf xcv', N'', N'dfs@df', N'male', N'36')
INSERT [dbo].[Users] ([id], [username], [password], [fullname], [phone], [email], [gender], [location]) VALUES (40, N'thayTien', N'123', N'asd asd', N'', N'jas@gmail.com', N'male', N'HN')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Money]  WITH CHECK ADD  CONSTRAINT [FK_Money_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Money] CHECK CONSTRAINT [FK_Money_Users]
GO
ALTER TABLE [dbo].[Saving]  WITH CHECK ADD  CONSTRAINT [FK_Saving_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Saving] CHECK CONSTRAINT [FK_Saving_Users]
GO
ALTER TABLE [dbo].[SavingMoney]  WITH CHECK ADD  CONSTRAINT [FK_SavingMoney_Saving] FOREIGN KEY([saving_id], [user_id])
REFERENCES [dbo].[Saving] ([id], [user_id])
GO
ALTER TABLE [dbo].[SavingMoney] CHECK CONSTRAINT [FK_SavingMoney_Saving]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_TypeOfUsers] FOREIGN KEY([moneyType], [user_id])
REFERENCES [dbo].[TypeOfUsers] ([id], [user_id])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_TypeOfUsers]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_Users]
GO
ALTER TABLE [dbo].[TypeOfUsers]  WITH CHECK ADD  CONSTRAINT [FK_TypeOfUsers_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[TypeOfUsers] CHECK CONSTRAINT [FK_TypeOfUsers_Users]
GO
USE [master]
GO
ALTER DATABASE [MoneyWife] SET  READ_WRITE 
GO
