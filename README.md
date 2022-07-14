# rt

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/iqis/rt/workflows/R-CMD-check/badge.svg)](https://github.com/iqis/rt/actions)
<!-- badges: end -->

Build and install packages to and from CRAN-like repositories on Artifactory. Set up and manage user enrivonment to keep track of repositories and credentials.

## Installation

``` r
# install.packages("devtools")
devtools::install_github("iqis/rt")
```

## Example
The `rt` package is mainly designed to be used unattached to avoid masking names from other packages. If you do not want to refer to `rt` functions with qualified name, use `{r} rt::with_rt()`

#### Repository & Credentials

Define a repository.
``` r
rt::repo("my-repository",
         "https://artifactory.my.domain/artifactory/")
```
You can assign a name to the repository object and use it later.
``` r 
my_repository_on_my_domain <- rt::repo("my-repository",
                                       "https://artifactory.my.domain/artifactory/")
my_repository_on_my_domain
``` 

You can also cache the object in R session's `option` space.
``` r
rt::set_repo(rt::repo("my-repository",
                      "https://artifactory.my.domain/artifactory/"), 
             "my_repository_on_my_domain")
rt::get_repo("my_repository_on_my_domain")
```

There are two kinds of credentials, and can be handled the same say. 
```r
rt::set_cred(rt::api_key("[paste API key]"), 
             "my-api-key")

my_token <- rt::token("[paste token]")

rt::get_cred("my-api-key")
my_token
```

Repository and Credentials together makes a Profile.
```r
my_profile <- rt::profile(rt::get_repo("my_repository_on_my_domain"), 
                          my_token)
```

#### Deploy & Install Package 

Profile is used to access the repository. 

Deploy a package
``` r
rt::deploy("../my_package_0.0.1.9000.tar.gz", 
           my_profile)
```

See available packages 

```r
rt::available(my_profile)
```

Install a package
```r
rt::install("my_package", 
            my_profile)
```
