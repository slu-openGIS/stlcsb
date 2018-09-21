# create the january 2018 example data

library(devtools)
library(dplyr)
library(readr)

january_2018 <- as_tibble(read_csv("extdata/january_2018.csv"))

use_data(january_2018, overwrite = TRUE)
