#csv to rda

library(readr)

# import the csv data

admin <- read_csv("inst/extdata/admin.csv", col_names = FALSE)
animal <- read_csv("inst/extdata/animal.csv", col_names = FALSE)
construction <- read_csv("inst/extdata/construction.csv", col_names = FALSE)
debris <- read_csv("inst/extdata/debris.csv", col_names = FALSE)
degrade <- read_csv("inst/extdata/degrade.csv", col_names = FALSE)
disturbance <- read_csv("inst/extdata/disturbance.csv", col_names = FALSE)
event <- read_csv("inst/extdata/event.csv", col_names = FALSE)
health <- read_csv("inst/extdata/health.csv", col_names = FALSE)
landscape <- read_csv("inst/extdata/landscape.csv", col_names = FALSE)
law <- read_csv("inst/extdata/law.csv", col_names = FALSE)
maintenance <- read_csv("inst/extdata/maintenance.csv", col_names = FALSE)
nature <- read_csv("inst/extdata/nature.csv", col_names = FALSE)
road <- read_csv("inst/extdata/road.csv", col_names = FALSE)
sewer <- read_csv("inst/extdata/sewer.csv", col_names = FALSE)
traffic <- read_csv("inst/extdata/traffic.csv", col_names = FALSE)
waste <- read_csv("inst/extdata/waste.csv", col_names = FALSE)
vacant <- read_csv("inst/extdata/vacant.csv", col_names = FALSE)

# we then want to unlist our data, meaning that it will be vectorized. This is neccessary for the later use of dplyr mutate.

cat_admin <- unname(unlist(admin))
cat_animal <- unname(unlist(animal))
cat_construction <- unname(unlist(construction))
cat_debris <- unname(unlist(debris))
cat_degrade <- unname(unlist(degrade))
cat_disturbance <- unname(unlist(disturbance))
cat_event <- unname(unlist(event))
cat_health <- unname(unlist(health))
cat_landscape <- unname(unlist(landscape))
cat_law <- unname(unlist(law))
cat_maintenance <- unname(unlist(maintenance))
cat_nature <- unname(unlist(nature))
cat_road <- unname(unlist(road))
cat_sewer <- unname(unlist(sewer))
cat_traffic <- unname(unlist(traffic))
cat_waste <- unname(unlist(waste))
cat_vacant <- unname(unlist(vacant))

# then to save as Rda

## In the package, the files are condensed into a single .rda names "categories" now.
save(cat_admin, cat_animal, cat_construction, cat_debris, cat_degrade, cat_disturbance, cat_event, cat_health, cat_landscape, cat_law, cat_maintenance, cat_nature, cat_road, cat_sewer, cat_traffic, cat_waste, cat_vacant, file = "data/categories.rda")
