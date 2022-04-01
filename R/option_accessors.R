#' Set and Get Artifactory Profile Elements from Session Options
#'
#' @name option_accessors
#'
#' @param repo Artifactory repository; <rt.repo>
#' @param cred Artifactory credentials; <rt.cred>
#' @param name name of the element; <character>
#'
#'
NULL


#' @rdname option_accessors
#' @export
set_repo <- function(repo, name = "default"){
  assert_argument_class(repo, "rt.repo")
  name <- one_string(name)

  # initialize if empty
  if (is.null(getOption("rt.repos"))) {
    options(rt.repos = list())
  }

  my_repos <- getOption("rt.repos")
  my_repos[[name]] <- repo

  options(rt.repos = my_repos)

  invisible(repo)
}

#' @rdname option_accessors
#' @export
get_repo <- function(name = "default"){
  name <- one_string(name)

  res <- getOption("rt.repos")[[name]]
  if (is.null(res)) {
    stop(errors$undefined_repo(name))
  } else {
    res
  }
}


#' @rdname option_accessors
#' @export
set_cred <- function(cred, name = "default"){
  # assert_argument_class(cred, "rt.cred")

  name <- one_string(name)

  # initialize if empty
  if (is.null(getOption("rt.creds"))) {
    options(rt.creds = list())
  }

  my_creds <- getOption("rt.creds")
  my_creds[[name]] <- cred

  options(rt.creds = my_creds)

  invisible(cred)
}


#' @rdname option_accessors
#' @export
get_cred <- function(name = "default"){
  name <- one_string(name)

  res <- getOption("rt.creds")[[name]]
  if (is.null(res)) {
    stop(errors$undefined_cred(name))
  } else {
    res
  }
}
