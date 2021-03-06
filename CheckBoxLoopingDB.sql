USE [master]
GO
/****** Object:  Database [CheckBoxDB]    Script Date: 7/25/2015 1:37:39 AM ******/
CREATE DATABASE [CheckBoxDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CheckBoxDB', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\CheckBoxDB.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CheckBoxDB_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\CheckBoxDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CheckBoxDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CheckBoxDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CheckBoxDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CheckBoxDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CheckBoxDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CheckBoxDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CheckBoxDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [CheckBoxDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CheckBoxDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [CheckBoxDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CheckBoxDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CheckBoxDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CheckBoxDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CheckBoxDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CheckBoxDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CheckBoxDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CheckBoxDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CheckBoxDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CheckBoxDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CheckBoxDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CheckBoxDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CheckBoxDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CheckBoxDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CheckBoxDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CheckBoxDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CheckBoxDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CheckBoxDB] SET  MULTI_USER 
GO
ALTER DATABASE [CheckBoxDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CheckBoxDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CheckBoxDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CheckBoxDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [CheckBoxDB]
GO
/****** Object:  Table [dbo].[tblDealer]    Script Date: 7/25/2015 1:37:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblDealer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](250) NULL,
 CONSTRAINT [PK_tblDealer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDepartment]    Script Date: 7/25/2015 1:37:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblDepartment](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](150) NOT NULL,
 CONSTRAINT [PK_tblDepartment] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblSettingName]    Script Date: 7/25/2015 1:37:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblSettingName](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SettingName] [varchar](150) NOT NULL,
	[DealerId] [int] NOT NULL,
 CONSTRAINT [PK_tblSettingName] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUserAtDealer]    Script Date: 7/25/2015 1:37:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUserAtDealer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserControlId] [varchar](250) NOT NULL,
	[Status] [varchar](150) NULL,
	[SettingNameId] [int] NOT NULL,
 CONSTRAINT [PK_tblUserAtDealer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tblDealer] ON 

INSERT [dbo].[tblDealer] ([ID], [Name]) VALUES (1, N'Hundai Car')
INSERT [dbo].[tblDealer] ([ID], [Name]) VALUES (2, N'Marcedise')
INSERT [dbo].[tblDealer] ([ID], [Name]) VALUES (3, N'Motorola')
SET IDENTITY_INSERT [dbo].[tblDealer] OFF
SET IDENTITY_INSERT [dbo].[tblDepartment] ON 

INSERT [dbo].[tblDepartment] ([ID], [Name]) VALUES (1, N'Sales')
INSERT [dbo].[tblDepartment] ([ID], [Name]) VALUES (2, N'Purchase')
INSERT [dbo].[tblDepartment] ([ID], [Name]) VALUES (3, N'Service')
SET IDENTITY_INSERT [dbo].[tblDepartment] OFF
SET IDENTITY_INSERT [dbo].[tblSettingName] ON 

INSERT [dbo].[tblSettingName] ([ID], [SettingName], [DealerId]) VALUES (1041, N'Sales Manager', 1)
INSERT [dbo].[tblSettingName] ([ID], [SettingName], [DealerId]) VALUES (1042, N'Sales Manager1', 1)
INSERT [dbo].[tblSettingName] ([ID], [SettingName], [DealerId]) VALUES (1043, N'Sales Manager2', 1)
INSERT [dbo].[tblSettingName] ([ID], [SettingName], [DealerId]) VALUES (1044, N'Manager3', 1)
SET IDENTITY_INSERT [dbo].[tblSettingName] OFF
SET IDENTITY_INSERT [dbo].[tblUserAtDealer] ON 

INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1134, N'chkPiShowAll', N'True', 1041)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1135, N'chkPiMakePrivate', N'True', 1041)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1136, N'chkPiAddFirstLeadOnly', N'False', 1041)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1137, N'chkPiMustContactLastEmail', N'False', 1041)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1138, N'chkPiBulkBlock', N'False', 1041)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1139, N'chkPiExportBlock', N'False', 1041)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1140, N'chkAllowAllSales', N'False', 1041)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1141, N'chkPiBlockSalesChange', N'False', 1041)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1142, N'chkPiInvalidBlock', N'False', 1041)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1143, N'chkPiEnableChat', N'False', 1041)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1144, N'chkPiChatManager', N'False', 1041)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1145, N'chkPiToDoManager', N'False', 1041)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1146, N'chkPiTargetManager', N'True', 1041)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1147, N'lstPiHomeType', N'Sales|Sales', 1041)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1148, N'chkPiHomeSelectAllow', N'False', 1041)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1149, N'chkPiHomeVisitsAllow', N'False', 1041)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1150, N'chkPiTrafficDeleteAllow', N'False', 1041)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1151, N'ux_lstDepartments', N'1|Sales', 1041)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1152, N'blockStatusDropDownlist', N'1|Option1', 1041)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1153, N'chkPiShowAll', N'False', 1042)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1154, N'chkPiMakePrivate', N'False', 1042)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1155, N'chkPiAddFirstLeadOnly', N'False', 1042)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1156, N'chkPiMustContactLastEmail', N'False', 1042)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1157, N'chkPiBulkBlock', N'False', 1042)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1158, N'chkPiExportBlock', N'False', 1042)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1159, N'chkAllowAllSales', N'False', 1042)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1160, N'chkPiBlockSalesChange', N'False', 1042)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1161, N'chkPiInvalidBlock', N'False', 1042)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1162, N'chkPiEnableChat', N'False', 1042)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1163, N'chkPiChatManager', N'True', 1042)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1164, N'chkPiToDoManager', N'True', 1042)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1165, N'chkPiTargetManager', N'True', 1042)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1166, N'lstPiHomeType', N'Web|Website', 1042)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1167, N'chkPiHomeSelectAllow', N'True', 1042)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1168, N'chkPiHomeVisitsAllow', N'True', 1042)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1169, N'chkPiTrafficDeleteAllow', N'True', 1042)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1170, N'ux_lstDepartments', N'3|Service', 1042)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1171, N'blockStatusDropDownlist', N'-3|noValue', 1042)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1172, N'chkPiShowAll', N'True', 1043)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1173, N'chkPiMakePrivate', N'True', 1043)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1174, N'chkPiAddFirstLeadOnly', N'False', 1043)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1175, N'chkPiMustContactLastEmail', N'False', 1043)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1176, N'chkPiBulkBlock', N'False', 1043)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1177, N'chkPiExportBlock', N'False', 1043)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1178, N'chkAllowAllSales', N'False', 1043)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1179, N'chkPiBlockSalesChange', N'False', 1043)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1180, N'chkPiInvalidBlock', N'False', 1043)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1181, N'chkPiEnableChat', N'False', 1043)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1182, N'chkPiChatManager', N'True', 1043)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1183, N'chkPiToDoManager', N'True', 1043)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1184, N'chkPiTargetManager', N'True', 1043)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1185, N'lstPiHomeType', N'Web|Website', 1043)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1186, N'chkPiHomeSelectAllow', N'False', 1043)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1187, N'chkPiHomeVisitsAllow', N'True', 1043)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1188, N'chkPiTrafficDeleteAllow', N'False', 1043)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1189, N'ux_lstDepartments', N'1|Sales', 1043)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1190, N'blockStatusDropDownlist', N'2|Option2', 1043)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1191, N'chkPiShowAll', N'True', 1044)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1192, N'chkPiMakePrivate', N'True', 1044)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1193, N'chkPiAddFirstLeadOnly', N'True', 1044)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1194, N'chkPiMustContactLastEmail', N'True', 1044)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1195, N'chkPiBulkBlock', N'True', 1044)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1196, N'chkPiExportBlock', N'True', 1044)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1197, N'chkAllowAllSales', N'True', 1044)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1198, N'chkPiBlockSalesChange', N'True', 1044)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1199, N'chkPiInvalidBlock', N'True', 1044)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1200, N'chkPiEnableChat', N'True', 1044)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1201, N'chkPiChatManager', N'True', 1044)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1202, N'chkPiToDoManager', N'True', 1044)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1203, N'chkPiTargetManager', N'True', 1044)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1204, N'lstPiHomeType', N'Web|Website', 1044)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1205, N'chkPiHomeSelectAllow', N'True', 1044)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1206, N'chkPiHomeVisitsAllow', N'True', 1044)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1207, N'chkPiTrafficDeleteAllow', N'True', 1044)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1208, N'ux_lstDepartments', N'2|Purchase', 1044)
INSERT [dbo].[tblUserAtDealer] ([ID], [UserControlId], [Status], [SettingNameId]) VALUES (1209, N'blockStatusDropDownlist', N'3|Option3', 1044)
SET IDENTITY_INSERT [dbo].[tblUserAtDealer] OFF
USE [master]
GO
ALTER DATABASE [CheckBoxDB] SET  READ_WRITE 
GO
