#' Install Package from CRAN-like Repository on Artifactory
#'
#' @param name Name of the package; <character>
#' @param profile Artifactory profile; <rty.profile>
#' @param version Version of the package, latest when NULL; <character, NULL>
#' @param ... dot-dot-dot, passed into `utils::install.packages()`
#'
#' @return NULL
#' @export
#'
install <- function(name, profile = rty::profile(), version = NULL, ...){
  name <- one_string(name)
  assert_argument_class(profile, "rty.profile")

  if (inherits(profile$cred, "rty.cred.api_key") | inherits(profile$cred, "rty.cred.token")) {
    if (is.null(version)) {
      utils::install.packages(pkgs = name,
                              repos = profile$repo,
                              headers = profile$cred,
                              ...)
    }

    if (!is.null(version)) {
      archive_contrib_url <- file.path(profile$repo,
                                       "src/contrib/Archive",
                                       name,
                                       version,
                                       paste0(name, "_", version, ".tar.gz"),
                                       fsep = "/")

      utils::install.packages(archive_contrib_url,
                              repos = NULL,
                              type = "source",
                              headers = profile$cred)
    }

  } else if (inherits(profile$cred, "rty.cred.user_password")) {
      stop("user/password authentication is not supported yet.")
  }
  invisible()
}


#' Deploy Package to CRAN-like Repository on Artifactory
#'
#' @param file path to an R package binary file; <character>
#' @param profile Artifactory profile; <rty.profile>
#'
#' @return NULL
#' @export
#'
deploy <- function(file, profile = rty::profile()){
  file <- one_string(file)
  assert_argument_class(profile, "rty.profile")

  if (!grepl("\\.tar\\.gz$", file)) {
    stop("{file} argument must end with extention \".tar.gz\"")
  }

  if (inherits(profile$cred, "rty.cred.api_key")) {

        response <- httr::POST(api_endpoint(profile$repo),
                           httr::add_headers(.headers = profile$cred),
                           body = httr::upload_file(file))

    if (response$status_code != 201) {
      stop(errors$failed_deployment(file,
                                    profile$repo,
                                    response))
    }
        return(response)

  } else if (inherits(profile$cred, "rty.cred.token")) {
    stop("Deploying with Token is not supported yet.")
  } else if (inherits(profile$cred, "rty.cred.user_password")) {
    stop("Deploying with User/Password is not supported yet.")
  }
}


#' Build to Artifactory
#'
#' @param pkg directory path to package source code; <character>
#' @param profile Artifactory profile; <rty.profile>
#' @param ... dot-dot-dot, passed into `devtools::build()`
#'
#' @return NULL
#' @export
#'
build_deploy <- function(pkg = ".",
                         profile = rty::profile(),
                         ...){
  pkg <- one_string(pkg)
  assert_argument_class(profile, "rty.profile")

  dest_dir <- tempdir()
  dest_file <- file.path(dest_dir, ".rty_build.tar.gz")

  devtools::build(pkg,
                  path = dest_file,
                  ...)

  deploy(file = dest_file,
         profile = profile)
}


#' Available Packages
#'
#' @param profile Artifactory profile; <rty.profile>
#' @param ... dot-dot-dot, passed into `utils::available.packages()`
#'
#' @return <matrix>
#' @export
#'
available <- function(profile = rty::profile(),
                      ...){
  assert_argument_class(profile, "rty.profile")

  utils::available.packages(utils::contrib.url(unclass(profile$repo)),
                            headers = profile$cred,
                            ...)
}


# download <- function(file, profile = profile()){
#
#   download.file(file.path(my_repo,
#                           "/src/contrib/PACKAGES"),
#                 "PACKAGES.try",
#                 headers = profile$cred)
# }
#
# upload <- function(){
#
# }
