test_that("assert_argument_class() catches", {

  x <- structure("foo",
                 class = c("my_awsome_text",
                           "my_text"))

  assert_argument_class(x, "my_text")
  assert_argument_class(x, "my_awsome_text")
  expect_error(assert_argument_class(x, "my_super_awsome_text"))
})
