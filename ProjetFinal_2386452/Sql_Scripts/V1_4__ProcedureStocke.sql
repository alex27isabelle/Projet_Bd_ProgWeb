USE RevelstokeMountainResort
GO

CREATE OR ALTER PROCEDURE Versants.USP_RecherchePiste
	@Nom nvarchar(50),
	@Difficulte nvarchar(128),
	@EstSousbois bit,
	@LongueurMin int

AS
BEGIN

SET @LongueurMin = COALESCE(@LongueurMin, 0)

DECLARE @NomPresent bit = CASE WHEN LEN(COALESCE(@Nom,'')) > 0 THEN 1 ELSE 0 END
DECLARE @DifficultePresent bit = CASE WHEN LEN(COALESCE(@Difficulte,'')) > 0 THEN 1 ELSE 0 END
DECLARE @FiltrerSousbois bit = @EstSousbois

	SELECT * 
	FROM Versants.vw_InfoPiste I
	WHERE (@NomPresent = 0 OR Nom LIKE '%' + @Nom + '%')
	AND (@DifficultePresent = 0 OR Difficulte = @Difficulte)
	AND (@FiltrerSousbois = 0 OR I.EstSousBois = 1)
	AND Longeur >= @LongueurMin
END
GO
