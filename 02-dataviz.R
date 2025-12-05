## Descriptive stats for total length and average sentence/word length
means <- data %>% group_by(Pubdate) %>% summarise(
  length = mean(token_count),
  sentences = mean(avg_sentence_length),
  words = mean(avg_word_length),
  ratings = mean(goodreads_avg)
) %>% ungroup()

write.csv(means, "results/means.csv", row.names = F)

plotdata <- means %>% pivot_longer(
  cols = c("length", "sentences", "words", "ratings"),
  names_to = "variable",
  values_to = "value"
)
ggplot(data = plotdata, aes(x = Pubdate, y = value, colour = variable)) +
  geom_point(size = 0.5, alpha = 0.75) +
  geom_line(stat = "smooth", method = "loess", se = FALSE) +
  facet_wrap(~ factor(variable), scales="free_y") +
  labs(x = "Year", y = "Value", colour = "") +
  theme_classic() +
  theme(panel.spacing.x = unit(1, "lines")) +
  theme(panel.spacing.y = unit(1.5, "lines")) +
  theme(legend.position = "none") +
  scale_color_brewer(palette="Set1") +
  theme(axis.title = element_text(face="bold"))


## Historical trends in publishing: time series of total length and average sentence/word length

plotdata <- data %>% pivot_longer(
  cols = c("avg_word_length", "token_count", "avg_sentence_length", "goodreads_avg"),
  names_to = "variable",
  values_to = "value"
)
plotdata <- plotdata %>%
  mutate(
    variable = case_match(variable,
                          "avg_word_length" ~ "Average Word Length",
                          "token_count" ~ "Total Character Count",
                          "avg_sentence_length" ~ "Average Sentence Length",
                          "goodreads_avg" ~ "Average Goodreads Rating"))
plotdata$variable <- factor(plotdata$variable, levels = c("Average Sentence Length", "Average Word Length", "Total Character Count", "Average Goodreads Rating"))
ggplot(data = plotdata, aes(x = Pubdate, y = value, colour = variable)) +
  geom_point(size = 0.2, alpha = 0.2) +
  geom_line(stat = "smooth", method = "loess", se = FALSE) +
  facet_wrap(~ factor(variable), scales="free_y") +
  labs(x = "Year", y = "Value", colour = "") +
  theme_classic() +
  theme(panel.spacing.x = unit(1, "lines")) +
  theme(panel.spacing.y = unit(1.5, "lines")) +
  theme(legend.position = "none") +
  scale_color_brewer(palette="Set1") +
  theme(axis.title = element_text(face="bold"))
ggsave("figures/trends.png", dpi = 300, width = 8)



## scale all relevant continuous variables, so that we get standardised coefficients
plotdata <- data %>% mutate(across(
  .cols = c(token_count, total_characters, protagonist_concentration, avg_sentence_length, avg_word_length, tuldava_score,
            event_count, speed_avg, circuitousness, speed_min, volume, goodreads_avg, total_ratings, Probability1P),
  .fns = ~ scale(.)[,1]
))

plotdata <- plotdata %>% pivot_longer(
  cols = c("avg_word_length", "token_count", "avg_sentence_length"),
  names_to = "variable",
  values_to = "value"
)
plotdata <- plotdata %>%
  mutate(
    variable = case_match(variable,
                          "avg_word_length" ~ "Average Word Length",
                          "token_count" ~ "Total Character Count",
                          "avg_sentence_length" ~ "Average Sentence Length"))
ggplot() +
  geom_line(data = plotdata, aes(x = Pubdate, y = value, colour = variable), stat = "smooth", method = "loess", se = FALSE) +
  geom_line(data = plotdata, aes(x = Pubdate, y = goodreads_avg, linetype = "Avg Goodreads Rating"), stat = "smooth", method = "loess", se = FALSE, colour = "darkorchid4") +
  facet_grid(~ factor(variable), scale="free") +
  labs(x = "Year", y = "Z-score", colour = "", linetype = "") +
  guides(colour = "none") +
  theme_classic() +
  theme(panel.spacing.x = unit(1, "lines")) +
  theme(panel.spacing.y = unit(1.5, "lines")) +
  theme(legend.position = "bottom") +
  scale_color_brewer(palette="Set1") +
  theme(axis.title = element_text(face="bold"))
ggsave("figures/trends_x_ratings.png", dpi = 300, width = 8)

rm(plotdata)
