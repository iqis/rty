#' Create "one string" of Characters
#'
#' Create a non-NA, non-empty(""), <character> vector with length 1.
#'
#' @param chr <character|!NA>
#'
#' @return <rt.one_string>
#'
one_string <- function(chr){
  stopifnot(is_one_string(chr))
  structure(chr,
            class = "rt.one_string")
}

is_one_string <- function(chr){
  all(is.character(chr),
      length(chr) == 1,
      !is.na(chr),
      !chr == "")
}


#' Evaluate any Expression with rt Namespace
#'
#' rt Namespace is attached to the calling scope
#'
#' @param expr expression; <any>
#'
#' @return <any>
#' @export
#'
#' @examples
#' \dontrun{
#' rt::with_rt({
#'   install("my-package",
#'           profile(repo("my-repository",
#'                        "https://artifactory.my.domain/artifactory/"),
#'                   api_key("[paste API key]")))
#' })
#' }
with_rt <- function(expr){
  rt_env <- asNamespace("rt")
  parent.env(parent.env(rt_env)) <- globalenv()

  eval_env <- new.env(parent = parent.frame())

  eval(substitute(expr),
       eval_env)
}
