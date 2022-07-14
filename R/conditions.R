#' Conditions
#'
#' @name conditions
#'
NULL


#' Asssert Argument Class
#'
#' @param argument argument; <any>
#' @param expected_class expected class; <rty.one_string>
#'
assert_argument_class <- function(argument, expected_class){
  argument_name <- as.character(substitute(argument))
  expected_class <- one_string(expected_class)
  observed_classes <- class(argument)

  if (!expected_class %in% observed_classes) {
    stop(errors$wrong_argument_class(argument_name,
                                     expected_class,
                                     observed_classes))
  }
}

#' @rdname conditions
errors <- list()

errors$malformed_one_string <- function(chr){
  errorCondition(sprintf("The character vector %s does not match the quiteria from rt:::is_one_string()",
                         chr),
                 class = c("rty.error.malformed_one_string",
                           "rty.error"))
}


errors$wrong_argument_class <- function(argument_name, expected_class, observed_classes){
  errorCondition(sprintf("Argument `%s` is expected to be of class <%s>, but is observed to be <%s>",
                         argument_name,
                         expected_class,
                         paste(observed_classes, collapse = ", ")),
                 expected_class = expected_class,
                 observed_class = observed_classes,
                 class = c("rty.error.wrong_argument_class",
                           "rty.error"))
}

errors$malformed_url <- function(url){
  errorCondition(sprintf("Artifactory URL %s is malformed.",
                         url),
                 class = c("rty.error.malformed_url",
                           "rty.error"))
}

errors$undefined_repo <- function(name){
  errorCondition(sprintf("Artifactory repository by the name of \"%s\" is undefined in this session, set it with `rty::set_repo()` first.",
                         name),
                 class = c("rty.error.undefined_repo",
                           "rty.error"))
}

errors$undefined_cred <- function(name){
  errorCondition(sprintf("Artifactory crednetials by the name of \"%s\" is undefined in this session, set it with `rty::set_cred()` first.",
                         name),
                 class = c("rty.error.undefined_cred",
                           "rty.error"))
}

errors$failed_deployment <- function(file, repo, response){
  errorCondition(sprintf("Deployment of \"%s\" to %s at %s have failed.",
                         file,
                         attr(repo, "name"),
                         attr(repo, "profile")),
                 class = c("rty.error.failed_deployment",
                           "rty.error"),
                 response = response)
}

#' @rdname conditions
warnings <- list()

warnings$malformed_api_key <- function(expected_nchar, observed_nchar){
  warningCondition(sprintf("Artifactory API Key is possibly malformed. Expected number of characters is %s but got %s",
                           expected_nchar,
                           observed_nchar),
                   class = c("rty.warning.malformed_api_key",
                             "rty.warning"))
}

warnings$malformed_token <- function(expected_nchar, observed_nchar){
  warningCondition(sprintf("Artifactory Bearer Token is possibly malformed. Expected number of characters is %s but got %s",
                           expected_nchar,
                           observed_nchar),
                   class = c("rty.warning.malformed_token",
                             "rty.warning"))
}
