context("test csb_filter")

# load test data --------------------------------
test_data <- read.csv(system.file("extdata", "testdata.csv", package = "stlcsb"), stringsAsFactors = F)

# test errors -----------------------------------

test_that("Missing input errors triggered", {
  expect_error(csb_filter(), "Please provide an argument for .data")
  expect_error(csb_filter(test_data), "Please provide an argument for var")
  expect_error(csb_filter(test_data, PROBLEMCODE), "Please provide an argument for category")
  expect_error(csb_filter(test_data, PROBLEMCODE, category = "non-real category"), "Category contains an invalid argument, please see `?csb_filter` for help", fixed = TRUE)
})

# test filtering ----------------------------------
output <- unlist(csb_filter(test_data, "PROBLEMCODE", category = cat_waste)[1])

test_that("Filtering works properly", {
  expect_length(output, 2)
})
