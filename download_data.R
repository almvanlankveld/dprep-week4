library(tidyverse)

dir.create("data", showWarnings = FALSE)

base_url <- paste0(
  "https://raw.githubusercontent.com/hannesdatta/",
  "course-dprep/refs/heads/main/material/project/"
)

# TODO: add creators.csv, videos.csv, user_view.csv when published
files <- c(
  "video_view.csv",
  "coaching_2_data/impressions.csv",
  "coaching_2_data/watch_events.csv",
  "coaching_2_data/sessions.csv",
  "coaching_2_data/users.csv"
)

for (f in files) {
  dest <- file.path("data", basename(f))
  if (!file.exists(dest)) download.file(paste0(base_url, f), dest, mode = "wb")
}
