#' Administrative boundaries
#'
#' This is a function returning admin area boundaries
#'
#' @param type one of
#'
#' @return data frame
#' @export
#' @importFrom magrittr %>%
#' @importFrom sf st_as_sf
#'
#'

admin_boundaries <- function(type) {
  translator <- c("ward_admin_boundaries" = "sv_wards",
                  "lga_admin_boundaries" = "sv_local_government_areas",
                  "state_admin_boundaries" = "sv_states")

  if(!type %in% names(translator)) stop("Unknown administrative area!")

#  downloader(translator[type]) # commented out until certificate issue gets resolved

  data <- read.csv("~/Downloads/sv_local_government_areas.csv", stringsAsFactors = F) %>%
#    dplyr::select(-FID, -timestamp) %>%
    sf::st_as_sf(wkt = "geom", crs = 4326)

  data

}
