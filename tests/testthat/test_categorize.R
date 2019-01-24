context("test csb_categorize")

# load test data --------------------------------
test_data <- read.csv(system.file("extdata", "testdata.csv", package = "stlcsb"), stringsAsFactors = F)

# test errors -----------------------------------

test_that("Missing input errors triggered", {
  expect_error(csb_categorize(), "Please provide an argument for .data")
  expect_error(csb_categorize(test_data), "Please provide an argument for var")
  expect_error(csb_categorize(test_data, PROBLEMCODE), "Please provide an argument for newVar")
})

# test categorization ---------------------------
output <- unlist(csb_categorize(test_data, PROBLEMCODE, Category)["Category"])
names(output) <- NULL
expected <- c("Traffic", "Debris", "Waste", "Debris", "Waste", "Degrade", "Landscape")

test_that("Categorizing by Problemcode", {
  expect_equal(output, expected)
})






