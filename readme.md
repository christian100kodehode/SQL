
# ga_bibiliotek: 
En relasjonsdatabase for et biblioteksystem laget for MySQL, med støtte for alle Norske tegn med utf8mb4 tegnesett.



_____________________________________________________
## (1) Tabelltruktur
_____________________________________________________

Tabeller:
1. bok - Bøkene i bilbioteket
Kolonne - Type - Informasjon
ISBN - BIGINT - Hovednøkkel - Unik bok identifikasjon, Bigint hvis ISBN vil gå over 10 siffer (mange ISBN er 13 siffer).
Tittel - VARCHAR(100) - Tittel på bok, opp til hundre tegn.
Forfatter - VARCHAR(100) - Navn på forfatter, opp til hundre tegn.
Forlag - VARCHAR(50) - Navn på forlag, opp til femti tegn.
UtgittÅr - SMALLINT - Utgitt år, støtter opp til 32768 holder for denne kategori og sparer plass.
AntallSider - SMALLINT - Sider på nok, støtter opp til 32768 holder for denne kategori og sparer plass.

En rad for hver unike bok, ingen kopier selv ved flere kopier av samme bok.

2. eksemplar - Fysiske utgaver
Kolonne - Type - Informasjon
ISBN - BIGINT - Referer til bok.ISBN
eksnr - SMALLINT - Eksemplar nummer av bok (opp til 32768 kopier.)
Hovednøkkel - (eksnr, ISBN) - Sammensatt nøkkel, unik for hver fysiske kopi av bøkene.
Fremmednøkkel - ISBN - Referer til bok.ISBN, kobler bok mot ISBN nummer i bok tabellen.

En rad for hver fysiske kopi av bøkene i bibilioteket, 5 kopier av samme bok blir 5 rader.

3. låner - Lånetaker
Kolonne - Type - Informasjon
Lnr - INT AUTO_INCREMENT - Hovednøkkel, blir automatisk generert etter posisjon i tabellen.
Fornavn - VARCHAR(100) - Fornavn, opp til hundre tegn.
Etternavn - VARCHAR(100) - Etternavn, opp til hundre tegn.
Adresse - VARCHAR(100) - Adressen, opp til hundre tegn.

En rad for hver lånetaker.

4. utlån - Lån som er utført/levert
Kolonne - Type - Informasjon
utlånsnr - INT AUTO_INCREMENT - Hovednøkkel, unikt nummer for alle lån. Blir automatisk generert etter posisjon i tabellen.
Lnr - INT - Referer til låner.Lnr
ISBN - BIGINT - Referer til eksemplar.ISBN
Eksnr - Referer til eksemplar.eksnr
Utlånsdato - DATE - Lånedato, satt til DATE (YYYY-MM-DD)
Levert - BOOLEAN - Bare 0 eller 1. Levert tilbake = 1 , utlånt = 0

En rad for hvert lån. Viser hvem som har lånt spesifikk bok og om den er levert tilbake eller ikke.

_____________________________________________________
(2) Primærnøkler og fremmednøkler:
_____________________________________________________




_____________________________________________________
(3) Constraints:
_____________________________________________________


