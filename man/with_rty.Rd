% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{with_rty}
\alias{with_rty}
\title{Evaluate any Expression with rty Namespace}
\usage{
with_rty(expr)
}
\arguments{
\item{expr}{expression; <any>}
}
\value{
<any>
}
\description{
rty Namespace is attached to the calling scope
}
\examples{
\dontrun{
rty::with_rty({
  install("my-package",
          profile(repo("my-repository",
                       "https://artifactory.my.domain/artifactory/"),
                  api_key("[paste API key]")))
})
}
}
