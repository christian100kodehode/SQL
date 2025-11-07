
# Bibliotek Database: ga_bibiliotek
[![MySQL Database](./Bilder/mysql.png)](https://github.com/christian100kodehode/SQL.git)

### Introduksjon: ###
_______________________________

SQL skript for **ga_bibliotek**, en relasjonsdatabase for et biblioteksystem. Laget for **MySQL** V:_8.0.33_ med **0utf8mb4** tegnsett for støtte for alle Norske og andre tegn (Full Unicode Support).

Mappestruktur:
```
Bilder/
├─ mysql.png
SQL/
├─ Oppgave_1.sql
├─ Oppgave_3.sql
readme.md
```


<!-- SPACE -->

<br><br><br><br><br><br><br>

<!-- SPACE -->

### Oppgave 1.1 og 1.2: Opprettelse av Databasen og tabellene: ###
_______________________________
Opprettelse av Databasen og Tabellene: [Script for å lage ga_bibiliotek med eksempeldata](./SQL/Oppgave_1.sql)

<!-- SPACE -->

<br><br><br><br><br><br><br>

<!-- SPACE -->

## Oppgave 2: Databaseskjema ###
Databasen består av fire tabeller for å katalogisere bøker, fysiske kopier, lånetakere og utlån

<!-- Tabeller -->

[Bok tabell](#1-bok---boktitler-i-biblioteket) - [Eksemplar tabell](#2-eksemplar---fysiske-eksemplar-av-bøker-i-bibioteket) - [Låner tabell](#3-låner---lånetaker-detaljer) - [Utlån tabell](#4-utlån---lån-som-er-utførtlevert) + [ER Diagram](#er-diagram-ga_database)

[⬆️](#bibliotek-database-ga_bibiliotek)

<!-- SPACE -->

<br><br><br><br><br><br><br>

<!-- SPACE -->

### (1) Tabelltstruktur 1 - 4

## 1. bok - Boktitler i biblioteket.
_______________________________

| Kolonne      | Type          | Vilkår (Constraints)                         | Beskrivelse                                                                 |
|-------------|----------------|----------------------------------------------|-----------------------------------------------------------------------------|
| `ISBN`      | `VARCHAR(17)`  | `PRIMARY KEY`, `UNIQUE`, `NOT NULL`          | Unik bok identifisering. Lagret som en string med opp til 17 tegn (støtte for ISBN-10 og ISBN-13, ISBN-10 kan ha bokstaver og tegn). Raden er hovednøkkel i tabellen og må være unik, ingen andre bøker kan ha den samme verdi. Verdi kan ikke være tom.                                                                                                                                              |
| `Tittel`     | `VARCHAR(100)` | `NOT NULL`                                   | Tittel på bok, opp til hundre tegn. Verdi kan ikke være tom.               |
| `Forfatter`  | `VARCHAR(100)` | `NOT NULL`                                  | Navn på forfatter, opp til hundre tegn. Verdi kan ikke være tom.            |
| `Forlag`     |  `VARCHAR(50)` | `NOT NULL`                                | Navn på forlag, opp til femti tegn. Verdi kan ikk være tom.                   |
| `UtgittÅr`   | `SMALLINT UNSIGNED` | `NOT NULL` `CHECK (UtgittÅr > 1440)`   | Utgitt år, støtter opp til verdi 65535, negative tall ikke tillat (unsigned). Verdi må være over 1440 (Første trykkte bok, Gutenberg Bibelen). Verdi kan ikke være tom.                                                       |
| `AntallSider`| `SMALLINT UNSIGNED` | `NOT NULL` `CHECK (AntallSider BETWEEN 1 AND 10000)` | Antall sider, støtter opp til verdi 65535, negative tall ikke tillat (unsigned). Verdi mellom 1 og 10 000. Verdi kan ikke være tom.                                                                                       |

## **Sammendrag: _bok_ tabell:**
## **En rad for hver unike bok, med ISBN som identifikasjon, tittel, forfatter, forlag, utgittår og antallsider.**

[⬆️](#bibliotek-database-ga_bibiliotek)
<!-- SPACE -->

<br><br><br><br><br><br><br>

<!-- SPACE -->


## 2. eksemplar - Fysiske eksemplar av bøker i bibioteket. 
_______________________________

| Kolonne | Type               |      Vilkår (Constraints)                             |                                                                  |
|---------|--------------------|-------------------------------------------------------|------------------------------------------------------------------|
| `ISBN`  | `VARCHAR(17)`      | `FOREIGN KEY` ` ON DELETE CASCADE` `ON UPDATE CASCADE`| Referer til ISBN i bok tabellen. Kobler bok til spesifikk tittel. Blir ISBN slettet fra bok tabellen blir alle eksemplarer i denne tabellen slettet. Blir ISBN oppdatert blir alle eksemplarer i denne tabellen oppdatert.  |
| `eksnr` | `SMALLINT UNSIGNED`| `NOT NULL`                                            | Eksemplar nummer av bok, opp til 65535 kan ikke være negativ verdi eller tom.                     |

**Hovednøkkel består av begge verdiene: ISBN og eksnr. Sammensatt nøkkel av begge verdier, en unik verdi per bok i biblioteket.**<br>

**Fremmednøkkel: ISBN. Referer til ISBN i bok tabellen. Kobler bok mot ISBN nummer i bok tabellen.**<br>

## **Sammendrag: _eksemplar_ tabell:** ###
## **En rad for hver fysiske kopi av hver bok i bibilioteket dvs. 5 kopier av samme bok blir 5 rader.**

[⬆️](#bibliotek-database-ga_bibiliotek)
<!-- SPACE -->

<br><br><br><br><br><br><br>

<!-- SPACE -->


## 3. låner - Lånetaker detaljer. 
_______________________________

| Kolonne | Type       |  Vilkår (Constraints)     |                                                                   |
|---------|----------------------------------------|------------------------------------|-------------------------------------------------------------------|
| `LNr `  |   `INT`    | `AUTO_INCREMENT`          | Hovednøkkel, blir automatisk generert etter posisjon i tabellen. Brukes som identifikasjon for navn på lånetaker.                                                                                                                                                  |
|Fornavn   | `VARCHAR(100)`   || Fornavn, opp til hundre tegn.  |
|Etternavn | `VARCHAR(100)`   || Etternavn, opp til hundre tegn.|
|Adresse   | `VARCHAR(100)`   || Adressen, opp til hundre tegn. |

## **Sammendrag: _låner_**
## **Data for låner. LNr blir gitt etter posisjon i listen. Inneholder, Fornavn, Etternavn og Adresse.**

[⬆️](#bibliotek-database-ga_bibiliotek)
<!-- SPACE -->

<br><br><br><br><br><br><br>

<!-- SPACE -->


## 4. utlån - Lån som er utført/levert. ##           
_______________________________

| Kolonne | Type       |  Vilkår (Constraints)         |                                                                                               |
|---------|--------------------|-----------------------|-----------------------------------------------------------------------------------------------|
|utlånsnr | `INT`              |`AUTO_INCREMENT`          | Hovednøkkel, unikt nummer for alle lån. Blir automatisk generert etter posisjon i tabellen.|
|Lnr      | `INT`              |`ON DELETE RESTRICT`      | Referer til låner.Lnr Lånetaker                             |
|ISBN     | `BIGINT`           |                          | Referer til eksemplar.ISBN                                  |
|Eksnr    | `SMALLINT UNSIGNED`| `NOT NULL`               | Referer til eksemplar.eksn Eksemplar av bok                 |
|Utlånsdato | `DATE`           |                          | Lånedato, satt til DATE (YYYY-MM-DD)                        |
|Levert    | `BOOLEAN`         |                          | Bare 0 eller 1. (True/False) Levert tilbake = 1 , utlånt = 0|

**Fremmednøkkler: <br>
låner(lNr):`ON DELETE RESTRICT` - Kan ikke slette lånetaker med aktive lån. 
eksemplar(ISBN, EksNr): `ON DELETE RESTRICT` - Kan ikke slette kopi viss er på lån. **

<!-- SPACE -->
<br><br>
<!-- SPACE -->

** active_loan_key - Unngå kopi av bok bli lånt flere ganger, observerte at kopi av bok kunne lånes selv om den var utlånt, en unik nøkkel løser dette. Nøkkel  er ISBN satt sammen med EkSnr (CONCAT verdier med '-' mellom verdiene), når levert er 0 sjekkes denne nøkkel. VIRTUAL rad som kjøres dynamisk etter behov, ikke lagret på disk.**

** Kode: **
`active_loan_key VARCHAR(25)`
    `AS (CASE WHEN Levert = 0 THEN CONCAT(ISBN, '-', EksNr) ELSE NULL END) VIRTUAL,`
`UNIQUE INDEX idx_active_loan (active_loan_key)`


|Levert        | active_loan_key |       Tilgjengelig         |
|--------------|-----------------|----------------------------|
| 0 (utlånt)   | ISBN-EksNr      | Nei, unique index blokkerer|
| 1 (innlevert)| NULL            | Ja - Null - ikke i index   |

Dette gjør at samme kopi ikke lånes på samme tid igjen.

<!-- SPACE -->
<br><br>
<!-- SPACE -->

## **Sammendrag:  ** ###
## En rad for hvert lån. Viser hvem som har lånt spesifik bok og om den er levert tilbake eller ikke. Er kopi av bok utlånt kan den ikke lånes før kopi er levert inn igjen

[⬆️](#bibliotek-database-ga_bibiliotek)


## **ER DIAGRAM: ga_database**



GA BIBLIOTEK DATABASE: MySQL 8.0.33 – utf8mb4_unicode_ci 
_________________________________________________________





         ┌──────────────┐          ┌─────────────────┐
         │    bok       │          │   eksemplar     │
         │              │◄───────1─│  (Fysisk kopi)  │
         ├──────────────┤    *     ├─────────────────┤
         │ ISBN         │─────────>│ ISBN            │
         │ Tittel       │          │ EksNr           │
         │ Forfatter    │          └─────────────────┘
         │ Forlag       │                   │
         │ UtgittÅr     │                   │
         │ AntallSider  │                   │
         └──────────────┘                   │
                                            │
                                            │
                                            ▼
         ┌─────────────────┐          ┌─────────────────┐
         │    låner        │          │     utlån       │
         │ (Borrower)      │◄──────1──│                 │
         ├─────────────────┤    *     ├─────────────────┤
         │ LNr (PN)        │─────────>│ UtlånsNr (PN)   │
         │ Fornavn         │          │ LNr (FN)        │
         │ Etternavn       │          │ ISBN (FN)       │
         │ Adresse         │          │ EksNr (FN)      │
         └─────────────────┘          │ Utlånsdato      │
                                      │ Levert          │
                                      │ active_loan_key │
                                      |  (VIRTUAL)      │
                                      └─────────────────┘
<!--  -->
[⬆️ Tilbake til topp.](#bibliotek-database-ga_bibiliotek)
 <!-- SPACE -->

<br><br><br><br>
<!-- SPACE -->

#### [Oppgave 3 - SQL spørringer](./SQL/Oppgave_3.sql) ####

 <!-- SPACE -->

<br><br><br><br>
<!-- SPACE -->


<!--  -->
[⬆️ Tilbake til topp.](#bibliotek-database-ga_bibiliotek)