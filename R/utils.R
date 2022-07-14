#' Create "one string" of Characters
#'
#' Create a non-NA, non-empty(""), <character> vector with length 1.
#'
#' @param chr <character|!NA>
#'
#' @return <rty.one_string>
#'
one_string <- function(chr){
  if (!is_one_string(chr)) {
    stop(errors$malformed_one_string(chr))
  }
  structure(chr,
            class = "rty.one_string")
}

is_one_string <- function(chr){
  all(is.character(chr),
      length(chr) == 1,
      !is.na(chr),
      !chr == "")
}


#' Evaluate any Expression with rty Namespace
#'
#' rty Namespace is attached to the calling scope
#'
#' @param expr expression; <any>
#'
#' @return <any>
#' @export
#'
#' @examples
#' \dontrun{
#' rty::with_rty({
#'   install("my-package",
#'           profile(repo("my-repository",
#'                        "https://artifactory.my.domain/artifactory/"),
#'                   api_key("[paste API key]")))
#' })
#' }
with_rty <- function(expr){
  rty_env <- asNamespace("rty")
  parent.env(parent.env(rty_env)) <- globalenv()

  eval_env <- new.env(parent = parent.frame())

  eval(substitute(expr),
       eval_env)
}
