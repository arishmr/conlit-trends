## LOAD AND CLEAN DATASET
rm(list=ls())
data <- read.csv("data/CONLIT_META.csv")

## Clean data
data[data == ""] <- NA
data <- data %>%
  mutate(
    Category = case_match(Category,
    "FIC" ~ "Fiction",
    "NON" ~ "Nonfiction"),
    Genre = case_match(Genre,
    "BIO" ~ "Biography",
    "BS" ~ "Bestseller",
    "HIST" ~ "History",
    "MEM" ~ "Memoir",
    "MID" ~ "Middle School",
    "MIX" ~ "Assorted Nonfiction",
    "MY" ~ "Mystery",
    "NYT" ~ "NYT Reviewed",
    "PW" ~ "Prize Shortlisted",
    "ROM" ~ "Romance",
    "SF" ~ "SciFi or Fantasy",
    "YA" ~ "Young Adult")
)

data <- data %>% mutate(Author = paste0(data$Author_First, " ", data$Author_Last)) %>%
  relocate(Author, .before = Author_Last)

##### CONVERT VARIABLES TO APPROPRIATE CATEGORIES

data <- data %>%
  mutate(across(c(
    Pubdate, token_count, total_characters, protagonist_concentration, avg_sentence_length, avg_word_length, tuldava_score,
    event_count, speed_avg, circuitousness, speed_min, volume, goodreads_avg, total_ratings, Probability1P
  ), as.numeric))


data <- data %>%
  mutate(across(c(
    ID, Category, Language, Genre, Genre2, Author, Author_Last, Author_First, Work_Title, Translation,
    PubHouse, Prize, WinnerShortlist, Author_Gender, Author_Nationality
  ), as.factor))

## Convert Pubdate to Date format
data$Pubdate <- lubridate::ymd(data$Pubdate, truncated = 2L)