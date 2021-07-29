obamafreq <- read.csv(file.choose())
trumpfreq <- read.csv(file.choose())
cocafreq <- read.csv(file.choose())

#since the percent from csv is read as string not as number, it needs to be converted first
obamafreq$percent <- as.numeric(sub("%","",obamafreq$percent))/100
trumpfreq$percent <- as.numeric(sub("%","",trumpfreq$percent))/100
cocafreq$percent <- as.numeric(sub("%","",cocafreq$percent))/100

## Obama

diffwords <- c()
diffnr <- c()
absolutewords <- c()

for (i in 1:length(obamafreq$words)) {
  diffwords <- c(diffwords, obamafreq$words[i])
  absolutewords <- c(absolutewords, obamafreq$word.freq[i])
  difference = cocafreq$percent[match(obamafreq$words[i], cocafreq$word)] - obamafreq$percent[i]
  diffnr <- c(diffnr, difference)
}

obama.diffdata <- data.frame(diffwords, diffnr, absolutewords)
write.csv(obama.diffdata, file.choose())

## Trump

#reset
diffwords <- c()
diffnr <- c()
absolutewords <- c()

for (i in 1:length(trumpfreq$word)) {
  diffwords <- c(diffwords, trumpfreq$word[i])
  absolutewords <- c(absolutewords, trumpfreq$word.freq[i])
  difference = cocafreq$percent[match(trumpfreq$word[i], cocafreq$word)] - trumpfreq$percent[i]
  diffnr <- c(diffnr, difference)
}

trump.diffdata <- data.frame(diffwords, diffnr, absolutewords)
write.csv(trump.diffdata, file.choose())

# positive difference means used more often, negative means used less often