USE [FCCR_DRM]
GO

/****** Object:  Table [dbo].[SCARFOR]    Script Date: 05/02/2014 16:20:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[SCARFOR](
	[forcodi] [int] IDENTITY(1,1) NOT NULL,
	[forfant] [char](40) NOT NULL,
	[forraso] [char](60) NOT NULL,
	[forcgc] [char](18) NOT NULL,
	[foriest] [char](20) NULL,
	[forimun] [char](20) NULL,
	[forende] [char](90) NULL,
	[forbair] [char](30) NULL,
	[forcida] [char](30) NULL,
	[ufcodi] [char](2) NULL,
	[forcep] [char](9) NULL,
	[aticodi] [smallint] NOT NULL,
	[forcada] [int] NULL,
	[forcomp] [int] NULL,
	[forpess] [char](1) NULL,
	[forobse] [varchar](1000) NULL,
	[forsigl] [char](4) NULL,
	[forbanc] [char](20) NULL,
	[foragen] [char](6) NULL,
	[forcont] [char](15) NULL,
	[codigo] [char](14) NULL,
	[forfavo] [char](8) NOT NULL,
	[forsitu] [char](9) NOT NULL,
	[forrg] [char](20) NOT NULL,
	[forpis] [char](20) NOT NULL,
 CONSTRAINT [SCFOR_01] PRIMARY KEY CLUSTERED 
(
	[forcodi] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

