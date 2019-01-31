context("test csb_projectXY")

# load test data --------------------------------
test_data <- read.csv(system.file("extdata", "testdata.csv", package = "stlcsb"), stringsAsFactors = F)

# test errors -----------------------------------
test_data[4,15] <- NA # Implements an NA for checking of incomplete spatial data

test_that("Missing input errors triggered", {
  expect_error(csb_projectXY(), "Please provide an argument for .data")
  expect_error(csb_projectXY(test_data), "Please provide an argument for varX")
  expect_error(csb_projectXY(test_data, SRX), "Please provide an argument for varY")
  expect_error(csb_projectXY(test_data, SRX, SRY), "Please use the csb_missing with filter = TRUE to remove invalid spatial data before using this function.", fixed = TRUE)
})

# test projection to sf object ------------------
valid <- csb_missingXY(test_data, SRX, SRY, newVar = missing)
valid <- dplyr::filter(valid, missing == FALSE)
sfOut <- csb_projectXY(valid, SRX, SRY, crs = 4326)

test_that("Projection to sf works", {
  expect_equal(class(sfOut)[1], "sf")
})
