context("test csb_projectXY")

# load test data --------------------------------
data(january_2018, package = "stlcsb")

# test errors -----------------------------------

test_that("Missing input errors triggered", {
  expect_error(csb_projectXY(), "Please provide an argument for .data")
  expect_error(csb_projectXY(january_2018), "Please provide an argument for varX")
  expect_error(csb_projectXY(january_2018, srx), "Please provide an argument for varY")
  expect_error(csb_projectXY(january_2018, srx, sry), "Please use the csb_missing with filter = TRUE to remove invalid spatial data before using this function.", fixed = TRUE)
})

# test projection to sf object ------------------
valid <- csb_missingXY(january_2018, srx, sry, newVar = missing)
valid <- dplyr::filter(valid, missing == FALSE)
sfOut <- csb_projectXY(valid, srx, sry, crs = 4326)

test_that("Projection to sf works", {
  expect_equal(class(sfOut)[1], "sf")
})

# test unquoted and quoted input -----------------------------

test_that("Non-standard Evaluation works", {
  expect_silent(csb_projectXY(valid, "srx", "sry"))
  expect_silent(csb_projectXY(valid, srx, sry))
})
