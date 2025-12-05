## GOAL: determine whether total length and avg sentence/word length have changed over time (i.e. is there a significant trend?)

#average sentence length
ts_data <- data %>% arrange(Pubdate) %>% dplyr::select(Pubdate, avg_sentence_length)
ts_data <- ts_data %>% group_by(Pubdate) %>% summarise(avg_sentence_length = mean(avg_sentence_length)) %>% ungroup()
TS = ts(ts_data$avg_sentence_length, start = 2001, end = 2021)
TS
summary(MannKendall(TS))


#average word length
ts_data <- data %>% arrange(Pubdate) %>% dplyr::select(Pubdate, avg_word_length)
ts_data <- ts_data %>% group_by(Pubdate) %>% summarise(avg_word_length = mean(avg_word_length)) %>% ungroup()
TS = ts(ts_data$avg_word_length, start = 2001, end = 2021)
TS
summary(MannKendall(TS))


#total length
ts_data <- data %>% arrange(Pubdate) %>% dplyr::select(Pubdate, token_count)
ts_data <- ts_data %>% group_by(Pubdate) %>% summarise(token_count = mean(token_count)) %>% ungroup()
TS = ts(ts_data$token_count, start = 2001, end = 2021)
TS
summary(MannKendall(TS))


#total length
ts_data <- data %>% arrange(Pubdate) %>% dplyr::select(Pubdate, goodreads_avg)
ts_data <- ts_data %>% group_by(Pubdate) %>% summarise(goodreads_avg = mean(goodreads_avg)) %>% ungroup()
TS = ts(ts_data$goodreads_avg, start = 2001, end = 2021)
TS
summary(MannKendall(TS))

rm(ts_data, TS)

plot(data$Pubdate, data$token_count)
