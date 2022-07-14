#' Set and Get Artifactory Profile Elements from Session Options
#'
#' @name option_accessors
#'
#' @param repo Artifactory repository; <rty.repo>
#' @param cred Artifactory credentials; <rty.cred>
#' @param name name of the element; <character>
#'
#'
NULL


#' @rdname option_accessors
#' @export
set_repo <- function(repo, name = "default"){
  assert_argument_class(repo, "rty.repo")
  name <- one_string(name)

  # initialize if empty
  if (is.null(getOption("rty.repos"))) {
    options(rty.repos = list())
  }

  my_repos <- getOption("rty.repos")
  my_repos[[name]] <- repo

  options(rty.repos = my_repos)

  invisible(repo)
}

#' @rdname option_accessors
#' @export
get_repo <- function(name = "default"){
  name <- one_string(name)

  res <- getOption("rty.repos")[[name]]
  if (is.null(res)) {
    stop(errors$undefined_repo(name))
  } else {
    res
  }
}


#' @rdname option_accessors
#' @export
set_cred <- function(cred, name = "default"){
  assert_argument_class(cred, "rty.cred")

  name <- one_string(name)

  # initialize if empty
  if (is.null(getOption("rty.creds"))) {
    options(rty.creds = list())
  }

  my_creds <- getOption("rty.creds")
  my_creds[[name]] <- cred

  options(rty.creds = my_creds)

  invisible(cred)
}


#' @rdname option_accessors
#' @export
get_cred <- function(name = "default"){
  name <- one_string(name)

  res <- getOption("rty.creds")[[name]]
  if (is.null(res)) {
    stop(errors$undefined_cred(name))
  } else {
    res
  }
}
