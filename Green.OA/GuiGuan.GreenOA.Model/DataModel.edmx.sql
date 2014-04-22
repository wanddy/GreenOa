
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 04/21/2014 14:25:12
-- Generated from EDMX file: c:\users\green\documents\visual studio 2013\Projects\Green.OA\GuiGuan.GreenOA.Model\DataModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [GreenOADB];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------


-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------


-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'UserInfo'
CREATE TABLE [dbo].[UserInfo] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [UName] nvarchar(32)  NULL,
    [UPwd] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Department'
CREATE TABLE [dbo].[Department] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [DepName] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'UserInfoDepartment'
CREATE TABLE [dbo].[UserInfoDepartment] (
    [UserInfo_Id] int  NOT NULL,
    [Department_Id] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'UserInfo'
ALTER TABLE [dbo].[UserInfo]
ADD CONSTRAINT [PK_UserInfo]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Department'
ALTER TABLE [dbo].[Department]
ADD CONSTRAINT [PK_Department]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [UserInfo_Id], [Department_Id] in table 'UserInfoDepartment'
ALTER TABLE [dbo].[UserInfoDepartment]
ADD CONSTRAINT [PK_UserInfoDepartment]
    PRIMARY KEY CLUSTERED ([UserInfo_Id], [Department_Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [UserInfo_Id] in table 'UserInfoDepartment'
ALTER TABLE [dbo].[UserInfoDepartment]
ADD CONSTRAINT [FK_UserInfoDepartment_UserInfo]
    FOREIGN KEY ([UserInfo_Id])
    REFERENCES [dbo].[UserInfo]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Department_Id] in table 'UserInfoDepartment'
ALTER TABLE [dbo].[UserInfoDepartment]
ADD CONSTRAINT [FK_UserInfoDepartment_Department]
    FOREIGN KEY ([Department_Id])
    REFERENCES [dbo].[Department]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UserInfoDepartment_Department'
CREATE INDEX [IX_FK_UserInfoDepartment_Department]
ON [dbo].[UserInfoDepartment]
    ([Department_Id]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------