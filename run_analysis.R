##run_analysis.R Datei

# Bibliothek laden
library(plyr)

# Projektverzeichnis auf der Festplatte setzen
setwd("D:/Data Science Foundations using R/Getting and Cleaning Data/Woche 4/Project")

# Projektdaten downloaden
if(!file.exists("./saubere_daten")){dir.create("./saubere_daten")}
url <- "http://archive.ics.uci.edu/static/public/240/human+activity+recognition+using+smartphones.zip"
download.file(url, destfile = "./saubere_daten/projektdaten_woche_4.zip")

# Unzippen der Zip-Projektdatei
unzip(zipfile = "./saubere_daten/projektdaten_woche_4.zip", exdir = "./saubere_daten")
unzip(zipfile = "./saubere_daten/UCI HAR Dataset.zip", exdir = "./saubere_daten")


# lese die Merkmale ein
features <- read.table("./saubere_daten/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("./saubere_daten/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

# lese die Testdaten ein
subject_test <- read.table("./saubere_daten/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("./saubere_daten/UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("./saubere_daten/UCI HAR Dataset/test/y_test.txt", col.names = "code")

# lese die Trainingsdaten ein
subject_train <- read.table("./saubere_daten/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("./saubere_daten/UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("./saubere_daten/UCI HAR Dataset/train/y_train.txt", col.names = "code")

# Kombiniere die Trainings- und Testdaten
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

# Filtere nur die Spalten für Mittelwert und Standardabweichung
TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

# Füge Aktivitätsbezeichnungen hinzu
TidyData$code <- activities[TidyData$code, 2]

names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

# Berechne den Durchschnitt für jede Kombination von subjectID und activityID
# Sortiere das Ergebnis nach subjectID und activityID
# Schreibe das Ergebnis in eine Textdatei "tidySet.txt
tidy <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(tidy, "./saubere_daten/tidySet.txt", row.name=FALSE)
