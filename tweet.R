library(devtools)
library(twitteR)
library(syuzhet)
# save credentials
requestURL = "https://api.twitter.com/oauth/request_token"
accessURL = "https://api.twitter.com/oauth/access_token"
authURL = "https://api.twitter.com/oauth/authorize"

consumerKey = "uDRIFbDDnhQxSnBfZUVVsGTC0"
consumerSecret = "bhZ1UW9CPUEnBq7dqnQ4ChX1O1JTSgAZGNDr6Y7phVUq94CPHT"
  
accessToken = "747117718944518149-eJP10l1JPpjfz8H5ezAhc4vCEwIWYgS"
accessSecret = "XynbdbMIwbbaFAXehzMTvFr9F6zo2IvkfXdRjnY9OTGGS"
  
setup_twitter_oauth(consumerKey,
                    consumerSecret,
                    accessToken,
                    accessSecret)

# harvest some tweets
some_tweets = searchTwitter('starbucks', n=100, lang='en')

# get the text
some_txt = sapply(some_tweets, function(x) x$getText())

# remove retweet entities
some_txt = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", some_txt)
# remove at people
some_txt = gsub("@\\w+", "", some_txt)
# remove punctuation
some_txt = gsub("[[:punct:]]", "", some_txt)
# remove numbers
some_txt = gsub("[[:digit:]]", "", some_txt)
# remove html links
some_txt = gsub("http\\w+", "", some_txt)
# remove unnecessary spaces
some_txt = gsub("[ \t]{2,}", "", some_txt)
some_txt = gsub("^\\s+|\\s+$", "", some_txt)

# define "tolower error handling" function 
try.error = function(x)
{
  # create missing value
  y = NA
  # tryCatch error
  try_error = tryCatch(tolower(x), error=function(e) e)
  # if not an error
  if (!inherits(try_error, "error"))
    y = tolower(x)
  # result
  return(y)
}

some_txt = sapply(some_txt, try.error)
# remove NAs in some_txt
some_txt = some_txt[!is.na(some_txt)]
names(some_txt) = NULL

syuzhet_vector <- get_sentiment(some_txt, method="syuzhet")


library(httr)
library(devtools)
install_github("aloth/sentiment/sentiment")
install_github("b2b-web-id/omegahat-Rstem")
install.packages("Rstem", repos = "http://www.omegahat.org/R", type = "source")
devtools::install_version('Rstem', '0.4-1')
install.packages("Rstem", repos = "http://www.omegahat.org/R")

