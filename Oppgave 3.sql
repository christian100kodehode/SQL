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

10. Antall utlån per bok

11. Alle bøker som ikke har blitt lånt ut

12. Forfatter og antall utlånte bøker per forfatter