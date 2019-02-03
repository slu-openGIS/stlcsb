## Need to update documentation to reflect first week of january.
# This function was used to create the .csv of the data.

library(lubridate)
library(dplyr)
library(readr)

# assuming we have already imported and named the data csb
csb %>%
  dplyr::filter(year(datetimeinit) == 2018) %>%
  dplyr::filter(month(datetimeinit) == 1) %>%
  dplyr::filter(day(datetimeinit) %in% c(1:7)) -> jan_1st_week

readr::write_csv(jan_1st_week, "inst/extdata/january_2018.csv")
