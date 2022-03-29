#' Install Package from CRAN-like Repository on Artifactory
#'
#' @param name Name of the package; <character>
#' @param profile Artifactory profile; <rt.profile>
#' @param ... dot-dot-dot, passed into `utils::install.packages()`
#'
#' @return NULL
#' @export
#'
install <- function(name, profile = profile(), ...){
  name <- one_string(name)
  assert_argument_class(repo, "rt.profile")

  if (inherits(profile$cred, "rt.cred.api_key") | inherits(profile$cred, "rt.cred.bearer_token")) {
    utils::install.packages(pkgs = name,
                     repos = profile$repo,
                     headers = profile$cred,
                     ...)
  } else if (inherits(profile$cred, "rt.cred.user_password")) {
    stop("user/password authentication is not supported yet.")
  }
  invisible(NULL)
}


#' Deploy Package to CRAN-like Repository on Artifactory
#'
#' @param file path to an R package binary file; <character>
#' @param profile Artifactory profile; <rt.profile>
#'
#' @return NULL
#' @export
#'
deploy <- function(file, profile = profile()){
  file <- one_string(file)
  assert_argument_class(profile, "rt.profile")

  if (!grepl("\\.tar\\.gz$", file)) {
    stop("{file} argument must end with extention \".tar.gz\"")
  }

  if (inherits(profile$cred, "rt.cred.api_key")) {
    system(sprintf('curl -H "X-JFrog-Art-Api:%s" -T %s -XPOST "%s"',
                   attr(profile$cred, "key"),
                   file,
                   api_endpoint(profile$repo)))
  } else if (inherits(profile$cred, "rt.cred.bearer_token")) {
    stop("Deploying with Bearer Token is not supported yet.")
  } else if (inherits(profile$cred, "rt.cred.user_password")) {
    stop("Deploying with User/Password is not supported yet.")
  }
  invisible(NULL)
}


#' Build to Artifactory
#'
#' @param pkg directory path to package source code; <character>
#' @param profile Artifactory profile; <rt.profile>
#' @param ... dot-dot-dot, passed into `devtools::build()`
#'
#' @return NULL
#' @export
#'
build_deploy <- function(pkg = ".",
                         profile,
                         ...){
  pkg <- one_string(pkg)
  assert_argument_class(profile, "rt.profile")

  dest_dir <- tempdir()
  dest_file <- file.path(dest_dir, ".rt_build.tar.gz")

  devtools::build(pkg,
                  path = dest_file,
                  ...)

  deploy(file = dest_file,
         profile = profile)

  invisible(TRUE)
}


#' Available Packages
#'
#' @param profile Artifactory profile; <rt.profile>
#' @param ... dot-dot-dot, passed into `utils::available.packages()`
#'
#' @return <matrix>
#' @export
#'
available <- function(profile = profile(),
                      ...){
  assert_argument_class(profile, "rt.profile")

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
