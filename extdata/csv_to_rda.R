#csv to rda

library(readr)

# import the csv data

admin <- read_csv("extdata/admin.csv", col_names = FALSE)
animal <- read_csv("extdata/animal.csv", col_names = FALSE)
construction <- read_csv("extdata/construction.csv", col_names = FALSE)
debris <- read_csv("extdata/debris.csv", col_names = FALSE)
degrade <- read_csv("extdata/degrade.csv", col_names = FALSE)
disturbance <- read_csv("extdata/disturbance.csv", col_names = FALSE)
event <- read_csv("extdata/event.csv", col_names = FALSE)
health <- read_csv("extdata/health.csv", col_names = FALSE)
landscape <- read_csv("extdata/landscape.csv", col_names = FALSE)
law <- read_csv("extdata/law.csv", col_names = FALSE)
maintenance <- read_csv("extdata/maintenance.csv", col_names = FALSE)
nature <- read_csv("extdata/nature.csv", col_names = FALSE)
road <- read_csv("extdata/road.csv", col_names = FALSE)
sewer <- read_csv("extdata/sewer.csv", col_names = FALSE)
traffic <- read_csv("extdata/traffic.csv", col_names = FALSE)
waste <- read_csv("extdata/waste.csv", col_names = FALSE)

# we then want to unlist our data, meaning that it will be vectorized. This is neccessary for the later use of dplyr mutate.

admin <- unlist(admin)
animal <- unlist(animal)
construction <- unlist(construction)
debris <- unlist(debris)
degrade <- unlist(degrade)
disturbance <- unlist(disturbance)
event <- unlist(event)
health <- unlist(health)
landscape <- unlist(landscape)
law <- unlist(law)
maintenance <- unlist(maintenance)
nature <- unlist(nature)
road <- unlist(road)
sewer <- unlist(sewer)
traffic <- unlist(traffic)
waste <- unlist(waste)

# then to save as Rda

save(admin, animal, construction, debris, degrade, disturbance, event, health, landscape, law, maintenance, nature, road, sewer, traffic, waste, file = "data/definitions.rda")

