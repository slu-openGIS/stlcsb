context("test csb_last_update")

# test output ------------------------

result <- csb_last_update()

test_that("Returns Character", {
  expect_equal("character" %in% class(result), TRUE)
})
