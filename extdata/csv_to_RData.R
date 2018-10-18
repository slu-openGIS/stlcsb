#csv to rda

library(readr)

# import the csv data

Admin <- read_csv("extdata/Admin.csv", col_names = FALSE)
Animal <- read_csv("extdata/Animal.csv", col_names = FALSE)
Construction <- read_csv("extdata/Construction.csv", col_names = FALSE)
Debris <- read_csv("extdata/Debris.csv", col_names = FALSE)
Degrade <- read_csv("extdata/Degrade.csv", col_names = FALSE)
Disturbance <- read_csv("extdata/Disturbance.csv", col_names = FALSE)
Event <- read_csv("extdata/Event.csv", col_names = FALSE)
Health <- read_csv("extdata/Health.csv", col_names = FALSE)
Landscape <- read_csv("extdata/Landscape.csv", col_names = FALSE)
Law <- read_csv("extdata/Law.csv", col_names = FALSE)
Maintenance <- read_csv("extdata/Maintenance.csv", col_names = FALSE)
Nature <- read_csv("extdata/Nature.csv", col_names = FALSE)
Road <- read_csv("extdata/Road.csv", col_names = FALSE)
Sewer <- read_csv("extdata/Sewer.csv", col_names = FALSE)
Traffic <- read_csv("extdata/Traffic.csv", col_names = FALSE)
Waste <- read_csv("extdata/Waste.csv", col_names = FALSE)

# we then want to unlist our data, meaning that it will be vectorized. This is neccessary for the later use of dplyr mutate.

Admin <- unlist(Admin)
Animal <- unlist(Animal)
Construction <- unlist(Construction)
Debris <- unlist(Debris)
Degrade <- unlist(Degrade)
Disturbance <- unlist(Disturbance)
Event <- unlist(Event)
Health <- unlist(Health)
Landscape <- unlist(Landscape)
Law <- unlist(Law)
Maintenance <- unlist(Maintenance)
Nature <- unlist(Nature)
Road <- unlist(Road)
Sewer <- unlist(Sewer)
Traffic <- unlist(Traffic)
Waste <- unlist(Waste)

# then to save as Rdata

save(Admin, Animal, Construction, Debris, Degrade, Disturbance, Event, Health, Landscape, Law, Maintenance, Nature, Road, Sewer, Traffic, Waste, file = "data/definitions.rda")

