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

- Žádné dominanty (`assets/dominanty.json`) ani příběhy míst (`mista.json`). Nepřidáno, protože nejsou ověřené zdroje ani fotky. Vyžaduje fotky od Toma a ověření textů.
- Bez MHD (`mhd.gtfs` není vyplněno), bez vánočního stromu.
- Velké sklady na severu mapy jsou z OSM a laseru, nesrovnáno se skutečností.
- Barvy a členění polí (žlutá, tmavě zelená, olivová) vychází ze ZABAGED a sezóny, nesrovnáno s realitou.
- Před zveřejněním je nutné projít mapu a porovnat se skutečností.
