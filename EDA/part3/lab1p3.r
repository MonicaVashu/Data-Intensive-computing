library(rtweet)
library(twitteR)
library(xlsx)
library(dplyr)
library(stringr)
library(sqldf)

create_token(
  app = "DataClientsForTwitter",
  consumer_key <- "",
  consumer_secret <- "",
  authentication_key <- "",
  authentication_secret <- "")
  
rt <- search_tweets("influenza",geocode = lookup_coords("usa"), n=18000)

rt$symbols <- vapply(rt$symbols, paste, collapse = ", ", character(1L))
rt$hashtags <- vapply(rt$hashtags, paste, collapse = ", ", character(1L))
rt$urls_url <- vapply(rt$urls_url, paste, collapse = ", ", character(1L))
rt$urls_t.co <- vapply(rt$urls_t.co, paste, collapse = ", ", character(1L))
rt$urls_expanded_url <- vapply(rt$urls_expanded_url, paste, collapse = ", ", character(1L))
rt$media_url <- vapply(rt$media_url, paste, collapse = ", ", character(1L))
rt$media_t.co <- vapply(rt$media_t.co, paste, collapse = ", ", character(1L))
rt$media_expanded_url <- vapply(rt$media_expanded_url, paste, collapse = ", ", character(1L))
rt$media_type <- vapply(rt$media_type, paste, collapse = ", ", character(1L))
rt$ext_media_url <- vapply(rt$ext_media_url, paste, collapse = ", ", character(1L))
rt$ext_media_t.co <- vapply(rt$ext_media_t.co, paste, collapse = ", ", character(1L))
rt$ext_media_expanded_url <- vapply(rt$ext_media_expanded_url, paste, collapse = ", ", character(1L))
rt$mentions_user_id <- vapply(rt$mentions_user_id, paste, collapse = ", ", character(1L))
rt$mentions_screen_name <- vapply(rt$mentions_screen_name, paste, collapse = ", ", character(1L))
rt$geo_coords <- vapply(rt$geo_coords, paste, collapse = ", ", character(1L))
rt$coords_coords <- vapply(rt$coords_coords, paste, collapse = ", ", character(1L))
rt$bbox_coords <- vapply(rt$bbox_coords, paste, collapse = ", ", character(1L))
write.csv(rt, 'MyDataforInfluenzaNew.csv')

# Reading the uncleaned tweets obtained with Flu keyword 
fluORInfluenzaKeywordData<-read.csv("MyDataforInfluenzaNew.csv", header = TRUE, sep = ",")
# Removing Re-tweets 
fluORInfluenzaKeywordDataFiltered<-subset(fluORInfluenzaKeywordData,
                                          fluORInfluenzaKeywordData$is_retweet==FALSE)
# Finding the TWO lettered state in User location 
fluORInfluenzaKeywordDataFiltered$location<-str_sub(fluORInfluenzaKeywordDataFiltered$location,start=-2)
# Reading the US states original file 
# Reference:http://www.whypad.com/posts/excel-spreadsheet-of-us-states/583/
USStatesstring <- read.csv("us_states.csv",header = TRUE, sep = ",")
string<-USStatesstring[3]
string <- unlist(string, use.names=FALSE)
# Finding actual state abbreviations in tweet data in User location 
fluORInfluenzaKeywordDataFilteredwithStates<-subset(fluORInfluenzaKeywordDataFiltered, 
                                              fluORInfluenzaKeywordDataFiltered$location %in% string)
# Joining the two dataframes for gettign the enture state name for ploting in Heatmap
finaldataWithfluORInfluenzaKeyword<-sqldf('SELECT * FROM fluORInfluenzaKeywordDataFilteredwithStates 
      LEFT JOIN USStatesstring 
      ON fluORInfluenzaKeywordDataFilteredwithStates.location = USStatesstring.Abbreviation')
# Creating a cleaned CSV file for Flu keyword
write.csv(finaldataWithfluORInfluenzaKeyword, "newInfluenzaKeywordCleanData.csv")



rt <- search_tweets("flu",geocode = lookup_coords("usa"), n=18000)

rt$symbols <- vapply(rt$symbols, paste, collapse = ", ", character(1L))
rt$hashtags <- vapply(rt$hashtags, paste, collapse = ", ", character(1L))
rt$urls_url <- vapply(rt$urls_url, paste, collapse = ", ", character(1L))
rt$urls_t.co <- vapply(rt$urls_t.co, paste, collapse = ", ", character(1L))
rt$urls_expanded_url <- vapply(rt$urls_expanded_url, paste, collapse = ", ", character(1L))
rt$media_url <- vapply(rt$media_url, paste, collapse = ", ", character(1L))
rt$media_t.co <- vapply(rt$media_t.co, paste, collapse = ", ", character(1L))
rt$media_expanded_url <- vapply(rt$media_expanded_url, paste, collapse = ", ", character(1L))
rt$media_type <- vapply(rt$media_type, paste, collapse = ", ", character(1L))
rt$ext_media_url <- vapply(rt$ext_media_url, paste, collapse = ", ", character(1L))
rt$ext_media_t.co <- vapply(rt$ext_media_t.co, paste, collapse = ", ", character(1L))
rt$ext_media_expanded_url <- vapply(rt$ext_media_expanded_url, paste, collapse = ", ", character(1L))
rt$mentions_user_id <- vapply(rt$mentions_user_id, paste, collapse = ", ", character(1L))
rt$mentions_screen_name <- vapply(rt$mentions_screen_name, paste, collapse = ", ", character(1L))
rt$geo_coords <- vapply(rt$geo_coords, paste, collapse = ", ", character(1L))
rt$coords_coords <- vapply(rt$coords_coords, paste, collapse = ", ", character(1L))
rt$bbox_coords <- vapply(rt$bbox_coords, paste, collapse = ", ", character(1L))
write.csv(rt, 'MyDataforInfluenzaNew.csv')


# Reading the uncleaned tweets obtained with Influenza keyword 
influenzaKeywordData<-read.csv("MyDataInfluenza.csv", header = TRUE, sep = ",")
# Removing Re-tweets 
influenzaKeywordDataFiltered<-subset(influenzaKeywordData,influenzaKeywordData$is_retweet==FALSE)
# Finding the TWO lettered state in User location 
influenzaKeywordDataFiltered$location<-str_sub(influenzaKeywordDataFiltered$location,start=-2)
# Reading the US states original file 
# Reference:http://www.whypad.com/posts/excel-spreadsheet-of-us-states/583/
USStatesstring <- read.csv("us_states.csv",header = TRUE, sep = ",")
string<-USStatesstring[3]
string <- unlist(string, use.names=FALSE)
# Finding actual state abbreviations in tweet data in User location 
influenzaKeywordDataFilteredwithStates<-subset(influenzaKeywordDataFiltered, 
                                               influenzaKeywordDataFiltered$location %in% string)
# Joining the two dataframes for gettign the enture state name for ploting in Heatmap
finaldataWithinfluenzaKeyword<-sqldf('SELECT * FROM influenzaKeywordDataFilteredwithStates 
                               LEFT JOIN USStatesstring 
                               ON influenzaKeywordDataFilteredwithStates.location = USStatesstring.Abbreviation')
# Creating a cleaned CSV file for Flu keyword
write.csv(finaldataWithinfluenzaKeyword, "influenzaKeywordCleanData.csv")