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
vacant <- read_csv("extdata/vacant.csv", col_names = FALSE)

# we then want to unlist our data, meaning that it will be vectorized. This is neccessary for the later use of dplyr mutate.

cat_admin <- unlist(admin)
cat_animal <- unlist(animal)
cat_construction <- unlist(construction)
cat_debris <- unlist(debris)
cat_degrade <- unlist(degrade)
cat_disturbance <- unlist(disturbance)
cat_event <- unlist(event)
cat_health <- unlist(health)
cat_landscape <- unlist(landscape)
cat_law <- unlist(law)
cat_maintenance <- unlist(maintenance)
cat_nature <- unlist(nature)
cat_road <- unlist(road)
cat_sewer <- unlist(sewer)
cat_traffic <- unlist(traffic)
cat_waste <- unlist(waste)
cat_vacant <- unlist(vacant)

# then to save as Rda

usethis::use_data(cat_admin, cat_animal, cat_construction, cat_debris, cat_degrade, cat_disturbance, cat_event, cat_health, cat_landscape, cat_law, cat_maintenance, cat_nature, cat_road, cat_sewer, cat_traffic, cat_waste, cat_vacant)

