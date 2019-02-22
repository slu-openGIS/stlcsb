## Release summary
This is the initial CRAN submission.

## Test environments
* local OS X install, R 3.5.2
* ubuntu 14.04 (on Travis CI), R-release, R-oldrel, R-devel
* macOS (on Travis CI), R-release, R-oldrel
* windows i386 (on Appveyor), R-release, R-oldrel, R-devel
* windows x64 (on Appveyor), R-release, R-oldrel, R-devel
* winbuilder, R-release, R-devel

## R CMD check results
* There were no ERRORs, WARNINGs, or NOTEs with local checks or on Travis CI/Appveyor.

* winbuilder and `devtools::release()` both note that this is a new submission to CRAN
* winbuilder identified several words that may be misspelled in the `DESCRIPTION` file - all are correct
* winbuilder (R-release) has a note about issues coverting the ORCID ID to a URL

## Reverse dependencies
Not applicable.
