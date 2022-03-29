assert_argument_class <- function(argument, expected_class){
  argument_name <- as.character(substitute(argument))
  expected_class <- one_string(expected_class)
  observed_class <- class(argument)[1] # chose only the prevailing class

  if (inherits(argument, expected_class)) {
    stop(errors$wrong_argument_class(argument_name,
                                     expected_class,
                                     observed_class))
  }
}

errors <- list()

errors$wrong_argument_class <- function(argument_name, expected_class, observed_class){
  errorCondition(spritnf("Argument %s is expected to be of class <%s>, but is observed to be <%s>",
                         argument_name,
                         expected_class,
                         observed_class),
                 expected_class = expected_class,
                 observed_class = observed_class,
                 class = "rt.error.wrong_argument_class")
}

errors$malformed_url <- function(url){
  errorCondition(sprintf("Artifactory URL %s is malformed.",
                         url),
                 class = "rt.error.malformed_url")
}

errors$undefined_repo <- function(name){
  errorCondition(sprintf("Artifactory repository by the name of \"%s\" is undefined in this session, set it with `rt::set_repo()` first.",
                         name),
                 class = "rt.error.undefined_repo")
}

errors$undefined_cred <- function(name){
  errorCondition(sprintf("Artifactory crednetials by the name of \"%s\" is undefined in this session, set it with `rt::set_cred()` first.",
                         name),
                 class = "rt.error.undefined_cred")
}
