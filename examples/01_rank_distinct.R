# Example 1

# Load library
library(tidyverse)

# Load data
video_view <- read_csv("data/video_view.csv")

# Examples
video_simple <- video_view %>%
  mutate(
    watch_rate_rank = rank(-watch_rate),
    high_quality = avg_watch_share >= 0.40
  ) %>%
  distinct(video_id, .keep_all = TRUE)

video_ranked <- video_view %>%
  mutate(
    watch_rate_rank = rank(-watch_rate, na.last = "keep",
    ties.method = "min"))
