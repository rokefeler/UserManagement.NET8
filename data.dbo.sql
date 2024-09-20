-- ----------------------------
-- Records of Logs
-- ----------------------------
BEGIN TRANSACTION
GO

SET IDENTITY_INSERT [dbo].[Logs] ON
GO

INSERT INTO [dbo].[Logs] ([Id], [UserName], [Description], [CreatedAt], [UpdatedAt], [IsActive], [IsDeleted]) VALUES (N'1', N'jroque', N'jroque has been registered', N'2024-09-19 19:55:46.1368462', N'2024-09-19 19:55:46.1368477', N'1', N'0'), (N'2', N'jroque', N'New Login', N'2024-09-19 19:56:29.0145122', N'2024-09-19 19:56:29.0145141', N'1', N'0'), (N'3', N'jroque', N'New Token Generated', N'2024-09-19 19:57:18.3650267', N'2024-09-19 19:57:18.3650282', N'1', N'0'), (N'4', N'user1', N'user1 has been registered', N'2024-09-19 21:36:38.2443520', N'2024-09-19 21:36:38.2443533', N'1', N'0'), (N'5', N'user2', N'user2 has been registered', N'2024-09-19 21:37:00.4320928', N'2024-09-19 21:37:00.4320942', N'1', N'0'), (N'6', N'user3', N'user3 has been registered', N'2024-09-19 21:38:25.1261692', N'2024-09-19 21:38:25.1261705', N'1', N'0'), (N'7', N'user4', N'user4 has been registered', N'2024-09-19 21:38:35.8539638', N'2024-09-19 21:38:35.8539651', N'1', N'0'), (N'8', N'user5', N'user5 has been registered', N'2024-09-19 21:38:48.4786716', N'2024-09-19 21:38:48.4786730', N'1', N'0'), (N'9', N'user6', N'user6 has been registered', N'2024-09-19 21:38:59.6579704', N'2024-09-19 21:38:59.6579717', N'1', N'0'), (N'10', N'user7', N'user7 has been registered', N'2024-09-19 21:39:20.3155834', N'2024-09-19 21:39:20.3155848', N'1', N'0'), (N'11', N'user8', N'user8 has been registered', N'2024-09-19 21:39:31.8672877', N'2024-09-19 21:39:31.8672891', N'1', N'0'), (N'12', N'user9', N'user9 has been registered', N'2024-09-19 21:39:40.2572843', N'2024-09-19 21:39:40.2572856', N'1', N'0'), (N'13', N'user10', N'user10 has been registered', N'2024-09-19 21:39:50.2093038', N'2024-09-19 21:39:50.2093061', N'1', N'0'), (N'14', N'user11', N'user11 has been registered', N'2024-09-19 21:40:00.6437685', N'2024-09-19 21:40:00.6437695', N'1', N'0'), (N'15', N'user12', N'user12 has been registered', N'2024-09-19 21:40:10.5641409', N'2024-09-19 21:40:10.5641415', N'1', N'0'), (N'16', N'jroque', N'New Login', N'2024-09-19 21:41:40.5050264', N'2024-09-19 21:41:40.5050270', N'1', N'0'), (N'17', N'jroque', N'New Login', N'2024-09-19 21:42:24.1029222', N'2024-09-19 21:42:24.1029236', N'1', N'0'), (N'18', N'jroque', N'New Login', N'2024-09-19 21:43:28.0376790', N'2024-09-19 21:43:28.0376802', N'1', N'0'), (N'19', N'jroque', N'New Login', N'2024-09-19 21:45:05.7867273', N'2024-09-19 21:45:05.7867285', N'1', N'0'), (N'20', N'jroque', N'User jroque send a message to user2', N'2024-09-19 21:47:10.4087320', N'2024-09-19 21:47:10.4087335', N'1', N'0'), (N'21', N'jroque', N'User jroque send a message to user10', N'2024-09-19 21:47:35.0281130', N'2024-09-19 21:47:35.0281146', N'1', N'0'), (N'22', N'user10', N'user10 has been updated to MANAGER', N'2024-09-19 21:49:19.8084572', N'2024-09-19 21:49:19.8084613', N'1', N'0')
GO

SET IDENTITY_INSERT [dbo].[Logs] OFF
GO

COMMIT
GO


-- ----------------------------
-- Records of Messages
-- ----------------------------
BEGIN TRANSACTION
GO

SET IDENTITY_INSERT [dbo].[Messages] ON
GO

INSERT INTO [dbo].[Messages] ([Id], [SenderUserName], [ReceievrUserName], [Text], [CreatedAt], [UpdatedAt], [IsActive], [IsDeleted]) VALUES (N'1', N'jroque', N'user2', N'Hello friend, i''m jroque', N'2024-09-19 21:47:10.2242636', N'2024-09-19 21:47:10.2244358', N'1', N'0'), (N'2', N'jroque', N'user10', N'Hello friend, i''m jroque', N'2024-09-19 21:47:35.0177980', N'2024-09-19 21:47:35.0177992', N'1', N'0')
GO

SET IDENTITY_INSERT [dbo].[Messages] OFF
GO

COMMIT
GO



-- ----------------------------
-- Auto increment value for Logs
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[Logs]', RESEED, 22)
GO



-- ----------------------------
-- Auto increment value for Messages
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[Messages]', RESEED, 2)
GO


