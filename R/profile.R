#' Artifactory Profile
#'
#' An Artifactory profile is the combination of Repository and Credentials.
#'
#' @param repo repository; <rty.repo>
#' @param cred credentials; <rty.cred>
#'
#' @return <rty.profile>
#' @export
#'
profile <- function(repo = get_repo(), cred = get_cred()){
  assert_argument_class(repo, "rty.repo")
  assert_argument_class(cred, "rty.cred")

  structure(list(repo = repo,
                 cred = cred),
            class = "rty.profile")
}

#' @method print rty.profile
#' @export
print.rty.profile <- function(x, ...){
  cat("Artifactory Profile\n")
  cat("\t"); print(x$repo); cat("\n")
  cat("\t"); print(x$cred)
}
