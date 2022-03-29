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
  key <- one_string(key)

  structure(c(`X-JFrog-Art-Api` = key),
            class = c("rt.cred.api_key",
                      "rt.cred"),
            key = key)
}

#' @rdname cred
#' @export
bearer_token <- function(token){
  token <- one_string(token)

  structure(c(`Authorization` = paste("Bearer", token)),
            class = c("rt.cred.auth_token",
                      "rt.cred"),
            token = token)
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

