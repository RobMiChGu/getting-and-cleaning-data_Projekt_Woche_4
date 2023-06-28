# Code-Book für Projekt: Getting and Cleaning Data - Woche 4

## Woher bekomme ich das Datenset?
1. Downladen der Projektdaten und unzippen der Zip-Dateien in ein Projektverzeichnis (Arbeitsverzeichnis RStudio)

1. Ausführen des R-Scripts "run_analysis.R"
2. Smartphones Dataset wird durch das R-Script von der Quelldaten-Seite heruntergeladen und entpackt (unzip)

## Zu den Daten
Die Quelldaten stammen vom "Human Activity Recognition Using Smartphones Data Set Version 1.0" 
http://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones

Link zur Datendatei: http://archive.ics.uci.edu/static/public/240/human+activity+recognition+using+smartphones.zip

## R-Script
R-Code "run_analysis.R" beinhaltet:
- Führt die Trainings- und Testsätze zusammen, um einen Datensatz zu erstellen.
- Extrahiert nur die Messungen zum Mittelwert und zur Standardabweichung für jede Messung.
- Verwendet beschreibende Aktivitätsnamen, um die Aktivitäten im Datensatz zu benennen
- Beschriften Sie den Datensatz entsprechend mit beschreibenden Variablennamen.
- Erstellt aus dem Datensatz in Schritt 4 einen zweiten, unabhängigen, aufgeräumten Datensatz mit dem Durchschnitt jeder Variablen für jede Aktivität und jedes Thema.

.
.
R-Script Code Dokumentation, step by step

lese die Merkmale ein
lese die Testdaten ein
lese die Trainingsdaten ein

Kombiniere die Trainings- und Testdaten

Filtere nur die Spalten für Mittelwert und Standardabweichung

Füge Aktivitätsbezeichnungen hinzu

Berechne den Durchschnitt für jede Kombination von subjectID und activityID
Sortiere das Ergebnis nach subjectID und activityID
Schreibe das Ergebnis in eine Textdatei "tidySet.txt
