#' Artifactory Repository
#'
#' @param name Name for the repository; <character>
#' @param root Root URL to Arifactory instance; <character>
#'
#' @return <rt.repo>
#' @export
#'
repo <- function(name, root){
  name <- one_string(name)
  root <- one_string(root)
  # assert root is valid URL
  if (!grepl("https?://[^\\s/$.?#].[^\\s]*", root)) {
    stop(errors$malformed_url(root))
  }

  # trim "/"s
  name <- gsub("^\\/|\\/$", "", name)
  root <- gsub("^\\/|\\/$", "", root)

  res <- file.path(root, name)
  names(res) <- name

  structure(res,
            class = "rt.repo",
            name = name,
            root = root)
}

#' Create API Endpoint from Artifactory Repository
#'
#' This endpoint is particular to submitting source code to a CRAN-type repository.
#'
#' @param repo Artifactory repository; <rt.repo>
#'
#' @return <rt.api_endpoint>
api_endpoint <- function(repo){
  assert_argument_class(repo, "rt.repo")

  # explode attrs
  name <- attr(repo, "name")
  root <- attr(repo, "root")

  structure(file.path(root, "api", "cran", name, "source"),
            class = "rt.api_endpoint")
}


