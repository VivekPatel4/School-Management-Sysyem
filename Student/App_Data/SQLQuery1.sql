CREATE TABLE [dbo].[admin] (
    [UserName]     NVARCHAR (100) NOT NULL,
    [Password]     NVARCHAR (100) NOT NULL,
    [fullname]     NVARCHAR (255) NOT NULL,
    [email]        NVARCHAR (55)  NOT NULL,
    [updationDate] DATETIME       DEFAULT (getdate()) NOT NULL,
    [id]           INT            IDENTITY (8, 1) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

CREATE TABLE [dbo].[departments] (
    [DepartmentName]      NVARCHAR (150) NULL,
    [DepartmentShortName] NVARCHAR (100) NOT NULL,
    [DepartmentCode]      NVARCHAR (50)  NULL,
    [CreationDate]        DATETIME       DEFAULT (getdate()) NULL,
    [id]                  INT            IDENTITY (8, 1) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

CREATE TABLE [dbo].[leaves] (
    [LeaveType]       NVARCHAR (110) NOT NULL,
    [ToDate]          NVARCHAR (120) NOT NULL,
    [FromDate]        NVARCHAR (120) NOT NULL,
    [Description]     NVARCHAR (MAX) NOT NULL,
    [PostingDate]     DATETIME       DEFAULT (getdate()) NOT NULL,
    [AdminRemark]     NVARCHAR (MAX) NULL,
    [AdminRemarkDate] NVARCHAR (120) NULL,
    [Status]          INT            NOT NULL,
    [IsRead]          BIT            NOT NULL,
    [stdid]           INT            NULL,
    [id]              INT            IDENTITY (112, 1) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_leaves_stdid]
    ON [dbo].[leaves]([stdid] ASC);


GO
CREATE NONCLUSTERED INDEX [IDX_UserEmail]
    ON [dbo].[leaves]([stdid] ASC);

CREATE TABLE [dbo].[leavetype] (
    [LeaveType]    NVARCHAR (200) NULL,
    [Description]  NVARCHAR (MAX) NULL,
    [CreationDate] DATETIME       DEFAULT (getdate()) NOT NULL,
    [id]           INT            IDENTITY (22, 1) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

CREATE TABLE [dbo].[remainder] (
    [Name]     NVARCHAR (150) NULL,
    [MOBILENO] NVARCHAR (255) NULL,
    [remark]   NVARCHAR (255) NULL,
    [wishyear] DATE           NULL,
    [IsRead]   BIT            NOT NULL,
    [id]       INT            IDENTITY (159, 1) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

CREATE TABLE [dbo].[students] (
    [photo]          NVARCHAR (255) NULL,
    [capturedPhoto]  NVARCHAR (255) NULL,
    [stdid]          NVARCHAR (100) NOT NULL,
    [FirstName]      NVARCHAR (150) NOT NULL,
    [LastName]       NVARCHAR (150) NOT NULL,
    [RoomNo]         NVARCHAR (255) NULL,
    [EmailId]        NVARCHAR (200) NOT NULL,
    [Password]       NVARCHAR (180) NOT NULL,
    [Gender]         NVARCHAR (100) NOT NULL,
    [Dob]            NVARCHAR (100) NOT NULL,
    [ParentName]     NVARCHAR (255) NULL,
    [Occupation]     NVARCHAR (255) NULL,
    [ParentMobileno] NVARCHAR (255) NULL,
    [Department]     NVARCHAR (255) NOT NULL,
    [Address]        NVARCHAR (255) NOT NULL,
    [City]           NVARCHAR (200) NOT NULL,
    [Country]        NVARCHAR (150) NOT NULL,
    [District]       NVARCHAR (255) NULL,
    [Taluko]         NVARCHAR (255) NULL,
    [State]          NVARCHAR (255) NULL,
    [Pincode]        NVARCHAR (255) NULL,
    [Phonenumber]    CHAR (11)      NOT NULL,
    [Status]         BIT            NOT NULL,
    [RegDate]        DATETIME       DEFAULT (getdate()) NOT NULL,
    [id]             INT            IDENTITY (209, 1) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

CREATE TABLE [dbo].[attendance] (
    [id]         INT            IDENTITY (1, 1) NOT NULL,
    [student_id] INT            NOT NULL,
    [stdid]      NVARCHAR (150) NOT NULL,
    [FirstName]  NVARCHAR (150) NOT NULL,
    [LastName]   NVARCHAR (150) NOT NULL,
    [status]     NVARCHAR (50)  NOT NULL,
    [date]       NVARCHAR (255) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_attendance_students] FOREIGN KEY ([student_id]) REFERENCES [dbo].[students] ([id])
);




