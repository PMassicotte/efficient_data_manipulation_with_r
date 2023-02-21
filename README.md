# Efficient data manipulation with R

I see two different sections:

1. Reshaping data ("atelier d'archivage de QO")
   1. All pivoting operations

   2. Column-based operation (`separate()`, `separate_row()`, `extract()`).

2. Working with data frames.
   1. `mutate()`, `group_by()`, `summarize()`, ...

## Possible topics

- See the Denmark workshop.

- Importing data in R (readr, readxl, data.table).
  - What is a data frame?

- Reading multiple CSV files and combining them into a single data frame.

- [The three common types of problems with data](https://tidyr.tidyverse.org/articles/tidy-data.html)

- Spatial data
  - The `crsuggest` package.

- https://tidydatatutor.com/

## Dataset suggestions

- https://datacarpentry.org/R-ecology-lesson/03-dplyr.html#Reshaping_with_gather_and_spread

- https://swcarpentry.github.io/r-novice-gapminder/14-tidyr/index.html

- https://datacarpentry.org/spreadsheet-ecology-lesson/

- https://datacarpentry.org/OpenRefine-ecology-lesson/

## Notes

- When using the nyflight13 data, have a look to the {bm} package to show the relationships between all the tables.

- https://rstudio-education.github.io/tidyverse-cookbook/index.html

## Exercises

- Try to reproduce `penguins` from `penguins_raw` to practice basic data manipulation functions (mutate, rename, etc.).
