## Need to update documentation to reflect first week of january.
# This function was used to create the .csv of the data. It will be deleted soon.

library(lubridate)
library(dplyr)
library(readr)

# assuming we have already imported and named the data csb
csb %>%
  filter(year(DATETIMEINIT) == 2018) %>%
  filter(month(DATETIMEINIT) == 1) %>%
  filter(day(DATETIMEINIT) %in% c(1:7)) -> jan_1st_week

write_csv(jan_1st_week, "extdata/january_2018.csv")
