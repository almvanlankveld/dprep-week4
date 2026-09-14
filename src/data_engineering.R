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
library(dplyr)
library(readr)

video_features <- video_view %>%
  mutate(
    watch_rate_rank = rank(-watch_rate),
    reach_band = case_when(
      ntile(impressions_n, 3) == 1 ~ "Low",
      ntile(impressions_n, 3) == 2 ~ "Medium",
      ntile(impressions_n, 3) == 3 ~ "High"
    ),
    high_quality = avg_watch_share >= 0.40
  ) %>%
  distinct(video_id, .keep_all = TRUE)

write_csv(video_features, "temp/video_features.csv")

video_features %>%
  arrange(watch_rate_rank) %>%
  slice_head(n = 10)



# Exercise 2
creator_summary <- video_features %>%
  group_by(creator_id) %>%
  summarise(
    videos_n = n(),
    impressions_total = sum(impressions_n, na.rm = TRUE),
    watched_total = sum(watched_n, na.rm = TRUE),
    avg_watch_rate = mean(watch_rate, na.rm = TRUE),
    median_watch_seconds = median(
      avg_watch_seconds_when_watched,
      na.rm = TRUE
    ),
    .groups = "drop"
  ) %>%
  arrange(desc(impressions_total))


engagement_by_band <- video_features %>%
  group_by(reach_band) %>%
  summarise(
    videos_n = n(),
    avg_watch_rate = mean(watch_rate, na.rm = TRUE),
    .groups = "drop"
  )


write_csv(
  creator_summary,
  "temp/creator_summary.csv"
)

write_csv(
  engagement_by_band,
  "temp/engagement_by_band.csv"
)

# Exercise 3
video_with_creators <- video_view %>%
  left_join(creators, by = "creator_id")
watched_only <- impressions %>%
  inner_join(watch_events, by = "impression_id")

# -----------------------------
# 1. Build video_enriched
# -----------------------------

video_enriched <- video_features %>%
  left_join(
    videos,
    by = c("video_id", "creator_id")
  ) %>%
  left_join(
    creators,
    by = "creator_id"
  ) %>%
  select(
    video_id,
    creator_id,
    creator_name,
    impressions_n,
    watch_rate,
    watch_rate_rank,
    quality,
    posting_rate,
    publish_time
  )


# -----------------------------
# 2. Build user_enriched
# -----------------------------

user_enriched <- user_view %>%
  left_join(
    users,
    by = "user_id"
  )


# -----------------------------
# 3. Save outputs
# -----------------------------

write_csv(
  video_enriched,
  "temp/video_enriched.csv"
)

write_csv(
  user_enriched,
  "temp/user_enriched.csv"
)


# Exercise 4
# 1. Build event-level watch_log
watch_log <- impressions %>%
  left_join(
    watch_events,
    by = "impression_id",
    suffix = c("", "_watch")
  ) %>%
  left_join(
    sessions,
    by = c("session_id", "user_id")
  ) %>%
  left_join(
    videos,
    by = c("video_id", "creator_id")
  ) %>%
  left_join(
    creators,
    by = "creator_id"
  )


# 2. Keep impressions that have a watch event
watched_only <- impressions %>%
  inner_join(
    watch_events,
    by = "impression_id"
  )


# 3. Create creator event summary
creator_event_summary <- watch_log %>%
  group_by(
    creator_id,
    creator_name
  ) %>%
  summarise(
    impressions = n_distinct(impression_id),
    watched_events = sum(!is.na(watch_event_id)),
    total_watch_seconds = sum(watch_seconds.y, na.rm = TRUE),
    .groups = "drop"
  )


# 4. Save outputs
write_csv(watch_log, "temp/watch_log.csv")
write_csv(
  creator_event_summary,
  "temp/creator_event_summary.csv"
)



# Exercise 5
watch_time_preview <- watch_log %>%
  mutate(
    shown_ts = as.POSIXct(shown_at,
                          format = "%Y-%m-%dT%H:%M:%SZ",
                          tz = "UTC"),
    shown_day = as.Date(shown_ts)
  ) %>%
  select(impression_id, creator_id, shown_at, shown_ts, shown_day) %>%
  head(8)

creator_daily <- watch_log %>%
  mutate(
    shown_ts = as.POSIXct(
      shown_at,
      format = "%Y-%m-%dT%H:%M:%SZ",
      tz = "UTC"
    ),
    shown_day = as.Date(shown_ts)
  ) %>%
  count(creator_id, shown_day, name = "impressions_n") %>%
  group_by(creator_id) %>%
  arrange(shown_day) %>%
  mutate(
    impressions_lag1 = lag(impressions_n)
  )
                               






