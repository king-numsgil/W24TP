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
	[View] [int] DEFAULT 0 NOT NULL,
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
	[CreationDate] [smalldatetime] DEFAULT GETDATE() NOT NULL,
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
('6f1a4761-d0d0-4ca9-adce-7ab60af236d7','king@numsgil.co',0,'AINHvlR+mjTZsvHCnjHX1fEuYElHanUeH6u5Ua0LPMHDVEFphi3K/aIiHOvxKjhHjQ==','da2607b6-f79a-424d-9188-98176a742254',0,0,1,0,'numsgil'),
('32c6ec2f-e5ef-43f6-81e8-d29eb4fef454','gargle@hotmail.com',0,'AAUZW/vgQ8UPxkn8rWUTL+DmBYDXfnbaDKhfgIM+9XZoW6O6OSGpYY3yODvsWx0xDQ==','e1c7446e-8b93-4aea-abfe-fddbfcb35761',0,0,1,0,'Mr. Gargle')
GO
INSERT INTO AspNetRoles (Id, Name) VALUES
(1, 'Admin')
GO
INSERT INTO AspNetUserRoles (RoleId, UserId) VALUES
(1, '9c2e35f8-955c-4d91-989d-b8194d66642c'),
(1, '6f1a4761-d0d0-4ca9-adce-7ab60af236d7')
GO
INSERT INTO Categories (CategoryName, IsActive, CreationDate, UserID)
VALUES ('Plumbing','true', DATEADD(minute, -115, GETDATE()),'9c2e35f8-955c-4d91-989d-b8194d66642c'),
	   ('Ventilation','true', GETDATE(),'6f1a4761-d0d0-4ca9-adce-7ab60af236d7'),
	   ('Morale', 'true', DATEADD(minute, -2, GETDATE()), '9c2e35f8-955c-4d91-989d-b8194d66642c'),
	   ('Power', 'true', DATEADD(minute, -30, GETDATE()), '6f1a4761-d0d0-4ca9-adce-7ab60af236d7')
GO
INSERT INTO Messages (MsgTitle, MsgText, CatID, UserID, CreationDate)
VALUES ('Cant unblock pipes','<p>So I made a pipe system for my toilets and it says Pipe Blocked but when I put an errand to empty pipes my dupes wonT do anything. What do I do?</p>',1,'9c2e35f8-955c-4d91-989d-b8194d66642c', DATEADD(minute, -65, GETDATE())),
	   ('Pipes keep breaking','<p>kaput help pls</p>',1,'6f1a4761-d0d0-4ca9-adce-7ab60af236d7', DATEADD(minute, -51, GETDATE())),
	   ('pieping sux','<p>dnaliwhncalijndoi idbiwaybhjcnda !!!!!!!! noaiwudhwolianajwudoin. Yep. Thx</p>',1,'9c2e35f8-955c-4d91-989d-b8194d66642c', DATEADD(minute, -5, GETDATE())),
	   ('Too hot, melting','<p>burn</p>',1,'6f1a4761-d0d0-4ca9-adce-7ab60af236d7', DATEADD(minute, -17, GETDATE()))
GO
INSERT INTO Reponses (RepText, MsgID, UserID, CreationDate)
VALUES ('<p>Does any of your dupes have the Plumber skill? This might be your problem</p>', 1, '6f1a4761-d0d0-4ca9-adce-7ab60af236d7', DATEADD(minute, -30, GETDATE())),
	   ('<p>git gud</p>', 2, '32c6ec2f-e5ef-43f6-81e8-d29eb4fef454', DATEADD(minute, -1, GETDATE())),
	   ('<p>No I didnt have any, it works now. Thanks!</p>', 1, '9c2e35f8-955c-4d91-989d-b8194d66642c', DATEADD(minute, -25, GETDATE())),
	   ('<p>SPAM</p>', 1, '9c2e35f8-955c-4d91-989d-b8194d66642c', DATEADD(minute, -24, GETDATE())),
	   ('<p>SPAM</p>', 1, '32c6ec2f-e5ef-43f6-81e8-d29eb4fef454', DATEADD(minute, -23, GETDATE())),
	   ('<p>SPAM</p>', 1, '32c6ec2f-e5ef-43f6-81e8-d29eb4fef454', DATEADD(minute, -22, GETDATE())),
	   ('<p>SPAM</p>', 1, '32c6ec2f-e5ef-43f6-81e8-d29eb4fef454', DATEADD(minute, -21, GETDATE())),
	   ('<p>SPAM</p>', 1, '32c6ec2f-e5ef-43f6-81e8-d29eb4fef454', DATEADD(minute, -20, GETDATE())),
	   ('<p>SPAM</p>', 1, '32c6ec2f-e5ef-43f6-81e8-d29eb4fef454', DATEADD(minute, -19, GETDATE())),
	   ('<p>SPAM</p>', 1, '32c6ec2f-e5ef-43f6-81e8-d29eb4fef454', DATEADD(minute, -18, GETDATE())),
	   ('<p>SPAM</p>', 1, '32c6ec2f-e5ef-43f6-81e8-d29eb4fef454', DATEADD(minute, -17, GETDATE())),
	   ('<p>SPAM</p>', 1, '32c6ec2f-e5ef-43f6-81e8-d29eb4fef454', DATEADD(minute, -16, GETDATE())),
	   ('<p>SPAM</p>', 1, '32c6ec2f-e5ef-43f6-81e8-d29eb4fef454', DATEADD(minute, -15, GETDATE())),
	   ('<p>SPAM</p>', 1, '32c6ec2f-e5ef-43f6-81e8-d29eb4fef454', DATEADD(minute, -14, GETDATE())),
	   ('<p>SPAM</p>', 1, '32c6ec2f-e5ef-43f6-81e8-d29eb4fef454', DATEADD(minute, -13, GETDATE())),
	   ('<p>SPAM</p>', 1, '32c6ec2f-e5ef-43f6-81e8-d29eb4fef454', DATEADD(minute, -12, GETDATE())),
	   ('<p>SPAM</p>', 1, '32c6ec2f-e5ef-43f6-81e8-d29eb4fef454', DATEADD(minute, -11, GETDATE())),
	   ('<p>SPAM</p>', 1, '32c6ec2f-e5ef-43f6-81e8-d29eb4fef454', DATEADD(minute, -10, GETDATE())),
	   ('<p>SPAM</p>', 1, '32c6ec2f-e5ef-43f6-81e8-d29eb4fef454', DATEADD(minute, -9, GETDATE())),
	   ('<p>SPAM</p>', 1, '32c6ec2f-e5ef-43f6-81e8-d29eb4fef454', DATEADD(minute, -8, GETDATE())),
	   ('<p>SPAM</p>', 1, '32c6ec2f-e5ef-43f6-81e8-d29eb4fef454', DATEADD(minute, -7, GETDATE())),
	   ('<p>SPAM</p>', 1, '32c6ec2f-e5ef-43f6-81e8-d29eb4fef454', DATEADD(minute, -6, GETDATE()))
GO