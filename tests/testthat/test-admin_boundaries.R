test_that("nonsense gets caught", {
  expect_error(areas("asdf")) # not a valid administrative area
  expect_error(areas(c("state", "lga"))) # a single argument is required
})


test_that("states are OK", {
  expect_true(is.data.frame(areas("state")))
  expect_s3_class(areas("state"), "sf")
  expect_equal(nrow(areas("state")), 37)
  expect_equal(st_crs(areas("state"))$epsg, 4326)
})


test_that("LGAs are OK", {
  expect_true(is.data.frame(areas("lga")))
  expect_s3_class(areas("lga"), "sf")
  expect_equal(nrow(areas("lga")), 774)
  expect_equal(st_crs(areas("lga"))$epsg, 4326)
})


test_that("wards are OK", {
  expect_true(is.data.frame(areas("ward")))
  expect_s3_class(areas("ward"), "sf")
  expect_equal(nrow(areas("ward")), 8809)
  expect_equal(st_crs(areas("ward"))$epsg, 4326)
})
