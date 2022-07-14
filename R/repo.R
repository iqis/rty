#' Artifactory Repository
#'
#' @param name Name for the repository; <character>
#' @param root Root URL to Arifactory instance; <character>
#'
#' @return <rty.repo>
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
            class = "rty.repo",
            name = name,
            root = root)
}

#' @method print rty.repo
#' @export
print.rty.repo <- function(x, ...){
  cat(sprintf("<Artifactory Repository>\n\"%s\" at \"%s\"",
              attr(x, "name"),
              attr(x, "root")))
}


#' Create API Endpoint from Artifactory Repository
#'
#' This endpoint is particular to submitting source code to a CRAN-type repository.
#'
#' @param repo Artifactory repository; <rty.repo>
#'
#' @return <rty.api_endpoint>
api_endpoint <- function(repo){
  assert_argument_class(repo, "rty.repo")

  # explode attrs
  name <- attr(repo, "name")
  root <- attr(repo, "root")

  structure(file.path(root, "api", "cran", name, "sources"),
            class = "rty.api_endpoint")
}
