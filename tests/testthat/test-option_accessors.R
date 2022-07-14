test_that("set_repo() guards against illegal input", {
  expect_error(set_repo("not a repo"),
               class = "rty.error")
  expect_error(set_repo("not a repo"),
               class = "rty.error.wrong_argument_class")
})

test_that("set_repo()/set_cred() guards against illegal input", {
  expect_error(set_cred("not a repo"),
               class = "rty.error")
  expect_error(set_cred("not a repo"),
               class = "rty.error.wrong_argument_class")
})



test_that("set_repo() sets the repo", {
  # set_repo()
  my_artifactory <- repo("my_artifactory",
                          "https://my_artifactory.myown")

  set_repo(my_artifactory)

  expect_equal(getOption("rty.repos")[["default"]],
               my_artifactory)

})


test_that("set_cred() sets the cred", {
  # set_cred()
  my_cred <- api_key("AKCp8krANVWZTfbZPRNLR18WBvb1WpM34pYiDPw6K6yE2ApdxbtzqwQfZsGM7oeJuCZbsCQNc")

  set_cred(my_cred)

  expect_equal(getOption("rty.creds")[["default"]],
               my_cred)
})

test_that("set_repo() silently overwrites repos with the same name", {
  my_artifactory <- repo("my_repo",
                         "https://my_artifactory.myown")
  set_repo(my_artifactory)

  my_new_artifactory <- repo("my_new_repo",
                             "https://my_artifactory.myown")

  set_repo(my_new_artifactory)

  expect_equal(getOption("rty.repos")[["default"]],
               my_new_artifactory)
})

test_that("set_cred() silently overwrites cred with the same name", {
  my_cred <- api_key("AKCp8krANVWZTfbZPRNLR18WBvb1WpM34pYiDPw6K6yE2ApdxbtzqwQfZsGM7oeJuCZbsCQNc")

  set_cred(my_cred)

  my_new_cred <- token("eyJ2ZXIiOiIyIiwidHlwIjoiSldUIiwiYWxnIjoiUlMyNTYiLCJraWQiOiJmWVBGSERCRGFRTmNBLXd0TmxKMTJwdTEtOHBxSWxyZGpyYjVPai1CU0FJIn0.eyJleHQiOiJ7XCJyZXZvY2FibGVcIjpcInRydWVcIn0iLCJzdWIiOiJqZmFjQDAxZTU0amswcHlmbW5oMXFmZGVxdGYwcDQyXC91c2Vyc1wvc2lxaS56aGFuZy5leHRAYmF5ZXIuY29tIiwic2NwIjoiYXBwbGllZC1wZXJtaXNzaW9uc1wvdXNlciIsImF1ZCI6IipAKiIsImlzcyI6ImpmZmVAMDAwIiwiZXhwIjoxNjgwODc0MTM2LCJpYXQiOjE2NDkzMzgxMzYsImp0aSI6ImQ1Y2NlOWRiLWJkNTUtNGE4ZS05OGU3LTY5MDczYjY0ZWE1ZCJ9.fam2Zac2wqAG64yMYzBi7gy9E48xAnKO-v5MqiU8U06sYnRCSLXdLmPrJqnPodFpjtWh2gSRWKlwCdz_dhqqALehtBtd2S2DZe38cxaJbHtLju3fOFXW2oQRSOIts2dHtSaAeSqhQZK5k28DtXMu_gGPcPBUfW2DB8XKZtKncuArvRkMEgWedsbk98HIXwgrXU49pZGvmvlGopP0tkUvEkpzJr7a6n7c4g2pAkrYUDBpR2OjsT7FStmadRJVsvvXHBhHuUk-2zCXrcgHDrtlTKItg7i2gCKDLKvxkWxcDE7jgA5WxI3N-BHl6H7UvtQyBdbep9vt4SiqUdtdJDKZcQ")

  set_cred(my_new_cred)

  expect_equal(getOption("rty.creds")[["default"]],
               my_new_cred)
})


test_that("set_repo() does not affect repo with different name", {
  my_artifactory <- repo("my_repo",
                         "https://my_artifactory.myown")
  set_repo(my_artifactory,
           "my_artifactory")

  my_new_artifactory <- repo("my_repo",
                         "https://my_artifactory.myown")
  set_repo(my_new_artifactory,
           "my_new_artifactory")

  expect_equal(getOption("rty.repos")[["my_artifactory"]],
               my_artifactory)

  expect_equal(getOption("rty.repos")[["my_new_artifactory"]],
               my_new_artifactory)
})

test_that("set_cred() does not affect cred with different name", {

  my_cred <- api_key("AKCp8krANVWZTfbZPRNLR18WBvb1WpM34pYiDPw6K6yE2ApdxbtzqwQfZsGM7oeJuCZbsCQNc")

  set_cred(my_cred,
           "my_cred")

  my_new_cred <- token("eyJ2ZXIiOiIyIiwidHlwIjoiSldUIiwiYWxnIjoiUlMyNTYiLCJraWQiOiJmWVBGSERCRGFRTmNBLXd0TmxKMTJwdTEtOHBxSWxyZGpyYjVPai1CU0FJIn0.eyJleHQiOiJ7XCJyZXZvY2FibGVcIjpcInRydWVcIn0iLCJzdWIiOiJqZmFjQDAxZTU0amswcHlmbW5oMXFmZGVxdGYwcDQyXC91c2Vyc1wvc2lxaS56aGFuZy5leHRAYmF5ZXIuY29tIiwic2NwIjoiYXBwbGllZC1wZXJtaXNzaW9uc1wvdXNlciIsImF1ZCI6IipAKiIsImlzcyI6ImpmZmVAMDAwIiwiZXhwIjoxNjgwODc0MTM2LCJpYXQiOjE2NDkzMzgxMzYsImp0aSI6ImQ1Y2NlOWRiLWJkNTUtNGE4ZS05OGU3LTY5MDczYjY0ZWE1ZCJ9.fam2Zac2wqAG64yMYzBi7gy9E48xAnKO-v5MqiU8U06sYnRCSLXdLmPrJqnPodFpjtWh2gSRWKlwCdz_dhqqALehtBtd2S2DZe38cxaJbHtLju3fOFXW2oQRSOIts2dHtSaAeSqhQZK5k28DtXMu_gGPcPBUfW2DB8XKZtKncuArvRkMEgWedsbk98HIXwgrXU49pZGvmvlGopP0tkUvEkpzJr7a6n7c4g2pAkrYUDBpR2OjsT7FStmadRJVsvvXHBhHuUk-2zCXrcgHDrtlTKItg7i2gCKDLKvxkWxcDE7jgA5WxI3N-BHl6H7UvtQyBdbep9vt4SiqUdtdJDKZcQ")

  set_cred(my_new_cred, "my_new_cred")


  expect_equal(getOption("rty.creds")[["my_cred"]],
               my_cred)

  expect_equal(getOption("rty.creds")[["my_new_cred"]],
               my_new_cred)
})
