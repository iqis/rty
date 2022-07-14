# rty

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/iqis/rty/workflows/R-CMD-check/badge.svg)](https://github.com/iqis/rty/actions)
[![Codecov test coverage](https://codecov.io/gh/iqis/rty/branch/main/graph/badge.svg)](https://app.codecov.io/gh/iqis/rty?branch=main)
<!-- badges: end -->

Build and install packages to and from CRAN-like repositories on Artifactory. Set up and manage user enrivonment to keep track of repositories and credentials.

## Installation

``` r
# install.packages("devtools")
devtools::install_github("iqis/rty")
```

## Example
The `rty` package is mainly designed to be used unattached to avoid masking names from other packages. If you do not want to refer to `rty` functions with qualified names, use `r rty::with_rty()`


### Repository & Credentials

``` r
# Define a repository
rty::repo("my-repository",
         "https://artifactory.my.domain/artifactory/")

# You can assign a name to the repository object and use it later.
my_repository_on_my_domain <- rty::repo("my-repository",
                                       "https://artifactory.my.domain/artifactory/")
my_repository_on_my_domain

# You can also cache the object in R session's `option` space.
rty::set_repo(rty::repo("my-repository",
                      "https://artifactory.my.domain/artifactory/"), 
             "my_repository_on_my_domain")
rty::get_repo("my_repository_on_my_domain")

# There are two kinds of credentials, and can be handled the same say. 
rty::set_cred(rty::api_key("[paste API key]"), 
             "my-api-key")

my_token <- rty::token("[paste token]")

rty::get_cred("my-api-key")
my_token
```

#### Profile 
Repository and Credentials together makes a Profile.
```r
my_profile <- rty::profile(rty::get_repo("my_repository_on_my_domain"), 
                          my_token)
```

### Deploy & Install Package 

Profile is used to access the repository by downsteam functions.

``` r
# Deploy a package
rty::deploy("../my_package_0.0.1.9000.tar.gz", 
           my_profile)

# See available packages 
rty::available(my_profile)

# Install a package
rty::install("my_package", 
             my_profile)

# Install a specific version from the Archive
rty::install("my_package", 
             my_profile, 
             version = "0.2.7")
```

### Using Defaults

If you are only working with one pair of Artifactory repository and credential, the function calls can be streamlined.

```r
# Consider including the following in your .Rprofile
rty::with_rty({
  set_repo(repo("my_repository", 
                "https://artifactory.my.domain/artifactory/"))
  set_cred(api_key("[paste API key]"))
})

# Then use 
rty::available()
rty::install("my_package")
```

#### Reminder: Protect Your Secrets
Please remember, never commit any credential to shared codebases. 
