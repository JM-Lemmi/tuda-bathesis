## Julian Lemmerich
## 03.08.2021
## Thesis
## The goal is to calculate sentiment of snippets in proximity to a certain word or word group.

library(syuzhet)

library(quanteda)
library(dplyr)
library(stringr)
library(knitr)
library(kableExtra)
#TODO eliminate unneeded libraries

#reading the files and converting the to a tokenized corpus
obama.corpus <- c()
setwd("C:\\Users\\julian.lemmerich\\OneDrive\\User Data\\Uni\\Semester 8\\Thesis\\Corpora\\obama\\corpus")
files <- list.files(pattern=".txt", full.names=TRUE)
for (f in files) {
  text <- paste(readLines(f, encoding="UTF-8"), collapse=" ")
  obama.corpus <- c(obama.corpus, text)
}
obama.corpus <- tokens(obama.corpus)

trump.corpus <- c()
setwd("C:\\Users\\julian.lemmerich\\OneDrive\\User Data\\Uni\\Semester 8\\Thesis\\Corpora\\trump 2-3\\corpus")
files <- list.files(pattern=".txt", full.names=TRUE)
for (f in files) {
  text <- paste(readLines(f, encoding="UTF-8"), collapse=" ")
  trump.corpus <- c(trump.corpus, text)
}
trump.corpus <- tokens(trump.corpus)

#mean of corpus
totalmean.obama <- 0.027 #obama
totalmean.trump <- 0.034 #trump

#setting variables
#phrases with space need to be wrapped in phrase(), * is a valid wildcard
findword <- c("Corona", "COVID", "pandemic", "virus", "vaccin*") #searched word or list of words, when running with multiple corpora, the word needs to be listed twice
p <- 50 #number words before and after the searched that should be included in this analysis (a value of 50 means 101 words in total will be analysed)
#TODO filter dirty data (spaces)

#generating findword label, for plot later
findwordlabel <- findword

#one corpus
corpus <- trump.corpus
kwiclist <- list()
for (j in (1:length(findword))) {
  kwiclist[[j]] <- kwic(corpus, pattern=findword[j], window=p, case_insensitive=TRUE)
}

#multiple corpora
#doubling findwordlist for multiple corpora
findwordtemp <- findword
findword <- c()
for (m in (1:length(findwordtemp))) {
  findword <- c(findword, findwordtemp[m], findwordtemp[m])
}
findwordlabel <- findword

#multiple corpora
#starting kwic analysis
kwiclist <- list()
l <- 0 #l is set to 0 to start with obama corpus, 1 for trump
for (j in (1:length(findword))) {
  if (l == 0) { #running with obama
    kwiclist[[j]] <- kwic(obama.corpus, pattern=findword[j], window=p, case_insensitive=TRUE)
    findwordlabel[j] <- paste0(findwordlabel[j], "\n(Obama)") #adding corpus name to label
    l <- 1
  }
  else if (l == 1) { #running with obama
    kwiclist[[j]] <- kwic(trump.corpus, pattern=findword[j], window=p, case_insensitive=TRUE)
    findwordlabel[j] <- paste0(findwordlabel[j], "\n(Trump)") #adding corpus name to label
    l <- 0
  }
}

## Calculating the Sentiment
#lists for a single kwic
veclist <- list()
meanvec <- c()
sdvec <- c()

#sammlung aller kwic listen
veclistlist <- list()
meanlist <- list()
sdlist <- list()

for (k in (1:length(kwiclist))){ #iterating over all kwiclists
  #clearing the lists for the next loop
  veclist <- list()
  meanvec <- c()
  sdvec <- c()
  
  if (length(kwiclist[[k]]$keyword > 0)) { #this if clause stops an error in execution, if the keyword does not appear in the corpus at all.
    
    for (i in (1:length(kwiclist[[k]]$keyword))) { #iterating over all elements in one kwic
      piece <- paste(kwiclist[[k]]$pre[i], kwiclist[[k]]$keyword[i], kwiclist[[k]]$post[i], sep=" ") #making the pre, kw and post into one string
      poa_word_v <- get_tokens(piece, pattern = "\\W") #tokenizing the piece
      syuzhet_vector <- get_sentiment(poa_word_v, method="syuzhet") #get sentiment from tokenized piece
    
      veclist[[i]] <- syuzhet_vector #adding the original syuzhet vector to a list for later analysis
      
      meanvec <- c(meanvec, mean(syuzhet_vector)) #calculating mean and sd of one text
      sdvec <- c(sdvec, sd(syuzhet_vector))
    }
    
  }
  
  #adding to kwic-listen
  veclistlist[[k]] <- veclist
  meanlist[[k]] <- meanvec
  sdlist[[k]] <- sdvec
}

#generating at and col values for boxplot
#colours are pretty simple, just abwechselnd blue and red for the length of the list.
colours <- c()
for (n in 1:(length(findwordlabel)/2)) {
  colours <- c(colours, "#8080ff", "#ff8080")
}
#at values are a bit more complicated: the schema is c(1:2, 4:5, 7:8, ...)
atv <- c()
p <- 1
for (o in 1:(length(findwordlabel)/2)) {
  atv <- c(atv, p, p+1)
  p <- p+3
}

#if the labels are too large for the plot, the Corpus association can be dropped here
findwordlabel <- findword
#TODO flatten all vectors

#creating the plot
boxplot(meanlist, names=findwordlabel,
        at=atv,
        col=colours,
        main="Sentiment in Proximity, Topic \"Corona\"", ylab="Average Sentiment", xlab="Word (Corpus)")
#adding abline for totalmean of obama
abline(h=totalmean.obama)
text(0.2, totalmean.obama-0.007, "Obama")
#adding abline for totalmean of trump
abline(h=totalmean.trump)
text(0.2, totalmean.trump+0.007, "Trump")
print("done")
