#' Internal function - generic downloader, used to serve the data files
#'
#' @param file file to be downloaded (or not...)
#' @keywords internal
#' @importFrom utils read.csv

downloader <- function(file) {
  network <- as.logical(Sys.getenv("NETWORK_UP", unset = TRUE)) # dummy variable to allow testing of network
  aws <- as.logical(Sys.getenv("DATA_UP", unset = TRUE)) # dummy variable to allow testing of network

  remote_path <- "https://gis-a.ie.ehealthafrica.org/geoserver/eHA_db/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=eHA_db:" # remote archive

  remote_file <- paste0(remote_path, file, "&outputFormat=csv") # path to Geoserver
  local_file <- paste0(tempdir(), "/", file, ".csv") # local file - in tempdir

  if (file.exists(local_file)) {
    message("Using temporary local dataset.")
  } else {
    if (!curl::has_internet() | !network) { # network is down
      message("No internet connection.")
      return(NULL)
    }

    if (httr::http_error(remote_file) | !aws) { # remote data down
      message("Data source broken.")
      return(NULL)
    }

    # proceed to download via curl
    message("Downloading remote dataset.")
    curl::curl_download(url = remote_file, destfile = local_file, quiet = F)
  } # /if - local file exists

  local_df <- read.csv(local_file, stringsAsFactors = F)
  local_df
} # /function
