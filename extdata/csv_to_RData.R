#.csv to RData

library(readr)
library(here)

# import the csv data

Admin <- read_csv(here("extdata/Admin.csv"), col_names = FALSE)
Animal <- read_csv(here("extdata/Animal.csv"), col_names = FALSE)
Construction <- read_csv(here("extdata/Construction.csv"), col_names = FALSE)
Debris <- read_csv(here("extdata/Debris.csv"), col_names = FALSE)
Degrade <- read_csv(here("extdata/Degrade.csv"), col_names = FALSE)
Disturbance <- read_csv(here("extdata/Disturbance.csv"), col_names = FALSE)
Event <- read_csv(here("extdata/Event.csv"), col_names = FALSE)
Health <- read_csv(here("extdata/Health.csv"), col_names = FALSE)
Landscape <- read_csv(here("extdata/Landscape.csv"), col_names = FALSE)
Law <- read_csv(here("extdata/Law.csv"), col_names = FALSE)
Maintenance <- read_csv(here("extdata/Maintenance.csv"), col_names = FALSE)
Nature <- read_csv(here("extdata/Nature.csv"), col_names = FALSE)
Road <- read_csv(here("extdata/Road.csv"), col_names = FALSE)
Sewer <- read_csv(here("extdata/Sewer.csv"), col_names = FALSE)
Traffic <- read_csv(here("extdata/Traffic.csv"), col_names = FALSE)
Waste <- read_csv(here("extdata/Waste.csv"), col_names = FALSE)

# then to save as Rdata

save(Admin, Animal, Construction, Debris, Degrade, Disturbance, Event, Health, Landscape, Law, Maintenance, Nature, Road, Sewer, Traffic, Waste, file = here("data/definitions.RData"))

