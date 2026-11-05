# Izometrická Louka u Litvínova

Větev `mapa/louka-u-litvinova`, vygenerováno generátorem izomapa (AGPL-3.0-or-later) z otevřených dat.

## Územní rozsah

- Obec Louka u Litvínova, okres Most, Ústecký kraj. Administrativní hranice obce (admin_level 8), OSM relace 440209, Nominatim.
- Rozloha obce 2,7 km², terén 272 až 322 m n. m. (nula mapy 294,8 m, spodek řezu -54 m).
- Střed `[13.628257, 50.587523]`, čtverec 2,3 x 2,3 km (`polovina` 1150 m).
- Počet čtverců: 1 (`[0, 0]`). Čtverec je větší než obec, pokrývá celé území a část okolí.

## Zdroje dat

- OpenStreetMap přes Overture Maps: budovy, silnice, voda, využití území, místa, adresy.
- ČÚZK DMP 1G: výšky budov a tvar střech. ČÚZK ortofoto: maska lesa. ČÚZK ZABAGED: pole a louky.
- Terrarium (AWS Open Data): terén.
- Zdroje jsou uvedeny v patičce nápovědy v prohlížeči, ta musí zůstat.

## Postup sestavení

```
.venv/bin/python novy_mesto.py "Louka u Litvínova" --dotaz "Louka u Litvínova, okres Most, Ústecký kraj, Česko"
# texty v mesto.json (nazev, titulek, h1, podtitul, popis) podle zadání, ostatní hodnoty z generátoru
DISPLAY=:0 ./postav.sh        # data, výšky, les, pole, scéna, render, dlaždice, web
.venv/bin/python compose.py summer 8
```

`mesto.json` je v `.gitignore`, do větve je přidán přes `git add -f`. `build/`, `data/`, `site/` a log se necommitují.
Poznámka k prostředí: renderer (SwiftShader) v headless Chromiu potřebuje platný X display, na notebooku WSL funguje `DISPLAY=:0`.

## Stav

- Data: staženo (2877 budov, 48 míst, 17 částí obce), výšky z laseru, maska lesa i ZABAGED hotové.
- Render: proběhl pro všechny čtyři roční období (autumn, winter, spring, summer) i noční variantu (lights), `site/` je sestaven, stav `hotovo`.
- Náhled: `build/nahled_summer.png` (2200 x 1195), vizuálně zkontrolován.
- Interaktivní web (`npm run nahled`) v prohlížeči neotevřen, ověřen je jen statický náhled a vznik `site/index.html`.

## Zjištěné nedostatky a otevřené věci

- Žádné dominanty (`assets/dominanty.json`) ani příběhy míst (`mista.json`). Nepřidáno, protože nejsou ověřené zdroje ani fotky. Vyžaduje fotky od Toma a ověření textů.
- Bez MHD (`mhd.gtfs` není vyplněno), bez vánočního stromu.
- Na náhledu jsou v severovýchodní a východní části světle zelené plochy s hranatými okraji a tmavší olivové plochy (pole a louky z ZABAGED). Nesrovnáno s realitou.
- Oranžové plochy na severu a u zástavby (pravděpodobně holá půda nebo sklad) nejsou ověřené, nic se jim neupravovalo.
- Průmyslové areály, železnice a silnice vycházejí z OSM, mapa nebyla porovnána se skutečností.
- Před zveřejněním je nutné projít mapu a porovnat se skutečností.
