#' Store CSB API Key
#'
#' @description \code{csb_api_key} can be used to store your CSB API key in your \code{.Renviron} for repeated use.
#' Your API key will be securely called without having to reveal it in your code. After installing your key, it can be called any time by typing \code{Sys.getenv("CSB_API_KEY")} and can be
#' used in package functions by simply typing CSB_API_KEY If you do not have an \code{.Renviron} file, the function will create one for you.
#' If you already have an \code{.Renviron} file, the function will append the key to your existing file, while making a backup of your
#' original file for data recovery purposes.
#'   This function is adapted from the \href{https://github.com/walkerke/tidycensus}{tidycensus} package.
#' @usage csb_api_key(key, install, overwrite)
#' @param key The API key provided to you by the City of Saint Louis, formatted in quotes. A key can be aquired \href{https://www.stlouis-mo.gov/government/departments/information-technology/web-development/city-api/sign-up.cfm}{Here}
#' @param install If TRUE, will install the key in your \code{.Renviron} file for use in future sessions. Defaults to FALSE.
#' @param overwrite If TRUE, will overwrite an existing CSB_API_KEY that you already have in your \code{.Renviron}
#'
#' @importFrom utils write.table read.table
#' @export
csb_api_key <- function(key, overwrite = FALSE, install = FALSE){

  if (install) {
    home <- Sys.getenv("HOME")
    renv <- file.path(home, ".Renviron")
    if(file.exists(renv)){
      # Backup original .Renviron before doing anything else here.
      file.copy(renv, file.path(home, ".Renviron_backup"))
    }
    if(!file.exists(renv)){
      file.create(renv)
    }
    else{
      if(isTRUE(overwrite)){
        message("Your original .Renviron will be backed up and stored in your R HOME directory if needed.")
        oldenv=read.table(renv, stringsAsFactors = FALSE)
        newenv <- oldenv[-grep("CSB_API_KEY", oldenv),]
        write.table(newenv, renv, quote = FALSE, sep = "\n",
                    col.names = FALSE, row.names = FALSE)
      }
      else{
        tv <- readLines(renv)
        if(any(grepl("CSB_API_KEY",tv))){
          stop("A CSB_API_KEY already exists. You can overwrite it with the argument overwrite=TRUE", call.=FALSE)
        }
      }
    }

    keyconcat <- paste0("CSB_API_KEY='", key, "'")
    # Append API key to .Renviron file
    write(keyconcat, renv, sep = "\n", append = TRUE)
    message('Your API key has been stored in your .Renviron and can be accessed by Sys.getenv("CSB_API_KEY"). \nTo use now, restart R or run `readRenviron("~/.Renviron")`')
    return(key)
  } else {
    message("To install your API key for use in future sessions, run this function with `install = TRUE`.")
    Sys.setenv(CSB_API_KEY = key)
  }

}
