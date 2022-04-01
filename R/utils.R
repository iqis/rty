#' Create "one string" of Characters
#'
#' Create a non-NA, non-empty(""), <character> vector with length 1.
#'
#' @param chr <character|!NA>
#'
#' @return <rt.one_string>
#'
one_string <- function(chr){
  stopifnot(all(is.character(chr),
                length(chr) == 1,
                !is.na(chr),
                !chr == ""))
  unclass(chr)
}
