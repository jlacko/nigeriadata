test_that("nonsense gets caught", {
  expect_error(poi("asdf")) # not a valid administrative area
  expect_error(poi(c("police", "fuel"))) # a single argument is required
})


test_that("police are OK", {
  expect_true(is.data.frame(poi("police")))
  expect_s3_class(poi("police"), "sf")
  expect_equal(nrow(poi("police")), 802)
  expect_equal(st_crs(poi("police"))$epsg, 4326)
})

test_that("fuel stations are OK", {
  expect_true(is.data.frame(poi("fuel")))
  expect_s3_class(poi("fuel"), "sf")
  expect_equal(nrow(poi("fuel")), 7002)
  expect_equal(st_crs(poi("fuel"))$epsg, 4326)
})
