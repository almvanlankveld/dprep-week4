# Example 3

library(tidyverse)

# load the data
video_view <- read_csv("data/video_view.csv")
creators <- read_csv("data/creators.csv")
impressions <- read_csv("data/impressions.csv")
watch_events <- read_csv("data/watch_events.csv")

# Merge via left join creators onto video view, by creator id
video_with_creators <- video_view %>%
  left_join(creators, by = "creator_id")

# Merge via inneer join watch events on impressions via impressions_id
watched_only <- impressions %>%
  inner_join(watch_events, by = "impression_id")
