CREATE DATABASE Spotify
USE Spotify

CREATE TABLE Artists
(
 Id int primary key identity,
 [Name] nvarchar(20) NOT NULL, 
 Follower int
)
CREATE TABLE Albums
(
 Id int primary key identity,
 [Name] nvarchar(20) NOT NULL, 
 Release_Date date,
 Artist_id int FOREIGN KEY REFERENCES Artists(Id)
)
CREATE TABLE Tracks
(
 Id int primary key identity,
 [Name] nvarchar(20) NOT NULL, 
 Totalsecond int NOT NULL,
 Listener_Count int NOT NULL,
 Album_id int FOREIGN KEY REFERENCES Albums(Id)
)

INSERT INTO Artists VALUES
('Eminem',75309297),
('Inna',9472198)
SELECT * FROM Artists

ALTER TABLE Albums ALTER COLUMN [Name] nvarchar(50);

INSERT INTO Albums VALUES
('Music To Be Murdered By','2020-01-17',1),
('Hot','2010-08-04',2)
SELECT * FROM Albums

INSERT INTO Tracks VALUES
('Premonition (Intro)',174,82823345,1),
('Unaccommodating',227,135205961,1),
('You Gon’ Learn',235,157903540,1),
('Alfred (Interlude)',30,48328686,1),
('Those Kinda Nights',178,170875350,1),

('Hot',217,138931052,2),
('10 Minutes',199,12050530,2),
('Love',219,22205944,2),
('Amazing',217,58518362,2),
('Deja Vu',261,39533198,2)
SELECT * FROM Tracks

--A
CREATE VIEW TrackDetails 
AS
SELECT ar.Name AS 'ArtistName',a.[Name] AS 'AlbumName',t.[Name] AS 'TrackName',t.Totalsecond AS 'TrackLength' FROM Tracks t
JOIN Albums a ON t.Album_id=a.Id
JOIN Artists ar ON ar.Id=a.Artist_id

SELECT * FROM TrackDetails
DROP VIEW TrackDetails
--B
CREATE VIEW AlbumDetails
AS
SELECT a.[Name] AS AlbumName,COUNT (t.Id )AS TrackCount FROM Albums a 
JOIN Tracks t ON t.Album_id=a.Id
GROUP BY a.[Name]

SELECT * FROM AlbumDetails

--C
CREATE PROCEDURE ListenerCount_and_AlbumName
@listenerCount int,
@albumName nvarchar(50)
AS
SELECT a.[Name] AS AlbumName,t.[Name],t.Listener_Count FROM Tracks t
JOIN Albums a ON a.Id=t.Album_id 
WHERE t.Listener_Count>@listenerCount AND a.Name LIKE '%'+@albumName+'%'

EXEC ListenerCount_and_AlbumName 20000000,'H';
