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

4.