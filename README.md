# Chrome Profile Launcher

Ein PowerShell-Skript, das alle verfügbaren Google Chrome Profile auf deinem System erkennt, die zugehörigen E-Mail-Adressen (sofern vorhanden) anzeigt und dann Chrome mit jedem Profil in einem neuen Fenster startet.

---

## Funktionen

- Automatische Suche aller Chrome-Profile auf dem lokalen Rechner  
- Anzeige der Profilnamen und zugehörigen E-Mail-Adressen  
- Startet Chrome mit jedem gefundenen Profil in einem eigenen Fenster  
- Meldungen und Fehlerbehandlung für nicht gefundene Profile oder Chrome-Installation

---

## Voraussetzungen

- Windows-Betriebssystem mit installiertem Google Chrome  
- PowerShell (Version 5 oder höher empfohlen)

---

## Nutzung

1. Skript in PowerShell ausführen (ggf. Ausführungsrichtlinien anpassen mit `Set-ExecutionPolicy`)  
2. Das Skript sucht automatisch alle Chrome-Profile und startet für jedes ein eigenes Chrome-Fenster  

---

## Beispiel

```powershell
.\chrome-profile-launcher.ps1
