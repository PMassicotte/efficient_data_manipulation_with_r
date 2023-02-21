library(tidyverse)
library(dbplyr)

f <- "https://github.com/NUKnightLab/sql-mysteries/blob/b826bb475eb7c5321ec7ca42ba593dd77c038ab4/sql-murder-mystery.db?raw=true"

tf <- curl::curl_download(f, tempfile())

con <- DBI::dbConnect(RSQLite::SQLite(), tf)

con

tables <- DBI::dbListTables(con)

destdir <- here::here("data", "sql_murder_mystery")
fs::dir_delete(destdir)
fs::dir_create(destdir)

map(tables, \(table) collect(tbl(con, table))) |>
  walk2(tables, \(df, table) {
    destfile <- fs::path(destdir, table, ext = "csv")
    write_csv(df, destfile)
  })

files <- fs::dir_ls(destdir)

walk(files, \(file) {
  assign(tools::file_path_sans_ext(basename(file)), read_csv(file), envir = globalenv())
})

# A crime has taken place and the detective needs your help. The detective gave
# you the crime scene report, but you somehow lost it. You vaguely remember that
# the crime was a murder that occurred sometime on Jan.15, 2018 and that it took
# place in SQL City. Start by retrieving the corresponding crime scene report
# from the police department’s database.

crime_scene_report |>
  filter(date == 20180115, type == "murder" & city == "SQL City") |>
  pull(description)

# Find the witnesses

witnesses <- person |>
  filter(
    (address_street_name == "Northwestern Dr" & address_number == max(address_number)) |
      (str_detect(name, "Annabel") & address_street_name == "Franklin Ave")
  )

# Get information from their interviews

witnesses <- witnesses |>
  left_join(interview, by = c("id" = "person_id"))

witnesses |>
  pull(transcript)

# Use the first transcript

murderer <- get_fit_now_member |>
  filter(str_starts(id, "48Z") & membership_status == "gold") |>
  left_join(person, by = c("person_id" = "id", "name")) |>
  left_join(drivers_license, by = c("license_id" = "id")) |>
  filter(str_detect(plate_number, "H42W")) |>
  select(id, person_id, name)

murderer

# Next challenge

murderer |>
  left_join(interview) |>
  pull(transcript)

potential_contractors <- drivers_license |>
  filter(
    gender == "female",
    between(height, 65, 67),
    hair_color == "red",
    car_make == "Tesla",
    car_model == "Model S"
  )

facebook_event_checkin |>
  filter(event_name == "SQL Symphony Concert") |>
  mutate(date = as.Date(as.character(date), "%Y%m%d")) |>
  filter(format(date, "%Y%m") == "201712") |>
  count(person_id) |>
  filter(n == 3) |>
  left_join(person, by = c("person_id" = "id")) |>
  inner_join(potential_contractors, by = c("license_id" = "id")) |>
  select(name)
