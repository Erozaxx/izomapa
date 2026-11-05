# Izometrické Štěnovice

Větev `mapa/stenovice`, vygenerováno generátorem izomapa (AGPL-3.0-or-later) z otevřených dat.
Publikovaná mapa: https://erozaxx.github.io/izomapa/stenovice/

## Územní rozsah

- Obec Štěnovice, okres Plzeň-jih, Plzeňský kraj. Administrativní hranice obce (admin_level 8), OSM relace 439667, Nominatim.
- Rozloha obce 7,6 km², terén 316 až 487 m n. m. (nula mapy 346,8 m, spodek řezu -61 m).
- Střed `[13.408986, 49.663747]`, čtverec 2,3 x 2,3 km.
- Počet čtverců: 3 (`[0, 1]`, `[-1, 0]`, `[0, 0]`), bez omezení `--max`. Čtverce pokrývají celé území obce, ne jen střed.

## Zdroje dat

- OpenStreetMap přes Overture Maps: budovy (v mapě 2444), adresy, ulice, voda, využití území.
- ČÚZK DMP 1G: výšky budov a tvar střech. ČÚZK ortofoto: maska lesa. ČÚZK ZABAGED: pole a louky.
- Terrarium (AWS Open Data): terén.
- Zdroje jsou uvedeny v patičce nápovědy v prohlížeči, ta musí zůstat.

## Postup sestavení

```
.venv/bin/python novy_mesto.py "Štěnovice" --dotaz "Štěnovice, okres Plzeň-jih, Plzeňský kraj, Česko"
# texty v mesto.json (nazev, titulek, h1, podtitul, popis) podle zadání, ostatní hodnoty z generátoru
DISPLAY=:0 ./postav.sh        # data, výšky, les, pole, scény, render, dlaždice, web
.venv/bin/python compose.py summer 8
```

`mesto.json` je v `.gitignore`, do větve je přidán přes `git add -f`. `build/`, `data*/`, `site/` a log se necommitují.
Poznámka k prostředí: renderer (SwiftShader) v headless Chromiu potřebuje platný X display, na notebooku WSL funguje `DISPLAY=:0`.
Render byl jednou přerušen a po spuštění znovu navázal na hotová data.

## Stav

- Data: staženo pro všechny tři čtverce, výšky z laseru, maska lesa i ZABAGED hotové.
- Render: všechny tři čtverce ve všech čtyřech ročních obdobích (autumn, winter, spring, summer) i noční variantě (lights), `site/` sestaven, stav `hotovo`.
- Náhled: `build/nahled_summer.png` (3217 x 2218), vizuálně zkontrolován: čtverce navazují bez viditelných švů, bez prázdných míst.
- Mapa je nasazena na GitHub Pages (viz odkaz nahoře). Interaktivní chování v prohlížeči nebylo v rámci této práce testováno.

## Zjištěné nedostatky a otevřené věci

- Dominanty: jen Štěnovický zámek (viz níže). Další dominanty ani příběhy míst (`mista.json`) nejsou, chybí ověřené zdroje a fotky.
- Bez MHD (`mhd.gtfs` není vyplněno), bez vánočního stromu.
- Velké sklady na severu mapy jsou z OSM a laseru, nesrovnáno se skutečností.
- Barvy a členění polí (žlutá, tmavě zelená, olivová) vychází ze ZABAGED a sezóny, nesrovnáno s realitou.
- Před zveřejněním je nutné projít mapu a porovnat se skutečností.

## Dominanta: Štěnovický zámek

- Položka v `assets/dominanty.json` (v `.gitignore` není), bod 49.673696, 13.398326 padá dovnitř půdorysu budovy Overture `184c41e6-...` (OSM w259980577, 435 m2). Budova je kreslená ve čtverci `[0, 0]` a v pásu MARGIN čtverce `[0, 1]`, přegenerovány oba.
- Zdroje: web zámku zamekstenovice.cz (rok založení 1723, galerie exteriérů), Wikipedie (Zámek Štěnovice: barokní, jednopatrová stavba se zaoblenými rohy, hranolová věž s hodinami na delší straně u řeky), ortofoto ČÚZK (valbová střecha, barva střechy, poloha věže na straně k řece), laserové výšky (medián 11 m, p90 15 m).
- Model: valbová střecha, zdi 9,5 m, střecha 4,5 m, věž s hodinami 17 m s lucernou do 22 m. Barvy zdí a střechy podle ortofota a fotek z webu zámku (fotky jsou jen předloha, v gitu nejsou).
- Neověřeno: přesná výška věže a tvar její střechy (na fotkách lucerna, zde zjednodušené patrové zakončení), vikýře a komíny, balustráda se sochami (nemodelováno), poloha věže podél průčelí (podle ortofota zhruba uprostřed delší strany, na fotkách spíš u rohu). Pomohly by Tomovy fotky z více stran, hlavně ze severu (vjezd) a z východu.

## Losinský potok

- V `mesto.json` (v `.gitignore`, do větve přes `git add -f`) je klíč `potoky: ["Losinský potok", "Mlýnský potok"]` a `potok_sirka: 2.5` (m). `prep.py` kreslí potoky z tohoto seznamu čárou jako řeku, ale užší; úseky s tagem tunnel nebo covered vynechává. Ostatní potoky se dál nekreslí (zatrubněné úseky v datech).
- Data: Overture water, OSM way 81473053, 6,3 km od Lošiny k Úhlavě, v mapě od východního okraje čtverce `[0, 0]` obcí na západ. U ulice V potocích se v bodě 49.6731, 13.4015 napojuje Mlýnský potok (OSM way 81486958, 1,2 km od 13.392, 49.6682 k napojení, a way 81473213, 130 m dál na sever k Úhlavě), je také v seznamu. Jméno je v datech jen u těchto dvou úseků a žádný jiný potok se tak nejmenuje, oba bez tagu tunnel nebo covered. Potok vede u okraje lesa na západní straně zástavby, dotýká se čtverců `[0, 0]`, `[-1, 0]` a (pásem MARGIN) `[0, 1]`. Tvar odpovídá hrubému náčrtu od Toma.
- Silnice se kreslí přes potok, takže pod mosty a propustky potok na mapě mizí.
