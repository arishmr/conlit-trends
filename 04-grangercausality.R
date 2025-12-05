## GOAL: determine whether reader ratings are causally linked to total length or avg sentence/word length

ts_data <- data %>% arrange(Pubdate) %>% dplyr::select(Pubdate, goodreads_avg, avg_sentence_length)
ts_data <- ts_data %>% group_by(Pubdate) %>% summarise(goodreads_avg = mean(goodreads_avg), avg_sentence_length = mean(avg_sentence_length)) %>% ungroup()
grangertest(goodreads_avg ~ avg_sentence_length, order = 2,
            data = ts_data)


ts_data <- data %>% arrange(Pubdate) %>% dplyr::select(Pubdate, goodreads_avg, avg_word_length)
ts_data <- ts_data %>% group_by(Pubdate) %>% summarise(goodreads_avg = mean(goodreads_avg), avg_word_length = mean(avg_word_length)) %>% ungroup()
grangertest(goodreads_avg ~ avg_word_length, order = 2,
            data = ts_data)


ts_data <- data %>% arrange(Pubdate) %>% dplyr::select(Pubdate, goodreads_avg, token_count)
ts_data <- ts_data %>% group_by(Pubdate) %>% summarise(goodreads_avg = mean(goodreads_avg), token_count = mean(token_count)) %>% ungroup()
grangertest(goodreads_avg ~ token_count, order = 2,
            data = ts_data)

rm(ts_data)
