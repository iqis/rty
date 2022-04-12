test_that("api_key() guards against illegal input", {
  expect_warning(api_key("an string that's obviously not 73 characters"),
               class = c("rt.warning"))
  expect_warning(api_key("an string that's obviously not 73 characters"),
               class = c("rt.warning.malformed_api_key"))
})

test_that("api_key() returns expected class", {
  key <- "AKCp8krANVWZTfbZPRNLR18WBvb1WpM34pYiDPw6K6yE2ApdxbtzqwQfZsGM7oeJuCZbsCQNc"

  expect_s3_class(api_key(key), "rt.cred")
  expect_s3_class(api_key(key), "rt.cred.api_key")
})

test_that("token() guards against illegal input", {
  expect_warning(token("obviously not 795 characters"),
                 class = "rt.warning")

  expect_warning(token("obviously not 795 characters"),
                 class = "rt.warning.malformed_token")
})

test_that("token() returns expected class", {
  token <- "eyJ2ZXIiOiIyIiwidHlwIjoiSldUIiwiYWxnIjoiUlMyNTYiLCJraWQiOiJmWVBGSERCRGFRTmNBLXd0TmxKMTJwdTEtOHBxSWxyZGpyYjVPai1CU0FJIn0.eyJleHQiOiJ7XCJyZXZvY2FibGVcIjpcInRydWVcIn0iLCJzdWIiOiJqZmFjQDAxZTU0amswcHlmbW5oMXFmZGVxdGYwcDQyXC91c2Vyc1wvc2lxaS56aGFuZy5leHRAYmF5ZXIuY29tIiwic2NwIjoiYXBwbGllZC1wZXJtaXNzaW9uc1wvdXNlciIsImF1ZCI6IipAKiIsImlzcyI6ImpmZmVAMDAwIiwiZXhwIjoxNjgwODc0MTM2LCJpYXQiOjE2NDkzMzgxMzYsImp0aSI6ImQ1Y2NlOWRiLWJkNTUtNGE4ZS05OGU3LTY5MDczYjY0ZWE1ZCJ9.fam2Zac2wqAG64yMYzBi7gy9E48xAnKO-v5MqiU8U06sYnRCSLXdLmPrJqnPodFpjtWh2gSRWKlwCdz_dhqqALehtBtd2S2DZe38cxaJbHtLju3fOFXW2oQRSOIts2dHtSaAeSqhQZK5k28DtXMu_gGPcPBUfW2DB8XKZtKncuArvRkMEgWedsbk98HIXwgrXU49pZGvmvlGopP0tkUvEkpzJr7a6n7c4g2pAkrYUDBpR2OjsT7FStmadRJVsvvXHBhHuUk-2zCXrcgHDrtlTKItg7i2gCKDLKvxkWxcDE7jgA5WxI3N-BHl6H7UvtQyBdbep9vt4SiqUdtdJDKZcQ"

  expect_s3_class(token(token), "rt.cred")
  expect_s3_class(token(token), "rt.cred.token")

})
