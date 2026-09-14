# Load the data
library(tidyverse)
video_view <- read_csv("video_view.csv")
user_view <- read_csv("user_view.csv")
videos <- read_csv("videos.csv")
creators <- read_csv("creators.csv")
users <- read_csv("users.csv")
impressions <- read_csv("impressions.csv")
watch_events <- read_csv("watch_events.csv")
sessions <- read_csv("sessions.csv")
        

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

# Exercise 1



# Exercise 2



# Exercise 3



# Exercise 4



# Exercise 5
