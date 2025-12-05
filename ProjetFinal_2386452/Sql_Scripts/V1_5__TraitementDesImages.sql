

ALTER TABLE Versants.Remontee ADD Identifiant uniqueidentifier NOT NULL ROWGUIDCOL DEFAULT newid()
GO
ALTER TABLE Versants.Remontee ADD CONSTRAINT UC_Remontee_Identifiant UNIQUE(Identifiant)
GO
ALTER TABLE Versants.Remontee ADD Photo varbinary(max) FILESTREAM NULL
GO

UPDATE Versants.Remontee 
SET Photo = BulkColumn FROM OPENROWSET(
	BULK 'C:\work\Bd-ProgWeb\projetFinal\ProjetFinal_2386452\Images\Revelation1.png', SINGLE_BLOB) AS myfile
WHERE RemonteeID = 1

UPDATE Versants.Remontee 
SET Photo = BulkColumn FROM OPENROWSET(
	BULK 'C:\work\Bd-ProgWeb\projetFinal\ProjetFinal_2386452\Images\Revelation2.png', SINGLE_BLOB) AS myfile
WHERE RemonteeID = 2

UPDATE Versants.Remontee 
SET Photo = BulkColumn FROM OPENROWSET(
	BULK 'C:\work\Bd-ProgWeb\projetFinal\ProjetFinal_2386452\Images\TheStoke.png', SINGLE_BLOB) AS myfile
WHERE RemonteeID = 3

UPDATE Versants.Remontee 
SET Photo = BulkColumn FROM OPENROWSET(
	BULK 'C:\work\Bd-ProgWeb\projetFinal\ProjetFinal_2386452\Images\ripper.png', SINGLE_BLOB) AS myfile
WHERE RemonteeID = 4

UPDATE Versants.Remontee 
SET Photo = BulkColumn FROM OPENROWSET(
	BULK 'C:\work\Bd-ProgWeb\projetFinal\ProjetFinal_2386452\Images\stellar.png', SINGLE_BLOB) AS myfile
WHERE RemonteeID = 5









