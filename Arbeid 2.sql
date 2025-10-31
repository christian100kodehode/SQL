CREATE DATABASE IF NOT EXISTS ga_bibliotek
CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE ga_bibliotek;

create TABLE bok (
ISBN VARCHAR(17) UNIQUE NOT NULL,
Tittel VARCHAR(100) NOT NULL,
Forfatter VARCHAR(100) NOT NULL,
Forlag VARCHAR(50) NOT NULL,
UtgittÅr SMALLINT UNSIGNED NOT NULL CHECK (UtgittÅr > 1440),
AntallSider SMALLINT UNSIGNED NOT NULL CHECK (AntallSider BETWEEN 1 AND 10000),
PRIMARY KEY (ISBN)
);

CREATE TABLE eksemplar (
    ISBN VARCHAR(17) NOT NULL,
    EksNr SMALLINT UNSIGNED,
    PRIMARY KEY (ISBN, EksNr),
    FOREIGN KEY (ISBN) REFERENCES bok(ISBN)
                       ON DELETE CASCADE
                       ON UPDATE CASCADE
);

CREATE TABLE låner (
    LNr INT AUTO_INCREMENT,
    Fornavn VARCHAR(100) NOT NULL,
    Etternavn VARCHAR(100) NOT NULL,
    Adresse VARCHAR(100) NOT NULL,
    PRIMARY KEY (LNr)
);

CREATE TABLE utlån (
   UtlånsNr INT AUTO_INCREMENT,
   LNr INT NOT NULL,
   ISBN VARCHAR(17) NOT NULL,
   EksNr SMALLINT UNSIGNED NOT NULL,
   Utlånsdato DATE NOT NULL,
   Levert BOOL NOT NULL DEFAULT 0,
   PRIMARY KEY (UtlånsNr),
   FOREIGN KEY (LNr) REFERENCES låner(LNr)
                   ON DELETE RESTRICT
                   ON UPDATE CASCADE,
    FOREIGN KEY (ISBN, EksNr) REFERENCES eksemplar(ISBN, EksNr)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);



INSERT INTO bok (ISBN, Tittel, Forfatter, Forlag, UtgittÅr, AntallSider)
VALUES 
("8203188443","Kristin Lavransdatter: kransen","Undset, Sigrid","Aschehoug",1920,323),
("8203209394","Fyret: en ny sak for Dalgliesh","James, P. D.","Aschehoug",2005,413),
("8205312443","Lasso rundt fru Luna","Mykle, Agnar","Gyldendal",1954,614),
("8205336148","Victoria","Hamsun, Knut","Gyldendal",1898,111),
("8253025033","Jonas","Bjørneboe, Jens","Pax",1955,302),
("8278442231","Den gamle mannen og havet","Hemingway, Ernest","Gyldendal",1952,99);


INSERT INTO eksemplar (ISBN, EksNr)
VALUES
("8203188443",1),
("8203188443",2),
("8203209394",1),
("8203209394",2),
("8203209394",3),
("8205312443",1),
("8205336148",1),
("8205336148",2),
("8253025033",1),
("8253025033",2),
("8278442231",1);

INSERT INTO låner (Fornavn, Etternavn, Adresse)
VALUES
("Lise","Jensen","Erling Skjalgssons gate 56"),
("Joakim","Gjertsen","Grinda 2"),
("Katrine","Garvik","Ottar Birtings gate 9"),
("Emilie","Marcussen","Kyrre Grepps gate 19"),
("Valter","Eilertsen","Fyrstikkbakken 5D"),
("Tormod","Vaksdal","Lassons gate 32"),
("Asle","Eckhoff","Kirkeveien 5"),
("Birthe","Aass","Henrik Wergelands Allé 47");

INSERT INTO utlån (LNr, ISBN, EksNr, Utlånsdato, Levert)
VALUES
(2,"8203209394",1,"2022-08-25",0),
(2,"8253025033",2,"2022-08-26",1),
(3,"8203188443",1,"2022-09-02",0),
(4,"8278442231",1,"2022-09-02",0),
(2,"8205336148",2,"2022-09-03",0),
(8,"8203209394",2,"2022-09-06",0),
(7,"8205312443",1,"2022-09-11",1);



-- DATA
-- Tabell 'bok':

-- 8203188443,Kristin Lavransdatter: kransen,"Undset, Sigrid",Aschehoug,1920,323
-- 8203209394,Fyret: en ny sak for Dalgliesh,"James, P. D.",Aschehoug,2005,413
-- 8205312443,Lasso rundt fru Luna,"Mykle, Agnar",Gyldendal,1954,614
-- 8205336148,Victoria,"Hamsun, Knut",Gyldendal,1898,111
-- 8253025033,Jonas,"Bjørneboe, Jens",Pax,1955,302
-- 8278442231,Den gamle mannen og havet,"Hemingway, Ernest",Gyldendal,1952,99


-- Tabell 'eksemplar':

-- 8203188443,1
-- 8203188443,2

-- 8203209394,1
-- 8203209394,2

-- 8203209394,3
-- 8205312443,1

-- 8205336148,1
-- 8205336148,2

-- 8253025033,1
-- 8253025033,2
-- 8278442231,1



-- Tabell 'låner':
-- 1,Lise,Jensen,Erling Skjalgssons gate 56
-- 2,Joakim,Gjertsen,Grinda 2
-- 3,Katrine,Garvik,Ottar Birtings gate 9
-- 4,Emilie,Marcussen,Kyrre Grepps gate 19
-- 5,Valter,Eilertsen,Fyrstikkbakken 5D
-- 6,Tormod,Vaksdal,Lassons gate 32
-- 7,Asle,Eckhoff,Kirkeveien 5
-- 8,Birthe,Aass,Henrik Wergelands Allé 47
-- 

-- Tabell 'utlån':

-- 1,2,8203209394,1,2022-08-25,0
-- 2,2,8253025033,2,2022-08-26,1

-- 3,3,8203188443,1,2022-09-02,0
-- 4,4,8278442231,1,2022-09-02,0

-- 5,2,8205336148,2,2022-09-03,0
-- 6,8,8203209394,2,2022-09-06,0
-- 7,7,8205312443,1,2022-09-11,1

