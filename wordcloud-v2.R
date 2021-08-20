library("wordcloud")
library("RColorBrewer")

wordfreqtable <- read.csv(file.choose())

wordcloud(wordfreqtable$diffwords, wordfreqtable$diffbetrag
          , scale=c(5,0.5)
          , max.words=100
          , random.order=FALSE # Words in decreasing freq
          , use.r.layout=FALSE # Use C++ collision detection
          , colors=brewer.pal(8, "Dark2"))

## yearly


wordfreqtable <- read.csv(file.choose(), header = FALSE)

wordcloud(wordfreqtable[[3]], wordfreqtable[[2]]
          , scale=c(5,0.5)
          , max.words=100
          , random.order=FALSE # Words in decreasing freq
          , use.r.layout=FALSE # Use C++ collision detection
          , colors=brewer.pal(8, "Dark2"))
