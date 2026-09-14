# Example 4

# Load the library
library(tidyverse)

# Add a column for special time
watch_time_preview <- watch_log %>%
  mutate(
    shown_ts = as.POSIXct(shown_at,
                          format = "%Y-%m-%dT%H:%M:%SZ",
                          tz = "UTC"),
    shown_day = as.Date(shown_ts)
  ) %>%
  select(impression_id, creator_id, shown_at, shown_ts, shown_day) %>%
  head(8)

# Additional example
creator_daily <- watch_log %>%
  mutate(shown_ts = as.POSIXct(shown_at, format = "%Y-%m-%dT%H:%M:%SZ", tz = "UTC")) %>%
  mutate(shown_day = as.Date(shown_ts)) %>%
  count(creator_id, shown_day, name = "impressions_n") %>%
  group_by(creator_id) %>%
  arrange(shown_day) %>%
  mutate(impressions_lag1 = lag(impressions_n))
