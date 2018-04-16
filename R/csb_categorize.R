# First we have to import the category defintions.

load("/Volumes/ULTRA/Prener Lab/stlcsb/Definitions.RData")

# Then we use a mutate function to
mutate(data,
  Category = case_when(
    PROBLEMCODE %in% Admin ~ "Admin",
    PROBLEMCODE %in% Animal ~ "Animal",
    PROBLEMCODE %in% Construction ~ "Construction",
    PROBLEMCODE %in% Debris ~ "Debris",
    PROBLEMCODE %in% Degrade ~ "Degrade",
    PROBLEMCODE %in% Disturbance ~ "Disturbance",
    PROBLEMCODE %in% Event ~ "Event",
    PROBLEMCODE %in% Health ~ "Health",
    PROBLEMCODE %in% Landscape ~ "Landscape",
    PROBLEMCODE %in% Law ~ "Law",
    PROBLEMCODE %in% Maintinence ~ "Maintinence",
    PROBLEMCODE %in% Nature ~ "Nature",
    PROBLEMCODE %in% Road ~ "Road",
    PROBLEMCODE %in% Sewer ~ "Sewer",
    PROBLEMCODE %in% Traffic ~ "Traffic",
    PROBLEMCODE %in% Waste ~ "Waste"))
