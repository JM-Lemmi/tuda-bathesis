import textstat
import os
import csv

## Obama

file = open('C:\\Users\\julian.lemmerich\\OneDrive\\User Data\\Uni\\Semester 8\\Thesis\\Corpora\\obama\\combined.txt', 'r', encoding='utf8')
obamatext = file.read()

print("Obama")
print("ease: " + str(textstat.flesch_reading_ease(obamatext)))
print("grade: " + str(textstat.flesch_kincaid_grade(obamatext)))

obamanames = []
obamaeasescores = []
obamagradescores = []

for filename in os.listdir('C:\\Users\\julian.lemmerich\\OneDrive\\User Data\\Uni\\Semester 8\\Thesis\\Corpora\\obama\\corpus\\'):
    file = open(str('C:\\Users\\julian.lemmerich\\OneDrive\\User Data\\Uni\\Semester 8\\Thesis\\Corpora\\obama\\corpus\\' + filename), 'r', encoding='utf8')
    text = file.read()

    obamanames.append(filename)
    obamaeasescores.append(textstat.flesch_reading_ease(text))
    obamagradescores.append(textstat.flesch_kincaid_grade(text))

obamaframetemp = [obamanames, obamaeasescores, obamagradescores]
obamaframe = zip(*obamaframetemp) #flips the table from rows to columns
with open('C:\\Users\\julian.lemmerich\\OneDrive\\User Data\\Uni\\Semester 8\\Thesis\\Data\\readability_kincaid_obama.csv', "w", newline='') as f:
    writer = csv.writer(f)
    writer.writerows(obamaframe)

## Trump

file = open('C:\\Users\\julian.lemmerich\\OneDrive\\User Data\\Uni\\Semester 8\\Thesis\\Corpora\\trump 2-3\\combined.txt', 'r', encoding='utf8')
trumptext = file.read()

print()
print("Trump")
print("ease: " + str(textstat.flesch_reading_ease(trumptext)))
print("grade: " + str(textstat.flesch_kincaid_grade(trumptext)))

trumpnames = []
trumpeasescores = []
trumpgradescores = []

for filename in os.listdir('C:\\Users\\julian.lemmerich\\OneDrive\\User Data\\Uni\\Semester 8\\Thesis\\Corpora\\trump 2-3\\corpus\\'):
    file = open(str('C:\\Users\\julian.lemmerich\\OneDrive\\User Data\\Uni\\Semester 8\\Thesis\\Corpora\\trump 2-3\\corpus\\' + filename), 'r', encoding='utf8')
    text = file.read()

    trumpnames.append(filename)
    trumpeasescores.append(textstat.flesch_reading_ease(text))
    trumpgradescores.append(textstat.flesch_kincaid_grade(text))

trumpframetemp = [trumpnames, trumpeasescores, trumpgradescores]
trumpframe = zip(*trumpframetemp) #flips the table from rows to columns
with open('C:\\Users\\julian.lemmerich\\OneDrive\\User Data\\Uni\\Semester 8\\Thesis\\Data\\readability_kincaid_trump.csv', "w", newline='') as f:
    writer = csv.writer(f)
    writer.writerows(trumpframe)