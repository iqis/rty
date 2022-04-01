#' Artifactory Credentials
#'
#' @name cred
#'
#' @param key API Key; <character>
#' @param token Bearer token; <character>
#' @param user_name User Name; <character>
#' @param password Password; <character>
#'
#'
NULL

#' @rdname cred
#' @export
api_key <- function(key){
  if (nchar(key) != 73 | !is_one_string(key)) {
    warning(warnings$malformed_api_key(73,
                                       nchar(key)))
  }
  key <- one_string(key)

  structure(c(`X-JFrog-Art-Api` = key),
            class = c("rt.cred.api_key",
                      "rt.cred"),
            key = key)
}

#' @method print rt.cred.api_key
#' @export
print.rt.cred.api_key <- function(x, ...){
  cat(sprintf("<Artifactory Credential: API Key>"))
}

#' @rdname cred
#' @export
token <- function(token){
  if (nchar(token) != 795 | !is_one_string(token)) {
    warning(warnings$malformed_auth_token(795,
                                          nchar(token)))
  }
  token <- one_string(token)

  structure(c(`Authorization` = paste("Bearer", token)),
            class = c("rt.cred.token",
                      "rt.cred"),
            token = token)
}

#' @method print rt.cred.token
#' @export
print.rt.cred.token <- function(x, ...){
  cat(sprintf("<Artifactory Credential: Token>"))
}


#' @rdname cred
#' @export
user_password <- function(user_name, password){
  user_name <- one_string(user_name)
  passworkd <- one_string(password)

  structure(paste0(user_name, ":", password),
            class = c("rt.cred.user_password",
                      "rt.cred"),
            user_name = user_name,
            password = password)
}

#' @method print rt.cred.user_password
#' @export
print.rt.cred.user_password <- function(x, ...){
  cat(sprintf("<Artifactory Credential: User/Password>"))
}
