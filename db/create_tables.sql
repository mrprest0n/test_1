--Создание таблицы продуктов
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PRODUCTS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PRODUCTS](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
 CONSTRAINT [PK_PRODUCTS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

------------------------------------------------------------------------------------------------------------------------

--Создание таблицы категорий
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CATEGORIES]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CATEGORIES](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
 CONSTRAINT [PK_CATEGORIES] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

------------------------------------------------------------------------------------------------------------------------

--Создание промежуточной таблицы для таблиц продуктов и категорий
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PRODS_AND_CATS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PRODS_AND_CATS](
	[product] [int] NOT NULL,
	[category] [int] NOT NULL,
	CONSTRAINT PK_PRODS_AND_CATS PRIMARY KEY NONCLUSTERED ([product], [category])) ON [PRIMARY]
END
GO

-- Создание внешнего ключа для таблицы PRODUCTS по полю 'id'
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_PRODS_AND_CATS_PRODUCTS]') AND parent_object_id = OBJECT_ID(N'[dbo].[PRODS_AND_CATS]'))
ALTER TABLE [dbo].[PRODS_AND_CATS]  WITH CHECK ADD  CONSTRAINT [FK_PRODS_AND_CATS_PRODUCTS] FOREIGN KEY([product])
REFERENCES [dbo].[PRODUCTS] ([id])
ON DELETE CASCADE
GO

-- Создание внешнего ключа для таблицы CATEGORIES по полю 'id'
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_PRODS_AND_CATS_CATEGORIES]') AND parent_object_id = OBJECT_ID(N'[dbo].[PRODS_AND_CATS]'))
ALTER TABLE [dbo].[PRODS_AND_CATS]  WITH CHECK ADD  CONSTRAINT [FK_PRODS_AND_CATS_CATEGORIES] FOREIGN KEY([category])
REFERENCES [dbo].[CATEGORIES] ([id])
ON DELETE CASCADE
GO

		 