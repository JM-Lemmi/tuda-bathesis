wordfreqtable <- read.csv(file.choose())

text <- c()

for (i in 1:length(wordfreqtable$word.freq)) {
  for (j in 1:(wordfreqtable$word.freq[i]/10000)) {
    text <- c(text, wordfreqtable$word[i])
  }
}
