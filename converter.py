import re
import sqlite3

# SQLite-Datenbank-Datei (ändern, falls dein Dateiname anders ist)
sqlite_db_file = "deine_datenbank.sqlite"
output_sql_file = "converted_postgres.sql"

# Verbindung zur SQLite-Datenbank
conn = sqlite3.connect(sqlite_db_file)
cursor = conn.cursor()

# SQLite Dump abrufen
with open(output_sql_file, "w", encoding="utf-8") as f:
    for line in conn.iterdump():
        # Syntax-Anpassungen für PostgreSQL
        line = re.sub(r"AUTOINCREMENT", "SERIAL", line)  # AUTOINCREMENT -> SERIAL
        line = re.sub(r"INTEGER PRIMARY KEY", "SERIAL PRIMARY KEY", line)  # PRIMARY KEY Fix
        line = re.sub(r"TEXT", "VARCHAR(255)", line)  # TEXT -> VARCHAR(255)

        # SQLite-sequenzierte Tabellen entfernen
        if "sqlite_sequence" in line:
            continue

        f.write(line + "\n")

# Verbindung schließen
conn.close()
print(f"✅ Konvertierung abgeschlossen! Datei gespeichert als: {output_sql_file}")
