#SackDanAndrews analysis

require(rtweet)

api_key <- "ADD YOUR OWN KEY HERE"
api_secret_key <- "ADD YOUR OWN KEY HERE"
access_token <- "ADD YOUR OWN TOKEN HERE"
access_token_secret <- "ADD YOUR OWN TOKEN HERE"

token <- create_token(
  app = "ADD YOUR APP NAME HERE",
  consumer_key = api_key,
  consumer_secret = api_secret_key,
  access_token = access_token,
  access_secret = access_token_secret)

# COLLECTION - tweets containing #sackdanandrews
tweet_search_sackdanandrews <- search_tweets('#sackdanandrews', n = 18000, include_rts = TRUE, retryonratelimit = TRUE)
saveRDS(tweet_search_sackdanandrews, paste0(Sys.time()," tweet_search_sackdanandrews.rds"))

# SAVE TO DISK
library(dplyr)
df_combined_sackdanandrews <- tweet_search_sackdanandrews %>% distinct(status_id, .keep_all = TRUE)
dim(df_combined_sackdanandrews)

# subset only the columns we want to save to disk for analysis in Tableau 
df_combined_sackdanandrews_TO_DISK <- df_combined_sackdanandrews[,c(1:6,14:16,48:62,63:66,82:83)]
write.csv(df_combined_sackdanandrews_TO_DISK,paste0(Sys.time()," tweet_search_sackdanandrews.csv"),row.names = F)

# write tweet IDs to disk
write.table(df_combined_sackdanandrews$status_id,"sackdanandrews_tweet_ids.csv", row.names = F, col.names = F, sep=",")

