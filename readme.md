
# Bibliotek Database: ga_bibiliotek
[![MySQL Database](https://webuilddatabases.com/wp-content/uploads/2015/03/mysql-icon-250x314.png)](https://github.com/christian100kodehode/SQL.git)

SQL skript for **ga_bibliotek**, en relasjonsdatabase for et biblioteksystem. Laget for **MySQL** med **0utf8mb4** tegnsett for støtte for alle Norske tegn.

## Databaseskjema

Databasen består av fire tabeller for å katalogisere bøker, fysiske kopier, lånetakere og utlån.

### (1) Tabelltstruktur 1 - 4

### 1. "bok" - Boktitler i bilbioteket.

| Kolonne      | Type          | Vilkår (Constraints)                         | Beskrivelse                                                                 |
|-------------|---------------|-----------------------------------------------|-----------------------------------------------------------------------------|
| `ISBN`      | `VARCHAR(17)`      | `PRIMARY KEY`, `UNIQUE`, `NOT NULL`      | Unik bok identifisering. Lagret som en string med opp til 17 tegn (støtte for ISBN-10 og ISBN-13, ISBN-10 kan ha bokstaver og tegn). Raden er hovednøkkel i tabellen og må være unik, ingen andre bøker kan ha den samme verdi. Verdi kan ikke være tom.                                                                |
| `Tittel`    | `VARCHAR(100)`| `NOT NULL`                                    | Tittel på bok, opp til hundre tegn. Verdi kan ikke være tom.                |
| `Forfatter`  | `VARCHAR(100)` | `NOT NULL`                                  | Navn på forfatter, opp til hundre tegn. Verdi kan ikke være tom.            |
| `Forlag`  |  `VARCHAR(50)`   | `NOT NULL`                                   | Navn på forlag, opp til femti tegn. Verdi kan ikke være tom.                |
| `UtgittÅr`   | `SMALLINT UNSIGNED` | `NOT NULL` `CHECK (UtgittÅr > 1440)`            |  Utgitt år, støtter opp til verdi 65535, negative tall ikke tillat (unsigned). Verdi må være over 1440 (Første trykkte bok, Gutenberg Bibelen). Verdi kan ikke være tom.|
| `AntallSider`| `SMALLINT UNSIGNED` | `NOT NULL` `CHECK (AntallSider BETWEEN 1 AND 10000)` |  Antall sider, støtter opp til verdi 65535, negative tall ikke tillat (unsigned). Verdi mellom 1 og 10 000. Verdi kan ikke være tom.|

### **Sammendrag: _bok_ tabell:**
### **En rad for hver unike bok, ingen duplikatrader, selv ved flere kopier av samme boken.**


### 2. "eksemplar" - Fysiske eksemplar av bøker i bibioteket.

| Kolonne | Type       | Constraints    | Vilkår (Constraints)                                               |
|---------|------------|----------------|---------------------------------------------------------|
| `ISBN`  | `VARCHAR(17)`   | `FOREIGN KEY` ` ON DELETE CASCADE` `ON UPDATE CASCADE`  | Referer til ISBN i bok tabellen. Kobler bok til spesifikk tittel. Blir ISBN slettet fra bok tabellen blir alle eksemplarer i denne tabellen slettet. Blir ISBN oppdatert blir alle eksemplarer i denne tabellen oppdatert. |
| `eksnr` | `SMALLINT UNSIGNED`      | `NOT NULL`     | Eksemplar nummer av bok, opp til 65535 kan ikke være negativ verdi eller tom.  |

**Hovednøkkel består av begge verdiene: eksnr og ISBN. Sammensatt nøkkel, dermed unik for hver fysiske kopi av bøkene.**<br>

**Fremmednøkkel: ISBN. Referer til ISBN i bok tabellen. Kobler bok mot ISBN nummer i bok tabellen.**<br>

### **Sammendrag: _eksemplar_ tabell:**
### **En rad for hver fysiske kopi av bøkene i bibilioteket, 5 kopier av samme bok blir 5 rader.**

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


