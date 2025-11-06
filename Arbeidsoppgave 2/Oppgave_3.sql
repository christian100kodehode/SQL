1.Alle bøker publisert etter år 2000:

use ga_bibliotek;
SELECT UtgittÅr, Tittel FROM bok
WHERE UtgittÅr > 2000;

2. Alle Forfatternavn og tittel på alle bøker sortert alfabetisk etter forfatter.

use ga_bibliotek;
SELECT Forfatter, Tittel FROM bok
ORDER BY Forfatter ASC;

3. Alle bøker med mer enn 300 sider

use ga_bibliotek;
SELECT Tittel, AntallSider FROM bok
WHERE AntallSider > 300;

4. Legge til en ny bok i tabellen 'bok'

use ga_bibliotek;
INSERT INTO bok (ISBN, Tittel, Forfatter, Forlag, UtgittÅr, AntallSider)
VALUES 
("4563469687","Amiga: Back Again","Joe, Bill","Boing",2020,188)

5. Legge til en ny låner i tabellen 'låner'

use ga_bibliotek;
INSERT INTO låner (Fornavn, Etternavn, Adresse)
VALUES
("Ole","Idole","Fritzens gate 14")

6. Oppdatere adresse for en spesifikk låner

USE ga_bibliotek;
UPDATE låner
SET Adresse = "Fløteland 56"
WHERE LNr = 1

7. Hente alle utlån sammen med lånerens navn og bokens tittel

use ga_bibliotek;
SELECT u.UtlånsNr AS 'Lån ID', CONCAT(l.Fornavn, ' ',l.Etternavn) AS 'Låner', b.Tittel AS 'Tittel'
FROM utlån u
JOIN låner l ON u.LNr = l.LNr
JOIN bok b ON u.ISBN = b.ISBN
ORDER BY u.UtlånsNr ASC;

8. Alle bøker og antall eksemplarer for hver bok

use ga_bibliotek;
SELECT t.tittel, COUNT(e.EksNr) As 'Eksemplarer'
FROM bok t
LEFT JOIN eksemplar e ON t.ISBN = e.ISBN
GROUP BY t.ISBN, t.Tittel
ORDER BY t.Tittel;

9. Antall utlån per låner

SELECT CONCAT(l.Fornavn, ' ', l.Etternavn) AS Låner, COUNT(u.UtlånsNr) AS 'Antall_lån'
FROM låner l
LEFT JOIN utlån u ON l.LNr = u.LNr
GROUP BY l.LNr, l.Fornavn, l.Etternavn
ORDER BY 'Antall_lån' DESC, Låner;

10. Antall utlån per bok

SELECT b.Tittel, b.Forfatter, COUNT(u.UtlånsNr) AS 'Antall_lån'
FROM bok b
LEFT JOIN eksemplar e ON b.ISBN = e.ISBN
LEFT JOIN utlån u ON e.ISBN = u.ISBN AND e.EksNr = u.EksNr
GROUP BY b.ISBN, b.Tittel, b.Forfatter
ORDER BY Antall_lån DESC, b.Tittel;

11. Alle bøker som ikke har blitt lånt ut

SELECT b.Tittel, b.Forfatter, COUNT(e.EksNr) AS 'Antall_lån'
FROM bok b
LEFT JOIN eksemplar e ON b.ISBN = e.ISBN
LEFT JOIN utlån u ON e.ISBN = u.ISBN AND e.EksNr = u.EksNr
GROUP BY b.ISBN, b.Tittel, b.Forfatter
HAVING COUNT(u.UtlånsNr) = 0
ORDER BY b.Tittel;

12. Forfatter og antall utlånte bøker per forfatter

SELECT b.Forfatter, COUNT(u.UtlånsNr) AS 'Antall_lån'
FROM bok b
LEFT JOIN eksemplar e ON b.ISBN = e.ISBN
LEFT JOIN utlån u ON e.ISBN = u.ISBN AND e.EksNr = u.EksNr
GROUP BY b.Forfatter
ORDER BY Antall_lån DESC, b.Forfatter;