context("test csb_geo")

# load test data --------------------------------
test_data <- read.csv(system.file("extdata", "testdata.csv", package = "stlcsb"), stringsAsFactors = F)

# test errors -----------------------------------
test_data[4,15] <- NA # Implements an NA for checking of incomplete spatial data

test_that("Missing input errors triggered", {
  expect_error(csb_geo(), "Please provide an argument for .data")
  expect_error(csb_geo(test_data), "Please provide an argument for varX")
  expect_error(csb_geo(test_data, SRX), "Please provide an argument for varY")
  expect_error(csb_geo(test_data, SRX, SRY), "Please use the csb_missing with filter = TRUE to remove invalid spatial data before using this function.", fixed = TRUE)
})
