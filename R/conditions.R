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

errors <- list()

errors$wrong_argument_class <- function(argument_name, expected_class, observed_classes){
  errorCondition(sprintf("Argument `%s` is expected to be of class <%s>, but is observed to be <%s>",
                         argument_name,
                         expected_class,
                         paste(observed_classes, collapse = ", ")),
                 expected_class = expected_class,
                 observed_class = observed_classes,
                 class = c("rt.error.wrong_argument_class",
                           "rt.error"))
}

errors$malformed_url <- function(url){
  errorCondition(sprintf("Artifactory URL %s is malformed.",
                         url),
                 class = c("rt.error.malformed_url",
                           "rt.error"))
}

errors$undefined_repo <- function(name){
  errorCondition(sprintf("Artifactory repository by the name of \"%s\" is undefined in this session, set it with `rt::set_repo()` first.",
                         name),
                 class = c("rt.error.undefined_repo",
                           "rt.error"))
}

errors$undefined_cred <- function(name){
  errorCondition(sprintf("Artifactory crednetials by the name of \"%s\" is undefined in this session, set it with `rt::set_cred()` first.",
                         name),
                 class = c("rt.error.undefined_cred",
                           "rt.error"))
}

errors$failed_deployment <- function(file, repo, response){
  errorCondition(sprintf("Deployment of \"%s\" to %s at %s have failed.",
                         file,
                         attr(repo, "name"),
                         attr(repo, "profile")),
                 class = c("rt.error.failed_deployment",
                           "rt.error"),
                 response = response)
}


warnings <- list()

warnings$malformed_api_key <- function(expected_nchar, observed_nchar){
  warningCondition(sprintf("Artifactory API Key is possibly malformed. Expected number of characters is %s but got %s",
                           expected_nchar,
                           observed_nchar),
                   class = c("rt.warning.malformed_api_key",
                             "rt.warning"))
}

warnings$malformed_token <- function(expectec_nchar, observed_nchar){
  warningCondition(sprintf("Artifactory Bearer Token is possibly malformed. Expected number of characters is %s but got %s",
                           expected_nchar,
                           observed_nchar),
                   class = c("rt.warning.malformed_token",
                             "rt.warning"))
}
