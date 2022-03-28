BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "PostetAv" (
	"brukerID"	INTEGER NOT NULL,
	"smakingID"	INTEGER NOT NULL,
	FOREIGN KEY("brukerID") REFERENCES "Bruker"("brukerID"),
	FOREIGN KEY("smakingID") REFERENCES "SmakingAv"("smakingID"),
	PRIMARY KEY("brukerID","smakingID")
);
CREATE TABLE IF NOT EXISTS "ForedletMed" (
	"art"	TEXT NOT NULL,
	"navn"	TEXT NOT NULL,
	FOREIGN KEY("art") REFERENCES "Kaffebonner"("art"),
	FOREIGN KEY("navn") REFERENCES "Foredlingsmetode"("navn"),
	PRIMARY KEY("art","navn")
);
CREATE TABLE IF NOT EXISTS "Bruker" (
	"brukerID"	INTEGER NOT NULL UNIQUE,
	"epost"	TEXT NOT NULL UNIQUE,
	"passord"	TEXT NOT NULL,
	"navn"	TEXT NOT NULL,
	PRIMARY KEY("brukerID")
);
CREATE TABLE IF NOT EXISTS "Liberica" (
	"art"	TEXT NOT NULL UNIQUE,
	FOREIGN KEY("art") REFERENCES "Kaffebonner"("art"),
	PRIMARY KEY("art")
);
CREATE TABLE IF NOT EXISTS "Lys" (
	"kaffeID"	INTEGER NOT NULL UNIQUE,
	FOREIGN KEY("kaffeID") REFERENCES "FerdibrentKaffe"("kaffeID"),
	PRIMARY KEY("kaffeID")
);
CREATE TABLE IF NOT EXISTS "Middels" (
	"kaffeID"	INTEGER NOT NULL UNIQUE,
	FOREIGN KEY("kaffeID") REFERENCES "FerdibrentKaffe"("kaffeID"),
	PRIMARY KEY("kaffeID")
);
CREATE TABLE IF NOT EXISTS "SmakingAv" (
	"smakingID"	INTEGER NOT NULL UNIQUE,
	"kaffeID"	INTEGER NOT NULL,
	FOREIGN KEY("kaffeID") REFERENCES "FerdibrentKaffe"("kaffeID"),
	FOREIGN KEY("smakingID") REFERENCES "Kaffesmaking"("smakingID"),
	PRIMARY KEY("smakingID","kaffeID")
);
CREATE TABLE IF NOT EXISTS "Arabica" (
	"art"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("art")
);
CREATE TABLE IF NOT EXISTS "Kaffebonner" (
	"art"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("art")
);
CREATE TABLE IF NOT EXISTS "ProdusertAv" (
	"partiID"	INTEGER NOT NULL,
	"gardID"	INTEGER NOT NULL,
	FOREIGN KEY("partiID") REFERENCES "Kaffeparti"("partiID"),
	PRIMARY KEY("gardID","partiID")
);
CREATE TABLE IF NOT EXISTS "Mork" (
	"kaffeID"	INTEGER NOT NULL UNIQUE,
	FOREIGN KEY("kaffeID") REFERENCES "FerdibrentKaffe"("kaffeID"),
	PRIMARY KEY("kaffeID")
);
CREATE TABLE IF NOT EXISTS "Kaffesmaking" (
	"smakingID"	INTEGER NOT NULL UNIQUE,
	"poeng"	INTEGER NOT NULL,
	"smaksAr"	INTEGER NOT NULL,
	"smaksdato"	INTEGER NOT NULL,
	"smaksnotat"	TEXT NOT NULL,
	"brukerID"	INTEGER NOT NULL,
	FOREIGN KEY("brukerID") REFERENCES "Bruker"("brukerID"),
	PRIMARY KEY("smakingID")
);
CREATE TABLE IF NOT EXISTS "Kaffegard" (
	"gardID"	INTEGER NOT NULL UNIQUE,
	"moh"	INTEGER NOT NULL,
	"region"	TEXT NOT NULL,
	"land"	TEXT NOT NULL,
	"gardNavn"	TEXT NOT NULL,
	PRIMARY KEY("gardID")
);
CREATE TABLE IF NOT EXISTS "Kaffeparti" (
	"partiID"	INTEGER NOT NULL UNIQUE,
	"innhostingsAr"	TEXT NOT NULL,
	"kiloprisUSD"	INTEGER NOT NULL,
	"gardID"	INTEGER NOT NULL,
	FOREIGN KEY("gardID") REFERENCES "Kaffegard"("gardID"),
	PRIMARY KEY("partiID")
);
CREATE TABLE IF NOT EXISTS "DyrketAv" (
	"art"	TEXT NOT NULL,
	"gardID"	INTEGER NOT NULL,
	FOREIGN KEY("art") REFERENCES "Kaffebonner"("art"),
	FOREIGN KEY("gardID") REFERENCES "Kaffegard"("gardID"),
	PRIMARY KEY("art")
);
CREATE TABLE IF NOT EXISTS "Foredlingsmetode" (
	"navn"	TEXT NOT NULL UNIQUE,
	"beskrivelse"	TEXT NOT NULL,
	PRIMARY KEY("navn")
);
CREATE TABLE IF NOT EXISTS "Robusta" (
	"art"	TEXT NOT NULL UNIQUE,
	FOREIGN KEY("art") REFERENCES "Kaffebonner"("art"),
	PRIMARY KEY("art")
);
CREATE TABLE IF NOT EXISTS "FramstillesFra" (
	"partiID"	INTEGER NOT NULL,
	"kaffeID"	INTEGER NOT NULL,
	FOREIGN KEY("partiID") REFERENCES "Kaffeparti"("partiID"),
	PRIMARY KEY("partiID","kaffeID")
);
CREATE TABLE IF NOT EXISTS "BestarAv" (
	"partiID"	INTEGER NOT NULL,
	"art"	TEXT NOT NULL,
	PRIMARY KEY("partiID","art"),
	FOREIGN KEY("partiID") REFERENCES "Kaffeparti"("partiID")
);
CREATE TABLE IF NOT EXISTS "FerdibrentKaffe" (
	"kaffeID"	INTEGER NOT NULL UNIQUE,
	"navn"	INTEGER NOT NULL,
	"beskrivelse"	INTEGER NOT NULL,
	"kiloprisNOK"	INTEGER NOT NULL,
	"kaffebrenneri"	TEXT NOT NULL,
	"brenningsgrad"	TEXT NOT NULL,
	"datoBrent"	INTEGER NOT NULL,
	PRIMARY KEY("kaffeID")
);
INSERT INTO "PostetAv" VALUES (1,1);
INSERT INTO "PostetAv" VALUES (1,2);
INSERT INTO "PostetAv" VALUES (1,3);
INSERT INTO "PostetAv" VALUES (2,4);
INSERT INTO "PostetAv" VALUES (2,5);
INSERT INTO "PostetAv" VALUES (3,6);
INSERT INTO "PostetAv" VALUES (3,7);
INSERT INTO "PostetAv" VALUES (3,8);
INSERT INTO "PostetAv" VALUES (3,9);
INSERT INTO "PostetAv" VALUES (3,18);
INSERT INTO "PostetAv" VALUES (3,10);
INSERT INTO "PostetAv" VALUES (3,11);
INSERT INTO "PostetAv" VALUES (3,21);
INSERT INTO "PostetAv" VALUES (3,22);
INSERT INTO "ForedletMed" VALUES ('art1','vasket');
INSERT INTO "ForedletMed" VALUES ('art5IkkeVasket','vasket');
INSERT INTO "ForedletMed" VALUES ('art2','bartorket');
INSERT INTO "ForedletMed" VALUES ('art3','bartorket');
INSERT INTO "ForedletMed" VALUES ('art4','vasket');
INSERT INTO "Bruker" VALUES (1,'herman@ntnu.no','herman123','Herman Seternes');
INSERT INTO "Bruker" VALUES (2,'jonah@ntnu.no','jonah321','Jonah Halseth');
INSERT INTO "Bruker" VALUES (3,'kirt@ntnu.no','kir123','Kir Truhacev');
INSERT INTO "Bruker" VALUES (4,'simen@ntnu.nu','simen','Simen Torgersen');
INSERT INTO "Bruker" VALUES (5,'ola@ntnu.no','olaola','Ola Nordmann');
INSERT INTO "Bruker" VALUES (6,'ntnu@ntnu.no','ntnu','Ntnu ntnu');
INSERT INTO "Liberica" VALUES ('art4');
INSERT INTO "SmakingAv" VALUES (1,1);
INSERT INTO "SmakingAv" VALUES (2,2);
INSERT INTO "SmakingAv" VALUES (3,3);
INSERT INTO "SmakingAv" VALUES (4,2);
INSERT INTO "SmakingAv" VALUES (5,3);
INSERT INTO "SmakingAv" VALUES (6,1);
INSERT INTO "SmakingAv" VALUES (7,2);
INSERT INTO "SmakingAv" VALUES (8,3);
INSERT INTO "SmakingAv" VALUES (9,4);
INSERT INTO "SmakingAv" VALUES (10,5);
INSERT INTO "SmakingAv" VALUES (11,5);
INSERT INTO "SmakingAv" VALUES (17,5);
INSERT INTO "SmakingAv" VALUES (18,1);
INSERT INTO "SmakingAv" VALUES (19,6);
INSERT INTO "SmakingAv" VALUES (20,5);
INSERT INTO "SmakingAv" VALUES (21,4);
INSERT INTO "SmakingAv" VALUES (22,2);
INSERT INTO "Arabica" VALUES ('art1');
INSERT INTO "Arabica" VALUES ('art2');
INSERT INTO "Kaffebonner" VALUES ('art1');
INSERT INTO "Kaffebonner" VALUES ('art2');
INSERT INTO "Kaffebonner" VALUES ('art3');
INSERT INTO "Kaffebonner" VALUES ('art4');
INSERT INTO "Kaffebonner" VALUES ('art5IkkeVasket');
INSERT INTO "ProdusertAv" VALUES (1,1);
INSERT INTO "ProdusertAv" VALUES (2,2);
INSERT INTO "ProdusertAv" VALUES (3,3);
INSERT INTO "ProdusertAv" VALUES (4,4);
INSERT INTO "Kaffesmaking" VALUES (1,0,2020,0,'Wow, for en floral kaffe',1);
INSERT INTO "Kaffesmaking" VALUES (2,8,2020,0,'Verdens beste',1);
INSERT INTO "Kaffesmaking" VALUES (3,7,2021,0,'Bra kaffe',1);
INSERT INTO "Kaffesmaking" VALUES (4,9,2022,0,'ikke så værst',2);
INSERT INTO "Kaffesmaking" VALUES (5,1,2019,0,'bad one',2);
INSERT INTO "Kaffesmaking" VALUES (6,10,2020,0,'good floral kaffe',3);
INSERT INTO "Kaffesmaking" VALUES (7,7,2019,0,'very good',3);
INSERT INTO "Kaffesmaking" VALUES (8,6,2018,0,'good enougb',3);
INSERT INTO "Kaffesmaking" VALUES (9,0,2022,0,'good',3);
INSERT INTO "Kaffesmaking" VALUES (10,10,2022,0,'nice floral kaffe',3);
INSERT INTO "Kaffesmaking" VALUES (11,8,2022,0,'goooood',3);
INSERT INTO "Kaffesmaking" VALUES (12,12,2020,20.03,'good coffee',4);
INSERT INTO "Kaffesmaking" VALUES (13,10,2021,20.03,'floral',4);
INSERT INTO "Kaffesmaking" VALUES (14,10,2020,20.03,'good coffee',4);
INSERT INTO "Kaffesmaking" VALUES (15,10,2020,20.03,'gooooooooodkofe',4);
INSERT INTO "Kaffesmaking" VALUES (16,10,2021,20.03,'bra kaffe',4);
INSERT INTO "Kaffesmaking" VALUES (17,1,1998,20.03,'tastingNow',4);
INSERT INTO "Kaffesmaking" VALUES (18,10,2022,20.03,'blabla',3);
INSERT INTO "Kaffesmaking" VALUES (19,5,2022,'19.02.','notes good notes',4);
INSERT INTO "Kaffesmaking" VALUES (20,10,2021,'14.01.','Fantastisk kaffe',3);
INSERT INTO "Kaffesmaking" VALUES (21,3,2008,'1.1.','floral good',3);
INSERT INTO "Kaffesmaking" VALUES (22,5,2009,20.05,'gg',3);
INSERT INTO "Kaffegard" VALUES (1,1500,'Santa Ana','Rwanda','Nombre de Dios');
INSERT INTO "Kaffegard" VALUES (2,240,'Finmark','Colombia','Palasomo');
INSERT INTO "Kaffegard" VALUES (3,20,'South East','Brasil','Costemaro');
INSERT INTO "Kaffegard" VALUES (4,0,'Nært Colombai','Colombia','Colombia');
INSERT INTO "Kaffeparti" VALUES (1,'2021',8,1);
INSERT INTO "Kaffeparti" VALUES (2,'2019',12,2);
INSERT INTO "Kaffeparti" VALUES (3,'2022',7,3);
INSERT INTO "Kaffeparti" VALUES (4,'1950',1,3);
INSERT INTO "Foredlingsmetode" VALUES ('bartorket','bartorket foredlingsmetode');
INSERT INTO "Foredlingsmetode" VALUES ('vasket','vasket metode');
INSERT INTO "Robusta" VALUES ('art3');
INSERT INTO "FramstillesFra" VALUES (1,1);
INSERT INTO "FramstillesFra" VALUES (2,2);
INSERT INTO "FramstillesFra" VALUES (3,3);
INSERT INTO "FramstillesFra" VALUES (1,4);
INSERT INTO "FramstillesFra" VALUES (2,5);
INSERT INTO "FramstillesFra" VALUES (4,6);
INSERT INTO "BestarAv" VALUES (4,'art5IkkeVasket');
INSERT INTO "BestarAv" VALUES (1,'art1');
INSERT INTO "BestarAv" VALUES (2,'art2');
INSERT INTO "BestarAv" VALUES (3,'art3');
INSERT INTO "BestarAv" VALUES (1,'art5');
INSERT INTO "FerdibrentKaffe" VALUES (1,'Vinterkaffe 2022','En velsmakende og kompleks kaffe for mørketiden',600,'brenneri1','mørk','20.03.22');
INSERT INTO "FerdibrentKaffe" VALUES (2,'Svart kaffe ','grei floral kaffe',450,'brenneri1','middels','19.01.19');
INSERT INTO "FerdibrentKaffe" VALUES (3,'MIddels svart kaffe','god kaffe',340,'brenneri2','lys','20.04.21');
INSERT INTO "FerdibrentKaffe" VALUES (4,'Lys Sommerkaffe Kaffe','Goooood coffe',150,'brenneri2','mørk','20.04.22');
INSERT INTO "FerdibrentKaffe" VALUES (5,'Tidenes kaffe','Tidenes floral kaffe',499,'brenneri3','middels','11.02.21');
INSERT INTO "FerdibrentKaffe" VALUES (6,'Ikke vasket Colombia','Ikke vasket kaffe fra colombia',500,'brenneri4','middels','04.03.20');
COMMIT;
