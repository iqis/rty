#' Artifactory Profile
#'
#' The Artifactory profile is the combination of repository and credential.
#'
#' @param repo repository; <rt.repo>
#' @param cred credential; <rt.cred>
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
  cat("Artifactory Profile")
  print(x$repo)
  print(x$cred)
}
