context("test csb_load_variables")

# test errors ------------------------

test_that("Missing input errors triggered", {
  expect_error(csb_load_variables(tidy = "ham"),
               "Input for the 'tidy' argument is invalid - it must be either 'TRUE' or 'FALSE'.")
})

# test output ------------------------

test1 <- csb_load_variables(tidy = TRUE)
test2 <- csb_load_variables(tidy = FALSE)

test_that("expected output", {
  expect_equal(nrow(test1), 17)
  expect_equal(test1$Name[1], "requestid")
  expect_equal(nrow(test2), 19)
  expect_equal(test2$Name[1], "CALLERTYPE")
})
