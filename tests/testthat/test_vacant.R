context("test csb_vacant")

# load test data --------------------------------
test_data <- read.csv(system.file("extdata", "testdata.csv", package = "stlcsb"), stringsAsFactors = F)

# test errors -----------------------------------
test_that("Missing input errors triggered", {
  expect_error(csb_vacant(), "Please provide an argument for .data")
  expect_error(csb_vacant(test_data), "Please provide an argument for var")
  expect_error(csb_vacant(test_data, PROBLEMCODE), "Please provide an argument for newVar")
  })

# test logical appending ------------------------
Loutput <- unlist(csb_vacant(test_data, PROBLEMCODE, newVar = vacant)["vacant"])
names(Loutput) <- NULL
expected <- c(F,T,F,T,F,F,F)

test_that("Logical appending works", {
  expect_equal(Loutput, expected)
})

# test filtering --------------------------------
Foutput <- unlist(csb_vacant(test_data, PROBLEMCODE, vacant, filter = T)[1])

test_that("Filtering works", {
  expect_length(Foutput, 2)
})
