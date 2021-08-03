## Julian Lemmerich
## 02.08.2021
## Thesis sentiment analysis Chapter 3.7.1 and 3.7.2

## Start of Code

library(syuzhet)
library(readr)
library(ggplot2)


# OBAMA-Korpus
setwd("C:/Users/julian.lemmerich/OneDrive/User Data/Uni/Semester 8/Thesis/Corpora/obama/corpus")
# TRUMP-Korpus
setwd("C:/Users/julian.lemmerich/OneDrive/User Data/Uni/Semester 8/Thesis/Corpora/trump 2-3/corpus")


## Obama Corpus

setwd("C:/Users/julian.lemmerich/OneDrive/User Data/Uni/Semester 8/Thesis/Corpora/obama/corpus")

obama.filelist <- list.files()
obama.sumlist <- c() #sum of sentiment values of each text
obama.meanlist <- c() #mean sentiment of each text
obama.sdlist <- c() #standard deviation of each text
obama.veclist <- list() #list of text sentiment vectors


for (i in 1:length(obama.filelist)) {
  t <- read_file(obama.filelist[i])
  
  poa_word_v <- get_tokens(t, pattern = "\\W")
  syuzhet_vector <- get_sentiment(poa_word_v, method="syuzhet")
  
  obama.veclist[[i]] <- syuzhet_vector
  
  obama.sumlist <- c(obama.sumlist, sum(syuzhet_vector))
  obama.meanlist <- c(obama.meanlist, mean(syuzhet_vector))
  obama.sdlist <- c(obama.sdlist, sd(syuzhet_vector)) #calculates standard deviation
}

obama.sdmean <- mean(obama.sdlist)

oqplot(x=c(1:length(obama.meanlist)), obama.meanlist,
      ylab="Mean Sentiment and Standard Deviation", xlab="Speeches, sorted by time"
      )+geom_errorbar(aes(x=x, ymin=obama.meanlist-obama.sdlist, ymax=obama.meanlist+obama.sdlist), width=0.25)

## Trump

setwd("C:/Users/julian.lemmerich/OneDrive/User Data/Uni/Semester 8/Thesis/Corpora/trump 2-3/corpus")

trump.filelist <- list.files()
trump.sumlist <- c() #sum of sentiment values of each text
trump.meanlist <- c() #mean sentiment of each text
trump.sdlist <- c() #standard deviation of each text
trump.veclist <- list() #list of text sentiment vectors


for (i in 1:length(trump.filelist)) {
  t <- read_file(trump.filelist[i])
  
  poa_word_v <- get_tokens(t, pattern = "\\W")
  syuzhet_vector <- get_sentiment(poa_word_v, method="syuzhet")
  
  trump.veclist[[i]] <- syuzhet_vector
  
  trump.sumlist <- c(trump.sumlist, sum(syuzhet_vector))
  trump.meanlist <- c(trump.meanlist, mean(syuzhet_vector))
  trump.sdlist <- c(trump.sdlist, sd(syuzhet_vector))
}

trump.sdmean <- mean(trump.sdlist)

trump.meansd <- sd(trump.meanlist)

x <- c(1:length(trump.meanlist))
qplot(x, trump.meanlist,
      ylab="Mean Sentiment and Standard Deviation", xlab="Speeches, sorted by time",
      )+geom_errorbar(aes(x=x, ymin=trump.meanlist-trump.sdlist, ymax=trump.meanlist+trump.sdlist), width=0.25)


## Vergleich

sumcomparelist <- list(obama.sumlist, trump.sumlist)
boxplot(sumcomparelist, names=c("Obama", "Trump"), main="Comparison of Sum of Sentiment of the Corpora", ylab="sum of speech sentiment")

meancomparelist <- list(obama.meanlist, trump.meanlist)
boxplot(meancomparelist, names=c("Obama", "Trump"), main="Comparison of Mean Sentiment of the Corpora", ylab="mean speech sentiment")

