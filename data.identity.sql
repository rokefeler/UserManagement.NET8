/*
 Navicat Premium Data Transfer

 Source Server         : sqlserver local
 Source Server Type    : SQL Server
 Source Server Version : 15002120
 Source Host           : DEV:1433
 Source Catalog        : UserManagementFullStackDB
 Source Schema         : Identity

 Target Server Type    : SQL Server
 Target Server Version : 15002120
 File Encoding         : 65001

 Date: 19/09/2024 23:33:36
*/


-- ----------------------------
-- Table structure for RoleClaims
-- ----------------------------
CREATE TABLE [Identity].[RoleClaims] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [RoleId] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [ClaimType] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NULL,
  [ClaimValue] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NULL
)
GO

ALTER TABLE [Identity].[RoleClaims] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of RoleClaims
-- ----------------------------
BEGIN TRANSACTION
GO

SET IDENTITY_INSERT [Identity].[RoleClaims] ON
GO

SET IDENTITY_INSERT [Identity].[RoleClaims] OFF
GO

COMMIT
GO


-- ----------------------------
-- Table structure for Roles
-- ----------------------------
CREATE TABLE [Identity].[Roles] (
  [Id] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [Name] nvarchar(256) COLLATE Modern_Spanish_CI_AS  NULL,
  [NormalizedName] nvarchar(256) COLLATE Modern_Spanish_CI_AS  NULL,
  [ConcurrencyStamp] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NULL
)
GO

ALTER TABLE [Identity].[Roles] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of Roles
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [Identity].[Roles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'3ef2558e-fc12-4a6d-bc9d-c807b69a4f0d', N'USER', N'USER', NULL), (N'8a83a0a5-d39d-4494-9efc-8adfa0ed8a7d', N'MANAGER', N'MANAGER', NULL), (N'b2320b19-698e-437c-821b-664114555e22', N'OWNER', N'OWNER', NULL), (N'ed3c1f9c-8ba2-47fe-838d-40f00622faee', N'ADMIN', N'ADMIN', NULL)
GO

COMMIT
GO


-- ----------------------------
-- Table structure for UserClaims
-- ----------------------------
CREATE TABLE [Identity].[UserClaims] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [UserId] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [ClaimType] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NULL,
  [ClaimValue] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NULL
)
GO

ALTER TABLE [Identity].[UserClaims] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of UserClaims
-- ----------------------------
BEGIN TRANSACTION
GO

SET IDENTITY_INSERT [Identity].[UserClaims] ON
GO

SET IDENTITY_INSERT [Identity].[UserClaims] OFF
GO

COMMIT
GO


-- ----------------------------
-- Table structure for UserLogins
-- ----------------------------
CREATE TABLE [Identity].[UserLogins] (
  [LoginProvider] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [ProviderKey] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [ProviderDisplayName] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NULL,
  [UserId] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL
)
GO

ALTER TABLE [Identity].[UserLogins] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of UserLogins
-- ----------------------------
BEGIN TRANSACTION
GO

COMMIT
GO


-- ----------------------------
-- Table structure for UserRoles
-- ----------------------------
CREATE TABLE [Identity].[UserRoles] (
  [UserId] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [RoleId] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL
)
GO

ALTER TABLE [Identity].[UserRoles] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of UserRoles
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [Identity].[UserRoles] ([UserId], [RoleId]) VALUES (N'2cb3c82e-19c1-4302-824c-0eb5df4014ba', N'3ef2558e-fc12-4a6d-bc9d-c807b69a4f0d'), (N'48e0751d-8a17-41ea-bce5-43bd00f282a4', N'3ef2558e-fc12-4a6d-bc9d-c807b69a4f0d'), (N'5cebc15f-9554-4f6a-9de6-18d56b74faad', N'3ef2558e-fc12-4a6d-bc9d-c807b69a4f0d'), (N'6430694f-9ccf-4be4-9ec4-a2fcb39a806d', N'3ef2558e-fc12-4a6d-bc9d-c807b69a4f0d'), (N'65aed439-7335-4c5a-a609-80903ecec045', N'3ef2558e-fc12-4a6d-bc9d-c807b69a4f0d'), (N'6c834c7f-a6cd-4223-b818-997e8750820d', N'3ef2558e-fc12-4a6d-bc9d-c807b69a4f0d'), (N'a0508d55-957e-49cd-a854-f240357ac569', N'3ef2558e-fc12-4a6d-bc9d-c807b69a4f0d'), (N'a94a581e-2c7f-411c-9028-7a2ead16b1c4', N'3ef2558e-fc12-4a6d-bc9d-c807b69a4f0d'), (N'd90e44ad-e7d3-4ec9-bc4e-84184b5e5929', N'3ef2558e-fc12-4a6d-bc9d-c807b69a4f0d'), (N'eaee9c0d-c7e7-4f3f-88d4-5863415384bb', N'3ef2558e-fc12-4a6d-bc9d-c807b69a4f0d'), (N'f7f75502-d8dc-428e-97ee-1802e7c6184b', N'3ef2558e-fc12-4a6d-bc9d-c807b69a4f0d'), (N'12cb9a18-9a1a-4178-a7f9-a723d5eb073b', N'8a83a0a5-d39d-4494-9efc-8adfa0ed8a7d'), (N'460055a7-8d75-488c-a898-70a478fb6e42', N'ed3c1f9c-8ba2-47fe-838d-40f00622faee')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for Users
-- ----------------------------
CREATE TABLE [Identity].[Users] (
  [Id] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [FirstName] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [LastName] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [Address] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [CreatedAt] datetime2(7)  NOT NULL,
  [UserName] nvarchar(256) COLLATE Modern_Spanish_CI_AS  NULL,
  [NormalizedUserName] nvarchar(256) COLLATE Modern_Spanish_CI_AS  NULL,
  [Email] nvarchar(256) COLLATE Modern_Spanish_CI_AS  NULL,
  [NormalizedEmail] nvarchar(256) COLLATE Modern_Spanish_CI_AS  NULL,
  [EmailConfirmed] bit  NOT NULL,
  [PasswordHash] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NULL,
  [SecurityStamp] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NULL,
  [ConcurrencyStamp] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NULL,
  [PhoneNumber] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NULL,
  [PhoneNumberConfirmed] bit  NOT NULL,
  [TwoFactorEnabled] bit  NOT NULL,
  [LockoutEnd] datetimeoffset(7)  NULL,
  [LockoutEnabled] bit  NOT NULL,
  [AccessFailedCount] int  NOT NULL
)
GO

ALTER TABLE [Identity].[Users] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of Users
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [Identity].[Users] ([Id], [FirstName], [LastName], [Address], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'12cb9a18-9a1a-4178-a7f9-a723d5eb073b', N'user10', N'lastname10', N'user10 address', N'2024-09-19 21:39:50.1196382', N'user10', N'USER10', N'user10@user.com', N'USER10@USER.COM', N'0', N'AQAAAAIAAYagAAAAENxUQdCyeQSor8juAqmhWjvKrcd6TT+0ienXOJgyE5ovNUdlnxm69a8i2W2Md7nW2A==', N'ANINQQPMOUOAEEIRMWDCJIV3RBZSBW56', N'f7381b67-e911-4df2-ad8b-f92efe5a7b87', NULL, N'0', N'0', NULL, N'1', N'0'), (N'2cb3c82e-19c1-4302-824c-0eb5df4014ba', N'user1', N'lastname1', N'user1 address', N'2024-09-19 21:36:37.8463460', N'user1', N'USER1', N'user1@user.com', N'USER1@USER.COM', N'0', N'AQAAAAIAAYagAAAAEPwzHMDrQB8/dsINLkKJoR4boQgYD3CzcjrBBiL3rrofwF+0789JZ+b6h/Cv7YKDRw==', N'3H2CMTGBUNW4L4P4HITRJ4L5QPQGCVK4', N'270b9468-17aa-4e38-81c8-9ea95803fb34', NULL, N'0', N'0', NULL, N'1', N'0'), (N'460055a7-8d75-488c-a898-70a478fb6e42', N'Jose', N'Roque', N'Arequipa', N'2024-09-19 19:55:45.8730378', N'jroque', N'JROQUE', N'rokefeler@gmail.com', N'ROKEFELER@GMAIL.COM', N'0', N'AQAAAAIAAYagAAAAEAHzMO+i8ayGYxMMVC8MhTtXGY78PQ9ldpRHBI+1IdNXaD81ogLNVvoxhcYcLGGpog==', N'GUPFBSJJB4CSXKVI3C37MGWL5LML7VHB', N'b1890dc3-0dc1-4feb-8d9c-427c5e296cb1', NULL, N'0', N'0', NULL, N'1', N'0'), (N'48e0751d-8a17-41ea-bce5-43bd00f282a4', N'user8', N'lastname8', N'user8 address', N'2024-09-19 21:39:31.7803142', N'user8', N'USER8', N'user8@user.com', N'USER8@USER.COM', N'0', N'AQAAAAIAAYagAAAAEGheWzaCDcj48pc5/quyhPIZDpxhOxRg7WXwEmZX8wB4Q6tm5JzQwBJenh47n9JCCQ==', N'HTDFYXY4RWKZB6ECUARORTLMXYTVOAD5', N'0037ec7b-37e7-449b-a904-254ed0bdf855', NULL, N'0', N'0', NULL, N'1', N'0'), (N'5cebc15f-9554-4f6a-9de6-18d56b74faad', N'user7', N'lastname7', N'user7 address', N'2024-09-19 21:39:20.2179521', N'user7', N'USER7', N'user7@user.com', N'USER7@USER.COM', N'0', N'AQAAAAIAAYagAAAAEHy/eL5SUf7XQz/UfpAuIU1y+Z5KDxCXJqbFTsfwEnwznOb5E8W3ABm+yWR/zr1n4g==', N'A2QPSQIXCGSCZADCBSTIEBTQCTAJS2S4', N'7c8ca09f-2d70-418b-acc2-d7206aa07b70', NULL, N'0', N'0', NULL, N'1', N'0'), (N'6430694f-9ccf-4be4-9ec4-a2fcb39a806d', N'user12', N'lastname12', N'user12 address', N'2024-09-19 21:40:10.4795132', N'user12', N'USER12', N'user12@user.com', N'USER12@USER.COM', N'0', N'AQAAAAIAAYagAAAAEKfY+dPC7w064wTJnfxz7zP5Cifys9K3eRnTR0gaqkoL4IiYeu5iroZEYzjGHVirEw==', N'GATA6JILGQKFS33X5C62EKFBUTN7YJLN', N'c8bd32db-1165-4463-80f1-6ddeaa25e6a8', NULL, N'0', N'0', NULL, N'1', N'0'), (N'65aed439-7335-4c5a-a609-80903ecec045', N'user3', N'lastname3', N'user3 address', N'2024-09-19 21:38:25.0385295', N'user3', N'USER3', N'user3@user.com', N'USER3@USER.COM', N'0', N'AQAAAAIAAYagAAAAEFpCO4hCD1rPGypDBBoDek4P/ASVH4xa/NdoZiTWzldr48ttuSuEP0gW8hQV/uxy0Q==', N'F3OULBQ42ROBFZ67DZLAY4C4EWBKN6AJ', N'3fd09dd0-7cac-47e9-a35a-2a14015cce3b', NULL, N'0', N'0', NULL, N'1', N'0'), (N'6c834c7f-a6cd-4223-b818-997e8750820d', N'user9', N'lastname9', N'user9 address', N'2024-09-19 21:39:40.1569692', N'user9', N'USER9', N'user9@user.com', N'USER9@USER.COM', N'0', N'AQAAAAIAAYagAAAAEJQd8zG/vtu/HZBLh+PGpWGMZk+APXangebrnVS7skBTjTI71w6KW+o63oYwGkSKJw==', N'KVR5CD5TFDNPT4SISC4WJT7DTVBCNDEV', N'034c8a7e-4852-4e09-8dc7-f0206dc975aa', NULL, N'0', N'0', NULL, N'1', N'0'), (N'a0508d55-957e-49cd-a854-f240357ac569', N'user4', N'lastname4', N'user4 address', N'2024-09-19 21:38:35.7647575', N'user4', N'USER4', N'user4@user.com', N'USER4@USER.COM', N'0', N'AQAAAAIAAYagAAAAEBRPZT5wAZjjeCC1Y+d4Ytf4igQgp339aM1TtGLwisVmbL25e+Qq8j2UYRorjnRjjA==', N'EUH44AOUOE6XZ2H56YWI4MBP6KB2TFYT', N'7ec4cbdf-40eb-4be7-a5a3-ca1dff2df448', NULL, N'0', N'0', NULL, N'1', N'0'), (N'a94a581e-2c7f-411c-9028-7a2ead16b1c4', N'user11', N'lastname11', N'user11 address', N'2024-09-19 21:40:00.5250724', N'user11', N'USER11', N'user11@user.com', N'USER11@USER.COM', N'0', N'AQAAAAIAAYagAAAAEMgmg5HtJAj2vXrxz8bCo7k8URq0jYkQ7JqyKljo4ws74BtplcUKNP4z4IJ+dlvVxQ==', N'HBANJPR7LIZT7PHDZI2M4S5KCNQBUK6A', N'379113f4-aea4-42e6-9154-b1c952b931a2', NULL, N'0', N'0', NULL, N'1', N'0'), (N'd90e44ad-e7d3-4ec9-bc4e-84184b5e5929', N'user2', N'lastname2', N'user2 address', N'2024-09-19 21:37:00.3307603', N'user2', N'USER2', N'user2@user.com', N'USER2@USER.COM', N'0', N'AQAAAAIAAYagAAAAELPsDTWAbhk1wXmo+ESkK39R5GLeRAsu7vQQ3fnntElmWhZ3wq/E/gJTpmMJAK2lyg==', N'QMV5WS2AY2P26GKZIXLWOEMZCGD2YEQ3', N'912c1d07-8237-44c6-a850-5571325f4efa', NULL, N'0', N'0', NULL, N'1', N'0'), (N'eaee9c0d-c7e7-4f3f-88d4-5863415384bb', N'user5', N'lastname5', N'user5 address', N'2024-09-19 21:38:48.3857197', N'user5', N'USER5', N'user5@user.com', N'USER5@USER.COM', N'0', N'AQAAAAIAAYagAAAAEFeWeFi1ccV7NGk+F5Sx+jO60+zRiA5kddN0ZS/q4sbjRwVZ4p+grCL0IIxXE7wmhA==', N'WMBW37P2SDRMDDUCWI5ZI4D7KPSTY7VR', N'0e2e40a0-e9a8-4e4e-a6fb-4d96d8c71110', NULL, N'0', N'0', NULL, N'1', N'0'), (N'f7f75502-d8dc-428e-97ee-1802e7c6184b', N'user6', N'lastname6', N'user6 address', N'2024-09-19 21:38:59.5716206', N'user6', N'USER6', N'user6@user.com', N'USER6@USER.COM', N'0', N'AQAAAAIAAYagAAAAED+7BoWxgHzFE3tadHfID+KdkmRxIjo1o3sU7tJYL4krz/teyMUYrsspjp9C9BLS8A==', N'ERP4TJ72X577TOODAZTYZ4IST7JYQLOM', N'86585ad6-5cef-4d8b-a838-a7323325db8c', NULL, N'0', N'0', NULL, N'1', N'0')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for UserTokens
-- ----------------------------
CREATE TABLE [Identity].[UserTokens] (
  [UserId] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [LoginProvider] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [Name] nvarchar(450) COLLATE Modern_Spanish_CI_AS  NOT NULL,
  [Value] nvarchar(max) COLLATE Modern_Spanish_CI_AS  NULL
)
GO

ALTER TABLE [Identity].[UserTokens] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of UserTokens
-- ----------------------------
BEGIN TRANSACTION
GO

COMMIT
GO


-- ----------------------------
-- Auto increment value for RoleClaims
-- ----------------------------
DBCC CHECKIDENT ('[Identity].[RoleClaims]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table RoleClaims
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_RoleClaims_RoleId]
ON [Identity].[RoleClaims] (
  [RoleId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table RoleClaims
-- ----------------------------
ALTER TABLE [Identity].[RoleClaims] ADD CONSTRAINT [PK_RoleClaims] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table Roles
-- ----------------------------
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex]
ON [Identity].[Roles] (
  [NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
GO


-- ----------------------------
-- Primary Key structure for table Roles
-- ----------------------------
ALTER TABLE [Identity].[Roles] ADD CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for UserClaims
-- ----------------------------
DBCC CHECKIDENT ('[Identity].[UserClaims]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table UserClaims
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_UserClaims_UserId]
ON [Identity].[UserClaims] (
  [UserId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table UserClaims
-- ----------------------------
ALTER TABLE [Identity].[UserClaims] ADD CONSTRAINT [PK_UserClaims] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table UserLogins
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_UserLogins_UserId]
ON [Identity].[UserLogins] (
  [UserId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table UserLogins
-- ----------------------------
ALTER TABLE [Identity].[UserLogins] ADD CONSTRAINT [PK_UserLogins] PRIMARY KEY CLUSTERED ([LoginProvider], [ProviderKey])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table UserRoles
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_UserRoles_RoleId]
ON [Identity].[UserRoles] (
  [RoleId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table UserRoles
-- ----------------------------
ALTER TABLE [Identity].[UserRoles] ADD CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED ([UserId], [RoleId])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table Users
-- ----------------------------
CREATE NONCLUSTERED INDEX [EmailIndex]
ON [Identity].[Users] (
  [NormalizedEmail] ASC
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex]
ON [Identity].[Users] (
  [NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
GO


-- ----------------------------
-- Primary Key structure for table Users
-- ----------------------------
ALTER TABLE [Identity].[Users] ADD CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table UserTokens
-- ----------------------------
ALTER TABLE [Identity].[UserTokens] ADD CONSTRAINT [PK_UserTokens] PRIMARY KEY CLUSTERED ([UserId], [LoginProvider], [Name])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Foreign Keys structure for table RoleClaims
-- ----------------------------
ALTER TABLE [Identity].[RoleClaims] ADD CONSTRAINT [FK_RoleClaims_Roles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [Identity].[Roles] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table UserClaims
-- ----------------------------
ALTER TABLE [Identity].[UserClaims] ADD CONSTRAINT [FK_UserClaims_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [Identity].[Users] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table UserLogins
-- ----------------------------
ALTER TABLE [Identity].[UserLogins] ADD CONSTRAINT [FK_UserLogins_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [Identity].[Users] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table UserRoles
-- ----------------------------
ALTER TABLE [Identity].[UserRoles] ADD CONSTRAINT [FK_UserRoles_Roles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [Identity].[Roles] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

ALTER TABLE [Identity].[UserRoles] ADD CONSTRAINT [FK_UserRoles_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [Identity].[Users] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table UserTokens
-- ----------------------------
ALTER TABLE [Identity].[UserTokens] ADD CONSTRAINT [FK_UserTokens_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [Identity].[Users] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

