SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[stuartd].[dateformats]') AND type in (N'U'))
BEGIN
CREATE TABLE [stuartd].[dateformats](
	[ID] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[Format] [varchar](50) NOT NULL,
 CONSTRAINT [PK_dateformats] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[stuartd].[posts]') AND type in (N'U'))
BEGIN
CREATE TABLE [stuartd].[posts](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](50) NOT NULL,
	[postdate] [timestamp] NOT NULL,
	[stub] [varchar](50) NOT NULL,
	[body] [text] NOT NULL,
	[richtitle] [varchar](100) NULL,
 CONSTRAINT [PK_posts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[stuartd].[categories]') AND type in (N'U'))
BEGIN
CREATE TABLE [stuartd].[categories](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_categories] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[stuartd].[settings]') AND type in (N'U'))
BEGIN
CREATE TABLE [stuartd].[settings](
	[dateformat] [int] NOT NULL,
	[blogtitle] [varchar](100) NOT NULL,
	[baseurl] [varchar](100) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[stuartd].[postcategories]') AND type in (N'U'))
BEGIN
CREATE TABLE [stuartd].[postcategories](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[PostID] [int] NOT NULL,
 CONSTRAINT [PK_postcategories] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[stuartd].[FK_settings_dateformats]') AND parent_object_id = OBJECT_ID(N'[stuartd].[settings]'))
ALTER TABLE [stuartd].[settings]  WITH CHECK ADD  CONSTRAINT [FK_settings_dateformats] FOREIGN KEY([dateformat])
REFERENCES [stuartd].[dateformats] ([ID])
GO
ALTER TABLE [stuartd].[settings] CHECK CONSTRAINT [FK_settings_dateformats]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[stuartd].[FK_postcategories_categories]') AND parent_object_id = OBJECT_ID(N'[stuartd].[postcategories]'))
ALTER TABLE [stuartd].[postcategories]  WITH CHECK ADD  CONSTRAINT [FK_postcategories_categories] FOREIGN KEY([CategoryID])
REFERENCES [stuartd].[categories] ([ID])
GO
ALTER TABLE [stuartd].[postcategories] CHECK CONSTRAINT [FK_postcategories_categories]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[stuartd].[FK_postcategories_posts]') AND parent_object_id = OBJECT_ID(N'[stuartd].[postcategories]'))
ALTER TABLE [stuartd].[postcategories]  WITH CHECK ADD  CONSTRAINT [FK_postcategories_posts] FOREIGN KEY([PostID])
REFERENCES [stuartd].[posts] ([ID])
GO
ALTER TABLE [stuartd].[postcategories] CHECK CONSTRAINT [FK_postcategories_posts]
