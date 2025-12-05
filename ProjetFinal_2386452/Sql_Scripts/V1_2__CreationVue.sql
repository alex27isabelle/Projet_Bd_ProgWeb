CREATE OR ALTER VIEW Versants.vw_InfoPiste AS
SELECT P.Nom, P.Difficulte, P.Longeur, P.EstSousBois, V.Nom AS[Versant], COUNT(DescenteID) AS[Nombre de decente], P.PisteID
FROM Versants.Piste P
INNER JOIN Versants.Versant V
ON V.VersantID = P.VersantID
INNER JOIN Clients.Descente D
ON D.PisteID = P.PisteID
GROUP BY P.Nom, P.Difficulte, P.Longeur, P.EstSousBois, V.Nom, P.PisteID
GO