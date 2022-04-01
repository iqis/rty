test_that("set_repo() sets the repo", {
  my_artifactory <- repo("my_artifactory",
                          "https://my_artifactory.myown")

  set_repo(my_artifactory)

  expect_equal(getOption("rt.repos")[["default"]],
               my_artifactory)
})



test_that("set_repo() overwrites repos with the same name", {
  my_artifactory <- repo("my_repo",
                         "https://my_artifactory.myown")
  set_repo(my_artifactory)

  my_new_artifactory <- repo("my_new_repo",
                             "https://my_artifactory.myown")

  set_repo(my_new_artifactory)

  expect_equal(getOption("rt.repos")[["default"]],
               my_new_artifactory)
})

test_that("set_repo() does not affect repos with different name", {
  my_artifactory <- repo("my_repo",
                         "https://my_artifactory.myown")
  set_repo(my_artifactory,
           "my_artifactory")

  my_new_artifactory <- repo("my_repo",
                         "https://my_artifactory.myown")
  set_repo(my_new_artifactory,
           "my_new_artifactory")

  expect_equal(getOption("rt.repos")[["my_artifactory"]],
               my_artifactory)

  expect_equal(getOption("rt.repos")[["my_new_artifactory"]],
               my_new_artifactory)
})
