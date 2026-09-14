# Example 2

# Load library
library(tidyverse)

# Load data
video_view <- read_csv("data/video_view.csv")

# Summarize content per creator 
creator_example <- video_view %>%
  group_by(creator_id) %>%
  summarise(
    impressions_total = sum(impressions_n, na.rm = TRUE),
    avg_watch_rate = mean(watch_rate, na.rm = TRUE)
  ) %>%
  arrange(desc(impressions_total))
