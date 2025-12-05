ALTER TABLE Clients.Client
ADD 
MdpSel varbinary(16),
MdpHache varbinary(32)
GO



CREATE PROCEDURE Clients.USP_CreerClient
	@Nom nvarchar(50),
	@Prenom nvarchar(50),
	@Courriel nvarchar(256),
	@NumTel nvarchar(15),
	@MotDePasse nvarchar(100)
AS
BEGIN
	-- Sel Aléatoire
	DECLARE @MdpSel varbinary(16) = CRYPT_GEN_RANDOM(16)
	-- Concaténation mdp et sel
	DECLARE @MdpEtSel nvarchar(116) = CONCAT(@MotDePasse, @MdpSel)
	-- Hachage du mot de passe
	DECLARE @MdpHachage varbinary(32) = HASHBYTES('SHA2_256', @MdpEtSel)
	-- Insertion dans la table Client
	INSERT INTO Clients.Client (Nom, Prenom, MdpHache, MdpSel, Courriel, NumTel)
	VALUES
	(@Nom,@Prenom,@MdpHachage, @MdpSel, @Courriel, @NumTel)
END
GO

-- Procédure d'authentification
CREATE PROCEDURE Clients.USP_AuthClient
	@Courriel nvarchar(50),
	@MotDePasse nvarchar(50)
AS
BEGIN
	DECLARE @Sel varbinary(16)
	DECLARE @MdpHachage varbinary(32)
	SELECT @Sel = MdpSel, @MdpHachage = MdpHache
	FROM Clients.Client
	Where Courriel = @Courriel

	IF HASHBYTES('SHA2_256', CONCAT(@MotDePasse, @Sel)) = @MdpHachage
	BEGIN
		SELECT * FROM Clients.Client WHERE Courriel = @Courriel
	END
	ELSE
	BEGIN
		SELECT TOP 0 * FROM Clients.Client
	END
END
GO

ALTER TABLE Clients.PasseSaison NOCHECK CONSTRAINT FK_PasseSaison_ClientID
ALTER TABLE Clients.Adresse NOCHECK CONSTRAINT FK_Adresse_ClientID

DELETE FROM Clients.Client
DBCC CHECKIDENT ('Clients.Client', RESEED, 0)

EXEC Clients.USP_CreerClient 'Dupont', 'Jean', 'jean.dupont@example.com', '(250) 837-1234', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lemoine', 'Claire', 'claire.lemoine@example.com', '(778) 555-5678', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Martin', 'Pierre', 'pierre.martin@example.com', '(604) 234-5678', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Gagnon', 'Sophie', 'sophie.gagnon@example.com', '(250) 937-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Bernier', 'Luc', 'luc.bernier@example.com', '(604) 555-1234', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Boucher', 'Élise', 'elise.boucher@example.com', '(778) 555-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Thibault', 'Caroline', 'caroline.thibault@example.com', '(250) 344-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Simard', 'Claude', 'claude.simard@example.com', '(604) 555-6789', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Côté', 'Marc', 'marc.cote@example.com', '(250) 265-1234', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Dufresne', 'Isabelle', 'isabelle.dufresne@example.com', '(778) 555-6789', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lafleur', 'André', 'andre.lafleur@example.com', '(250) 545-1234', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Ouellet', 'Frédéric', 'frederic.ouellet@example.com', '(604) 555-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Bélanger', 'Éric', 'eric.belanger@example.com', '(778) 555-1234', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Simard', 'Julie', 'julie.simard@example.com', '(250) 860-5678', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Gauthier', 'David', 'david.gauthier@example.com', '(604) 555-9876', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lavigne', 'Monique', 'monique.lavigne@example.com', '(250) 372-5678', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Ouellet', 'Lucie', 'lucie.ouellet@example.com', '(778) 555-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Thibault', 'Marc', 'marc.thibault@example.com', '(604) 555-8765', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Dion', 'Michel', 'michel.dion@example.com', '(250) 344-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Gauthier', 'Chantal', 'chantal.gauthier@example.com', '(778) 555-3456', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Poirier', 'Jacinthe', 'jacinthe.poirier@example.com', '(604) 555-1234', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Dufresne', 'Paul', 'paul.dufresne@example.com', '(250) 265-5678', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lafleur', 'Sylvie', 'sylvie.lafleur@example.com', '(778) 555-4567', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Simard', 'Denis', 'denis.simard@example.com', '(250) 545-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Bélanger', 'Lucie', 'lucie.belanger@example.com', '(604) 555-4321', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Simard', 'Claude', 'claude.simard@example.com', '(250) 860-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Gauthier', 'Monique', 'monique.gauthier@example.com', '(778) 555-6789', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lavigne', 'Gilles', 'gilles.lavigne@example.com', '(250) 372-6789', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Ouellet', 'Lucie', 'lucie.ouellet@example.com', '(604) 555-7654', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Thibault', 'Caroline', 'caroline.thibault@example.com', '(250) 837-3456', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Ouellet', 'Francois', 'francois.ouellet@example.com', '(604) 555-3456', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Boucher', 'Renée', 'renee.boucher@example.com', '(778) 555-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Dufresne', 'Jacques', 'jacques.dufresne@example.com', '(250) 265-3456', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lafleur', 'Denis', 'denis.lafleur@example.com', '(778) 555-1234', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lavigne', 'Julie', 'julie.lavign@example.com', '(250) 860-5678', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lemoine', 'Jacques', 'jacques.lemoine@example.com', '(604) 555-4321', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Bélanger', 'Claude', 'claude.belanger@example.com', '(250) 545-6789', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lemoine', 'Robert', 'robert.lemoine@example.com', '(778) 555-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Simard', 'Hélène', 'helene.simard@example.com', '(250) 860-3456', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Côté', 'Jean-Pierre', 'jean-pierre.cote@example.com', '(604) 555-5678', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Boucher', 'Michel', 'michel.boucher@example.com', '(250) 837-1234', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Dufresne', 'Sophie', 'sophie.dufresne@example.com', '(778) 555-3456', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Thibault', 'Marie', 'marie.thibault@example.com', '(250) 265-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Dufresne', 'Éric', 'eric.dufresne@example.com', '(250) 545-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lemoine', 'Sylvie', 'sylvie.lemoine@example.com', '(778) 555-1234', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Bélanger', 'Gilles', 'gilles.belanger@example.com', '(604) 555-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Simard', 'Monique', 'monique.simard@example.com', '(250) 860-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Gauthier', 'Jacques', 'jacques.gauthier@example.com', '(604) 555-3456', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lavigne', 'Robert', 'robert.lavigne@example.com', '(250) 837-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Ouellet', 'Geneviève', 'genevieve.ouellet@example.com', '(250) 265-5678', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lafleur', 'Julie', 'julie.lafleur@example.com', '(250) 545-6789', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Simard', 'Gilles', 'gilles.simard@example.com', '(250) 860-3456', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Dufresne', 'Pierre', 'pierre.dufresne@example.com', '(250) 837-3456', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Thibault', 'Michel', 'michel.thibault@example.com', '(778) 555-7654', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Boucher', 'Éric', 'eric.boucher@example.com', '(250) 265-6789', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lemoine', 'Michel', 'michel.lemoine@example.com', '(250) 545-1234', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Dufresne', 'Antoine', 'antoine.dufresne@example.com', '(778) 555-6543', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lafleur', 'Jean', 'jean.lafleur@example.com', '(604) 555-6543', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Gagnon', 'Suzanne', 'suzanne.gagnon@example.com', '(250) 860-1234', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Simard', 'Paul', 'paul.simard@example.com', '(604) 555-7654', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Bélanger', 'Suzanne', 'suzanne.belanger@example.com', '(250) 265-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lemoine', 'Michel', 'michel.lemoine@example.com', '(778) 555-7654', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Thibault', 'Jacques', 'jacques.thibault@example.com', '(250) 837-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Simard', 'Denis', 'denis.simard@example.com', '(604) 555-9876', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Gauthier', 'Sophie', 'sophie.gauthier@example.com', '(250) 860-5678', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lavigne', 'Claude', 'claude.lavigne@example.com', '(250) 265-9876', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Boucher', 'Julie', 'julie.boucher@example.com', '(778) 555-1234', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Dufresne', 'Jérôme', 'jerome.dufresne@example.com', '(604) 555-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Ouellet', 'Élise', 'elise.ouellet@example.com', '(778) 555-6789', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Côté', 'Sébastien', 'sebastien.cote@example.com', '(250) 265-8765', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Thibault', 'Véronique', 'veronique.thibault@example.com', '(250) 545-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Gauthier', 'Michel', 'michel.gauthier@example.com', '(778) 555-9876', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lemoine', 'Denise', 'denise.lemoine@example.com', '(250) 860-1234', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Bélanger', 'Hélène', 'helene.belanger@example.com', '(250) 837-3456', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Ouellet', 'Pierre', 'pierre.ouellet@example.com', '(778) 555-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Dufresne', 'Félix', 'felix.dufresne@example.com', '(250) 265-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Simard', 'Josée', 'josee.simard@example.com', '(604) 555-8765', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lafleur', 'Vincent', 'vincent.lafleur@example.com', '(250) 837-1234', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Thibault', 'Julien', 'julien.thibault@example.com', '(604) 555-3456', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Boucher', 'Catherine', 'catherine.boucher@example.com', '(250) 265-3456', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Ouellet', 'Clara', 'clara.ouellet@example.com', '(778) 555-7654', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Gauthier', 'Sébastien', 'sebastien.gauthier@example.com', '(250) 545-1234', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lemoine', 'Gabriel', 'gabriel.lemoine@example.com', '(250) 860-3456', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lemoine', 'Jacques', 'jacques.lemoine@example.com', '(604) 555-4321', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Simard', 'Sophie', 'sophie.simard@example.com', '(778) 555-9876', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Thibault', 'René', 'rene.thibault@example.com', '(250) 837-5678', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Dufresne', 'Charlotte', 'charlotte.dufresne@example.com', '(604) 555-8765', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Bélanger', 'Lise', 'lise.belanger@example.com', '(250) 860-9876', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lafleur', 'Gilles', 'gilles.lafleur@example.com', '(778) 555-7654', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Simard', 'Michel', 'michel.simard@example.com', '(250) 837-8765', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Ouellet', 'François', 'francois.ouellet@example.com', '(604) 555-3456', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lemoine', 'Christine', 'christine.lemoine@example.com', '(250) 265-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Boucher', 'Alice', 'alice.boucher@example.com', '(250) 860-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Thibault', 'Pauline', 'pauline.thibault@example.com', '(604) 555-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lemoine', 'Michel', 'michel.lemoine@example.com', '(778) 555-7654', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Simard', 'Josée', 'josee.simard@example.com', '(604) 555-8765', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lafleur', 'Vincent', 'vincent.lafleur@example.com', '(250) 837-1234', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Thibault', 'Julien', 'julien.thibault@example.com', '(604) 555-3456', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Boucher', 'Catherine', 'catherine.boucher@example.com', '(250) 265-3456', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Ouellet', 'Clara', 'clara.ouellet@example.com', '(778) 555-7654', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Gauthier', 'Sébastien', 'sebastien.gauthier@example.com', '(250) 545-1234', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lemoine', 'Gabriel', 'gabriel.lemoine@example.com', '(250) 860-3456', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lemoine', 'Jacques', 'jacques.lemoine@example.com', '(604) 555-4321', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Simard', 'Sophie', 'sophie.simard@example.com', '(778) 555-9876', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Thibault', 'René', 'rene.thibault@example.com', '(250) 837-5678', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Dufresne', 'Charlotte', 'charlotte.dufresne@example.com', '(604) 555-8765', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Bélanger', 'Lise', 'lise.belanger@example.com', '(250) 860-9876', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lafleur', 'Gilles', 'gilles.lafleur@example.com', '(778) 555-7654', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Simard', 'Michel', 'michel.simard@example.com', '(250) 837-8765', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Ouellet', 'François', 'francois.ouellet@example.com', '(604) 555-3456', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lemoine', 'Christine', 'christine.lemoine@example.com', '(250) 265-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Boucher', 'Alice', 'alice.boucher@example.com', '(250) 860-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Thibault', 'Pauline', 'pauline.thibault@example.com', '(604) 555-2345', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Dufresne', 'Alain', 'alain.dufresne@example.com', '(250) 837-4567', 'MotDePasseExemple';
EXEC Clients.USP_CreerClient 'Lemoine', 'François', 'francois.lemoine@example.com', '(778) 555-7654', 'MotDePasseExemple';

ALTER TABLE Clients.PasseSaison CHECK CONSTRAINT FK_PasseSaison_ClientID
ALTER TABLE Clients.Adresse CHECK CONSTRAINT FK_Adresse_ClientID

