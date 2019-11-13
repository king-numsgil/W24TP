USE master 
GO
if exists(Select database_id from sys.databases
	where name = 'ForumONI')	
BEGIN
	DROP DATABASE ForumONI
	PRINT 'Ancienne BD ForumONI supprimée'
	PRINT '*******************************************************'
END
CREATE DATABASE ForumONI
PRINT 'BD ForumONI créée avec succès'
GO
USE [ForumONI]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 2019-10-23 14:20:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 2019-10-23 14:20:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 2019-10-23 14:20:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 2019-10-23 14:20:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 2019-10-23 14:20:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Categories]    Script Date: 2019-10-23 14:20:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CatID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](20) NULL,
	[IsActive] [bit] NOT NULL,
	[CreationDate] [smalldatetime] NOT NULL,
	[UserID] [nvarchar](128) NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Messages]    Script Date: 2019-10-23 14:20:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[MsgID] [int] IDENTITY(1,1) NOT NULL,
	[MsgTitle] [nvarchar](50) NOT NULL,
	[MsgText] [ntext] NULL,
	[CatID] [int] NOT NULL,
	[UserID] [nvarchar](128) NOT NULL,
	[CreationDate] [smalldatetime] NOT NULL,
	[View] [nchar](10) NULL,
	[IsActive] [bit] DEFAULT 1 NOT NULL,
 CONSTRAINT [PK_Messages] PRIMARY KEY CLUSTERED 
(
	[MsgID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Reponses]    Script Date: 2019-10-23 14:20:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reponses](
	[RepID] [int] IDENTITY(1,1) NOT NULL,
	[RepText] [text] NULL,
	[MsgID] [int] NULL,
	[UserID] [nvarchar](128) NULL,
	[CreationDate] [smalldatetime] NULL,
	[IsActive] [bit] DEFAULT 1 NOT NULL,
 CONSTRAINT [PK_Reponses] PRIMARY KEY CLUSTERED 
(
	[RepID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Categories]  WITH CHECK ADD  CONSTRAINT [FK_Categories_AspNetUsers] FOREIGN KEY([UserID])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Categories] CHECK CONSTRAINT [FK_Categories_AspNetUsers]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_AspNetUsers] FOREIGN KEY([UserID])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_AspNetUsers]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Categories] FOREIGN KEY([CatID])
REFERENCES [dbo].[Categories] ([CatID])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_Categories]
GO
ALTER TABLE [dbo].[Reponses]  WITH CHECK ADD  CONSTRAINT [FK_Reponses_AspNetUsers] FOREIGN KEY([UserID])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Reponses] CHECK CONSTRAINT [FK_Reponses_AspNetUsers]
GO
ALTER TABLE [dbo].[Reponses]  WITH CHECK ADD  CONSTRAINT [FK_Reponses_Messages] FOREIGN KEY([MsgID])
REFERENCES [dbo].[Messages] ([MsgID])
GO
ALTER TABLE [dbo].[Reponses] CHECK CONSTRAINT [FK_Reponses_Messages]
GO
INSERT INTO AspNetUsers (Id, Email, EmailConfirmed, PasswordHash, SecurityStamp, PhoneNumberConfirmed, TwoFactorEnabled, LockoutEnabled, AccessFailedCount, UserName)
VALUES ('9c2e35f8-955c-4d91-989d-b8194d66642c','exerapidoxthorn@gmail.com',0,'AGSqOKCGvF9PBWtV9hcWT+AWIRMr68Stu9f5GaLETSx6r6KsbVl7sbcMuhrMEMjdDg==','977ae531-a732-4517-9e61-b9af4e52e947',0,0,1,0,'SpikyPigeon'),
('6f1a4761-d0d0-4ca9-adce-7ab60af236d7','king@numsgil.co',0,'AINHvlR+mjTZsvHCnjHX1fEuYElHanUeH6u5Ua0LPMHDVEFphi3K/aIiHOvxKjhHjQ==','da2607b6-f79a-424d-9188-98176a742254',0,0,1,0,'numsgil')
GO
INSERT INTO Categories (CategoryName, IsActive, CreationDate, UserID)
VALUES ('Plumbing','true',GETDATE(),'9c2e35f8-955c-4d91-989d-b8194d66642c'),
	   ('Ventilation','true',GETDATE(),'6f1a4761-d0d0-4ca9-adce-7ab60af236d7'),
	   ('Morale', 'true', DATEADD(minute, -2, GETDATE()), '9c2e35f8-955c-4d91-989d-b8194d66642c'),
	   ('Power', 'true', DATEADD(minute, -30, GETDATE()), '6f1a4761-d0d0-4ca9-adce-7ab60af236d7')
GO
INSERT INTO Messages (MsgTitle, MsgText, CatID, UserID, CreationDate)
VALUES ('Cant unblock pipes','So I made a pipe system for my toilets and it says Pipe Blocked but when I put an errand to empty pipes my dupes wonT do anything. What do I do?',1,'9c2e35f8-955c-4d91-989d-b8194d66642c', GETDATE()),
	   ('Pipes keep breaking','kaput help pls',2,'6f1a4761-d0d0-4ca9-adce-7ab60af236d7', DATEADD(minute, -51, GETDATE())),
	   ('pieping sux','dnaliwhncalijndoi idbiwaybhjcnda !!!!!!!! noaiwudhwolianajwudoin. Yep. Thx',2,'9c2e35f8-955c-4d91-989d-b8194d66642c', DATEADD(minute, -5, GETDATE())),
	   ('Too hot, melting','burn',2,'6f1a4761-d0d0-4ca9-adce-7ab60af236d7', DATEADD(minute, -17, GETDATE()))
GO