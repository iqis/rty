#' Artifactory Profile
#'
#' An Artifactory profile is the combination of Repository and Credentials.
#'
#' @param repo repository; <rt.repo>
#' @param cred credentials; <rt.cred>
#'
#' @return <rt.profile>
#' @export
#'
profile <- function(repo = get_repo(), cred = get_cred()){
  assert_argument_class(repo, "rt.repo")
  assert_argument_class(cred, "rt.cred")

  structure(list(repo = repo,
                 cred = cred),
            class = "rt.profile")
}

#' @method print rt.profile
#' @export
print.rt.profile <- function(x, ...){
  cat("Artifactory Profile\n")
  cat("\t"); print(x$repo); cat("\n")
  cat("\t"); print(x$cred)
}
