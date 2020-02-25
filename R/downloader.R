#' Internal function - generic downloader, used to serve the data files
#'
#' @param file file to be downloaded (or not...)
#' @keywords internal
#' @importFrom utils read.csv
#' @importFrom magrittr %>%
#' @importFrom sf st_as_sf

downloader <- function(file) {

  remote_path <- "https://gis-a.ie.ehealthafrica.org/geoserver/eHA_db/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=eHA_db:" # remote archive

  remote_file <- paste0(remote_path, file, "&outputFormat=csv") # path to Geoserver
#  local_file <- paste0(tempdir(), "/", file, ".csv") # local file - in tempdir

  local_file <- "~/Downloads/sv_states.csv" # beware! for dev purposes only...

  if (file.exists(local_file)) {
    message("Using temporary local dataset.")
  } else {
    if (!curl::has_internet()) { # network is down
      message("No internet connection.")
      return(NULL)
    }

    if (httr::http_error(remote_file)) { # remote data down
      message("Data source broken.")
      return(NULL)
    }

    # proceed to download via curl
    message("Downloading remote dataset.")
    curl::curl_download(url = remote_file, destfile = local_file, quiet = F)
  } # /if - local file exists

  local_df <- read.csv(local_file, stringsAsFactors = F) %>%
    dplyr::select(-"FID", -"timestamp") %>%
    sf::st_as_sf(wkt = "geom", crs = 4326)

  local_df
} # /function
