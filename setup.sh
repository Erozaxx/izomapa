#!/bin/sh
# První spuštění (macOS / Linux): Python prostředí, Node balíčky a Chromium pro renderer.
# Předpoklad: Python 3.9+, Node 18+ (Mac: brew install python node)
set -e
cd "$(dirname "$0")"
python3 -m venv .venv
. .venv/bin/activate
pip install -q --upgrade pip
pip install -q shapely pyproj numpy pillow pyarrow pandas "laspy[lazrs]"
npm install
npx playwright install chromium
echo "Hotovo. Další krok: python novy_mesto.py \"Název obce\"  a pak  ./postav.sh"
