## Setting up environment
rm(list=ls())
setwd("/Users/Quentyn/Dropbox/DEMETRIA/UC_Berkeley/Fall_2015/ps239t-final-project")

library(tm)
library(RTextTools)
library(lsa)
library(cluster)
library(fpc)

## Prepare data
# load corpus
docs.df <-read.csv("Data/content-ideo.csv", header=TRUE) #read in CSV file
row.names(docs.df) <- docs.df$group
docs.df <- unique(docs.df) #Dataset has some duplicates in it.
docs <- Corpus(VectorSource(docs.df$content))
docs

# make DTM
dtm <- DocumentTermMatrix(docs)
dim(dtm)
inspect(dtm[1:4,100:104])
# convert to matrix
dtm.m <- as.matrix(dtm)

## Hierarchical clustering using cosine metric

# transpose matrix
dtm.t <- t(dtm.m)
# calculate cosine metric
d <- cosine(dtm.t)
# convert to dissimilarity distances
d <- as.dist(1-d) 
# plot hierarchical cluster
fit <- hclust(d)

#Don't try to look at this in R, it's too small.
#Check out crazy_dendrogram in the Results folder
jpeg("Results/crazy_dendrogram.jpeg", width=1600, height=1200, type = "quartz")
plot(fit, labels=docs.df$group)
dev.off()

#There appears to be some clustering by region, but not by ideology.
#Pretty cool looking anyway though.

## Trying out the structural topic modeling.

# This script estimates the STM on women-processed.csv

library(stm)
library(plyr)
rm(list=ls()) #Fresh start here.

#load data 
data <- read.csv("Data/content-ideo.csv")

# custom stopwords - removing names of governments
stopwords.govts <- as.character(data$govt)
stopwords.govts <- tolower(stopwords.govts)

# process
temp<-textProcessor(documents=data$content,metadata=data,customstopwords=stopwords.govts)
meta<-temp$meta
vocab<-temp$vocab
docs<-temp$documents
out <- prepDocuments(docs, vocab, meta, lower.thresh=2)
docs<-out$documents
vocab<-out$vocab
meta <-out$meta

#Removing 14156 of 21996 terms (19188 of 102133 tokens) due to frequency 
#Your corpus now has 126 documents, 7840 terms and 82945 tokens.

# model

model <- stm(docs,vocab, 10, data=meta, seed = 444, max.em.its = 100)

# check out results from clustering on ten topics:
plot.STM(model,type="labels",topics=1:10,width=75)
jpeg("Results/stm.jpeg",width=700,height=1000,type="quartz")
dev.off()

#seems to be both regional and ideological clustering
#some clusters seem to be Asian, Middle Eastern, or African countries
#some also seem to relate to Islamism, nationalism, or democracy
#not too bad considering how little text there was.
