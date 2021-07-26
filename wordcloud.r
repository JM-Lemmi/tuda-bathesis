# Julian Lemmerich
# Thesis
# Word cloud creation

# http://www.sthda.com/english/wiki/text-mining-and-word-cloud-fundamentals-in-r-5-simple-steps-you-should-know

library("tm")
library("SnowballC") # required for stemming?
library("wordcloud")
library("RColorBrewer")

#read the text
text <- readLines(file.choose())

#reading stopwords from file
stopwords <- readLines(file.choose())

# Load the data as a corpus
docs <- Corpus(VectorSource(text))

#cleanup/stopword removal etc
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")

# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove your own stop word
# specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, stopwords) 
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)

# https://lukesingham.com/how-to-make-a-word-cloud-using-r/

wordcloud(docs
          , scale=c(5,0.5)     # Set min and max scale
          , max.words=100      # Set top n words
          , random.order=FALSE # Words in decreasing freq
          , rot.per=0.35       # % of vertical words
          , use.r.layout=FALSE # Use C++ collision detection
          , colors=brewer.pal(8, "Dark2"))
