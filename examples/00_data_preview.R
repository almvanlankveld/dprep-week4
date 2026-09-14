# Load the library
library(tidyverse)

# Load the data
video_view <- read_csv("data/video_view.csv")

# Inspect the data
video_view %>%
  select(video_id, creator_id, impressions_n, watched_n, watch_rate, avg_watch_share) %>%
  head(6)


# ---- Data preview at the event level

impressions <- read_csv("data/impressions.csv")
watch_events <- read_csv("data/watch_events.csv")

impressions %>%
  select(impression_id, session_id, user_id, video_id, creator_id, shown_at) %>%
  head(6)