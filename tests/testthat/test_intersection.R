context("test csb_intersection")

# load test data --------------------------------
test_data <- read.csv(system.file("extdata", "testdata.csv", package = "stlcsb"), stringsAsFactors = F)

# test errors -----------------------------------

test_that("Missing input errors triggered", {
  expect_error(csb_intersection(), "Please provide an argument for .data")
  expect_error(csb_intersection(test_data), "Please provide an argument for var")
  expect_error(csb_intersection(test_data, PROBADDRESS), "Please specify at least one argument for newVar, filter or remove")
  expect_error(csb_intersection(test_data, PROBADDRESS, filter = T, remove = T), "Use filter to select only intersections, use remove to remove intersections from the data")
})

# test messaging -------------------------------

test_that("Messaging works properly", {
  expect_message(csb_intersection(test_data, PROBADDRESS, remove = T), "No argument specified for newVar, no logical will be appended")
  expect_message(csb_intersection(test_data, PROBADDRESS, remove = T), "1 observations were removed")
})

# test filtering ------------------------------
Foutput <- unlist(csb_intersection(test_data, PROBADDRESS, filter = T)[1])

test_that("Filtering works properly", {
  expect_length(Foutput, 1)
})

# test removing --------------------------------
Routput <- unlist(csb_intersection(test_data, PROBADDRESS, remove = T)[1])

test_that("Removing works properly", {
  expect_length(Routput, 6)
})
