CREATE DATABASE _backup;
CREATE TABLE _backup..article(
	[id] [int] PRIMARY KEY IDENTITY(1,1),
	[createAt] [DATETIME] NOT NULL DEFAULT(GETDATE()),
	[caption] [nvarchar](50) NOT NULL,
	[content] [nvarchar](200) NOT NULL
);
SET IDENTITY_INSERT _backup..article ON;
insert into _backup..article([id], [caption], [content]) values(1, 'announcement', 'Take care');
insert into _backup..article([id], [caption], [content]) values(2, '1984-I', 'He had won the victory over himself. He loved Big Brother.');
insert into _backup..article([id], [caption], [content]) values(3, '1984-II', 'Under the spreading chestnut tree、I sold you and you sold me——');