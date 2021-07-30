# Julian Lemmerich
# Thesis
# Textlängengraphen

## Obama

obama.years <- c(2004:2017)
obama.files <- list()
obama.length <- list()

for (i in 1:length(obama.years)) {
  obama.files[[i]] <- list.files(path=paste0('C:/Users/julian.lemmerich/OneDrive/User Data/Uni/Semester 8/Thesis/Corpora/obama by year/', obama.years[i]), pattern="*.txt", full.names=TRUE, recursive=FALSE)
}

for (j in 1:length(obama.files)) {
  obama.length[[j]] <- list()
  for (h in 1:length(obama.files[[j]])) {
    text <- readLines(file(paste0(obama.files[[j]][h])))
    obama.length[[j]][h] <- length(text)
  }
  obama.length[[j]] <- unlist(obama.length[[j]]) #converts the list into a vector, which makes it readable by the boxplot function
}

boxplot(obama.length, names=obama.years, ylim=c(0, 1750), main="Length of speeches by Obama", ylab="Length in Words", xlab="Years")
boxplot(obama.length, names=obama.years, ylim=c(0, 500), main="Length of speeches by Obama", ylab="Length in Words", xlab="Years")


## Trump

trump.years <- c(2015:2021)
trump.files <- list()
trump.length <- list()

for (i in 1:length(trump.years)) {
  trump.files[[i]] <- list.files(path=paste0('C:/Users/julian.lemmerich/OneDrive/User Data/Uni/Semester 8/Thesis/Corpora/trump 2-3 by year/', trump.years[i]), pattern="*.txt", full.names=TRUE, recursive=FALSE)
}

for (j in 1:length(trump.files)) {
  trump.length[[j]] <- list()
  for (h in 1:length(trump.files[[j]])) {
    text <- readLines(file(paste0(trump.files[[j]][h])))
    trump.length[[j]][h] <- length(text)
  }
  trump.length[[j]] <- unlist(trump.length[[j]]) #converts the list into a vector, which makes it readable by the boxplot function
}

boxplot(trump.length, names=trump.years, ylim=c(0, 1750), main="Length of speeches by Trump", ylab="Length in Words", xlab="Years")
boxplot(trump.length, names=trump.years, ylim=c(0, 500), main="Length of speeches by Trump", ylab="Length in Words", xlab="Years")
