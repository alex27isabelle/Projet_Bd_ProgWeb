CREATE TABLE Versants.Remontee(
RemonteeID int IDENTITY (1,1) NOT NULL,
Nom nvarchar(15) NOT NULL,
Longeur int NOT NULL,
TempEnMinute int NOT NULL,
Vitesse decimal(4,2) NOT NULL,
NbPylone int NOT NULL,
Type nvarchar(30) NOT NULL,
AnneeConstruction int NOT NULL,
VersantID int NOT NULL,
CONSTRAINT PK_Remontee_RemonteeID PRIMARY KEY (RemonteeID)
);

CREATE TABLE Versants.Piste(
PisteID int IDENTITY (1,1) NOT NULL,
Nom nvarchar(30) NOT NULL,
Longeur int NOT NULL,
Difficulte nvarchar(20) NOT NULL,
EstSousBois bit NOT NULL,
VersantID int NOT NULL,
CONSTRAINT PK_Piste_PisteID PRIMARY KEY (PisteID)
);

CREATE TABLE Versants.Versant(
VersantID int IDENTITY (1,1) NOT NULL,
Nom char(10) NOT NULL,
AltituteMaxChaise int NOT NULL,
CONSTRAINT PK_Versant_VersantID PRIMARY KEY (VersantID)
);

CREATE TABLE Clients.Client(
ClientID int IDENTITY (1,1) NOT NULL,
Nom nvarchar(20) NOT NULL,
Prenom nvarchar(30) NOT NULL,
Courriel nvarchar(50) NOT NULL,
NumTel nvarchar(15) NOT NULL,
CONSTRAINT PK_Client_ClientID PRIMARY KEY (ClientID)
);

CREATE TABLE Clients.Adresse(
AdresseID int IDENTITY (1,1) NOT NULL,
NumPorte int NOT NULL,
NumAppartement int,
Rue nvarchar(50) NOT NULL,
CodePostal char(7) NOT NULL,
Ville nvarchar(50) NOT NULL,
Province nvarchar(50) NOT NULL,
ClientID int NOT NULL,
CONSTRAINT PK_Adresse_AdresseID PRIMARY KEY (AdresseID)
);

CREATE TABLE Clients.PasseSaison(
PasseSaisonID int IDENTITY (1,1) NOT NULL,
Type nvarchar(10) NOT NULL,
ClientID int NOT NULL,
CONSTRAINT PK_PasseSaison_PasseSaisonID PRIMARY KEY (PasseSaisonID)
);

CREATE TABLE Clients.AchatPasseSaison(
AchatPasseSaisonID int IDENTITY (1,1) NOT NULL,
PasseSaisonID int NOT NULL,
DateAchat Date NOT NULL,
CONSTRAINT PK_AchatPasseSaison_AchatPasseSaisonID PRIMARY KEY (AchatPasseSaisonID)
)

CREATE TABLE Clients.Visite(
VisiteID int IDENTITY (1,1) NOT NULL,
DateVisite Date NOT NULL,
PasseSaisonID int NOT NULL
CONSTRAINT PK_Visite_visiteID PRIMARY KEY (VisiteID)
);

CREATE TABLE Clients.Descente(
DescenteID int IDENTITY (1,1) NOT NULL,
HeureDescente time NOT NULL,
PisteID int NOT NULL,
VisiteID int NOT NULL
CONSTRAINT PK_Descente_DescenteID PRIMARY KEY (DescenteID)
);

GO

ALTER TABLE Versants.Remontee ADD CONSTRAINT FK_Remontee_VersantID FOREIGN KEY(VersantID)
REFERENCES Versants.Versant(VersantID)
ON DELETE CASCADE
GO

ALTER TABLE Versants.Piste ADD CONSTRAINT FK_Piste_VersantID FOREIGN KEY(VersantID)
REFERENCES Versants.Versant(VersantID)
ON DELETE CASCADE
Go

ALTER TABLE Clients.Adresse ADD CONSTRAINT FK_Adresse_ClientID FOREIGN KEY(ClientID)
REFERENCES Clients.Client(ClientID)
GO

ALTER TABLE Clients.PasseSaison ADD CONSTRAINT FK_PasseSaison_ClientID FOREIGN KEY(ClientID)
REFERENCES Clients.Client(ClientID)
GO

ALTER TABLE Clients.Visite ADD CONSTRAINT FK_Visite_PasseSaisonID FOREIGN KEY(PasseSaisonID)
REFERENCES Clients.PasseSaison(PasseSaisonID)
GO

ALTER TABLE Clients.Descente ADD CONSTRAINT FK_Descente_PisteID FOREIGN KEY(PisteID)
REFERENCES Versants.Piste(PisteID) 
GO

ALTER TABLE Clients.Descente ADD CONSTRAINT FK_Descente_VisiteID FOREIGN KEY(VisiteID)
REFERENCES Clients.Visite(VisiteID)

ALTER TABLE Clients.AchatPasseSaison ADD CONSTRAINT FK_AchatPasseSaison_PasseSaisonID FOREIGN KEY(PasseSaisonID)
REFERENCES Clients.PasseSaison(PasseSaisonID)

GO

ALTER TABLE Versants.Piste ADD CONSTRAINT UC_Piste_Nom UNIQUE (Nom)
GO
ALTER TABLE Versants.Piste ADD CONSTRAINT CK_Piste_Difficulte CHECK (Difficulte in ('Vert', 'Bleu', 'Noir', 'Double Noir'))
GO
ALTER TABLE Versants.Piste ADD CONSTRAINT DF_Piste_EstSousBois DEFAULT 0 FOR EstSousBois
GO
